;;;; List Box
;;;;
;;;; GtkListBox allows lists with complicated layouts, using
;;;; regular widgets supporting sorting and filtering.
;;;;
;;;; 2023-12-31

;; TODO: The implementation can be improved.

(in-package :gtk3-example)

(gobject:define-g-object-subclass "Message" message
  (:superclass g:object
   :export t
   :interfaces ())
  ((id
    message-id
    "id" "gint" t t)
   (name
    message-name
    "name" "gchararray" t t)
   (nick
    message-nick
    "nick" "gchararray" t t)
   (message
    message-message
    "message" "gchararray" t t)
   (time
    message-time
    "time" "guint" t t)
   (reply
    message-reply
    "reply" "gint" t t)
   (resent
    message-resent
    "resent" "gchararray" t t)
   (n-favorites
    message-n-favorites
    "n-favorites" "gint" t t)
   (n-reshares
    message-n-reshares
    "n-reshares" "gint" t t)))

(defun message-new (str)
  (let ((msg (make-instance 'message))
        (entries (split-sequence:split-sequence #\| str)))
    (setf (message-id msg) (parse-integer (pop entries) :junk-allowed t))
    (setf (message-name msg) (pop entries))
    (setf (message-nick msg) (pop entries))
    (setf (message-message msg) (pop entries))
    (setf (message-time msg) (parse-integer (pop entries)))
    (when entries
      (setf (message-reply msg) (parse-integer (pop entries))))
    (when entries
      (setf (message-resent msg) (pop entries)))
    (when entries
      (setf (message-n-favorites msg) (parse-integer (pop entries))))
    (when entries
      (setf (message-n-reshares msg) (parse-integer (pop entries))))
    msg))

;; FIXME: The slot MESSAGE should be of type Message and not GObject, but this
;; does not work as expected. At compile time the type Message is not known
;; to the GType system. Improve this?!

(gobject:define-g-object-subclass "MessageRow" message-row
  (:superclass gtk:list-box-row
   :export t
   :interfaces ())
  ((message
    message-row-message
    "message" "GObject" t t)
   (details-revealer
    message-row-details-revealer
    "details-revealer" "GtkWidget" t t)
   (avatar-image
    message-row-avatar-image
    "avator-image" "GtkWidget" t t)
   (extra-buttons-box
    message-row-extra-buttons-box
    "extra-buttons-box" "GtkWidget" t t)
   (content-label
    message-row-content-label
    "content-label" "GtkWidget" t t)
   (source-name
    message-row-source-name
    "source-name" "GtkWidget" t t)
   (source-nick
    message-row-source-nick
    "source-nick" "GtkWidget" t t)
   (short-time-label
    message-row-short-time-label
    "short-time-label" "GtkWidget" t t)
   (detailed-time-label
    message-row-detailed-time-label
    "detailed-time-label" "GtkWidget" t t)
   (resent-box
    message-row-resent-box
    "resent-box" "GtkWidget" t t)
   (resent-by-button
    message-row-resent-by-button
    "resent-by-button" "GtkWidget" t t)
   (n-favorites-label
    message-row-n-favorites-label
    "n-favorites-label" "GtkWidget" t t)
   (n-reshares-label
    message-row-n-reshares-label
    "n-reshares-label" "GtkWidget" t t)
   (expand-button
    message-row-expand-button
    "expand-button" "GtkWidget" t t)))

(defun message-row-expand (row)
  (let* ((revealer (message-row-details-revealer row))
         (expand (not (gtk:revealer-reveal-child revealer)))
         (button (message-row-expand-button row)))
    (setf (gtk:revealer-reveal-child revealer) expand)
    (if expand
        (setf (gtk:button-label button) "Hide")
        (setf (gtk:button-label button) "Expand"))))

(defun message-row-update (row)
  (let ((message (message-row-message row)))
    (gtk:image-set-from-file (message-row-avatar-image row)
                             (sys-path "resource/apple-red.png"))

    (setf (gtk:label-label (message-row-source-name row))
          (message-name message))
    (setf (gtk:label-label (message-row-source-nick row))
          (message-nick message))
    (setf (gtk:label-label (message-row-content-label row))
          (message-message message))
    (multiple-value-bind-some
        (second minute hour date month year nil nil nil)
      (decode-universal-time (message-time message))
      (setf (gtk:label-label (message-row-short-time-label row))
            (format nil "~a.~a.~a" date month (+ year 70)))
      (setf (gtk:label-label (message-row-detailed-time-label row))
            (format nil "~a:~a:~a - ~a.~a.~a"
                        hour minute second date month (+ year 70))))
    (let ((n-favorites-label (message-row-n-favorites-label row))
          (n-favorites (message-n-favorites message)))
      (setf (gtk:widget-visible n-favorites-label)
            (not (= 0 n-favorites)))
      (gtk:label-set-markup n-favorites-label
                            (format nil "<b>~a</b>~%Favorites" n-favorites)))
    (let ((n-reshares-label (message-row-n-reshares-label row))
          (n-reshares (message-n-reshares message)))
      (setf (gtk:widget-visible n-reshares-label)
            (not (= 0 n-reshares)))
      (gtk:label-set-markup n-reshares-label
                            (format nil "<b>~a</b>~%Reshares" n-reshares)))
    (let ((resent-box (message-row-resent-box row))
          (resent-by-button (message-row-resent-by-button row))
          (resent-by (message-resent message)))
      (setf (gtk:widget-visible resent-box)
            (not (= 0 (length resent-by))))
      (when (not (= 0 (length resent-by)))
        (setf (gtk:button-label resent-by-button) resent-by))
    )))

(defun message-row-new (message)
  (let* ((builder (gtk:builder-new-from-file (sys-path "resource/list-box.ui")))
         (row (gtk:builder-object builder "messagerow")))
    (setf (message-row-message row) message)
    (setf (message-row-details-revealer row)
          (gtk:builder-object builder "details_revealer"))
    (setf (message-row-avatar-image row)
          (gtk:builder-object builder "avatar_image"))
    (setf (message-row-extra-buttons-box row)
          (gtk:builder-object builder "extra_buttons_box"))
    (setf (message-row-content-label row)
          (gtk:builder-object builder "content_label"))
    (setf (message-row-source-name row)
          (gtk:builder-object builder "source_name"))
    (setf (message-row-source-nick row)
          (gtk:builder-object builder "source_nick"))
    (setf (message-row-short-time-label row)
          (gtk:builder-object builder "short_time_label"))
    (setf (message-row-detailed-time-label row)
          (gtk:builder-object builder "detailed_time_label"))
    (setf (message-row-resent-box row)
          (gtk:builder-object builder "resent_box"))
    (setf (message-row-resent-by-button row)
          (gtk:builder-object builder "resent_by_button"))
    (setf (message-row-n-favorites-label row)
          (gtk:builder-object builder "n_favorites_label"))
    (setf (message-row-n-reshares-label row)
          (gtk:builder-object builder "n_reshares_label"))
    (setf (message-row-expand-button row)
          (gtk:builder-object builder "expand_button"))
    (message-row-update row)
    (g:signal-connect (gtk:builder-object builder "expand_button") "clicked"
        (lambda (button)
          (declare (ignore button))
          (message-row-expand row)))
    (g:signal-connect (gtk:builder-object builder "reshare_button") "clicked"
        (lambda (button)
          (declare (ignore button))
          (let ((message (message-row-message row)))
            (incf (message-n-reshares message))
            (message-row-update row))))
    (g:signal-connect (gtk:builder-object builder "favorite_button") "clicked"
        (lambda (button)
          (declare (ignore button))
          (let ((message (message-row-message row)))
            (incf (message-n-favorites message))
            (message-row-update row))))
    row))

(defun example-list-box (&optional application)
  (gtk:within-main-loop
    (let ((window (make-instance 'gtk:window
                                  :type :toplevel
                                  :application application
                                  :title "List Box"
                                  :default-width 600
                                  :default-height 400))
          (vbox (make-instance 'gtk:box
                               :orientation :vertical
                               :spacing 12))
          (label (make-instance  'gtk:label
                                 :label "Messages from GTK and friends"))
          (scrolled (make-instance 'gtk:scrolled-window
                                   :hscrollbar-policy :never
                                   :vscrollbar-policy :automatic))
          (listbox (make-instance 'gtk:list-box
                                  :activate-on-single-click nil)))
      (g:signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (gtk:leave-gtk-main)))
      (gtk:container-add window vbox)
      (gtk:box-pack-start vbox label :expand nil)
      (gtk:box-pack-start vbox scrolled)
      (gtk:container-add scrolled listbox)
      (gtk:list-box-set-sort-func listbox
          (lambda (row1 row2)
            (- (message-time (message-row-message row2))
               (message-time (message-row-message row1)))))
      (g:signal-connect listbox "row-activated"
                        (lambda (listbox row)
                          (declare (ignore listbox))
                          (message-row-expand row)))
      (with-open-file (stream (sys-path "resource/list-box-message.txt"))
        (format t "Loading the messages ... ~%")
        (do ((msg nil) (row nil)
             (line (read-line stream nil)
                   (read-line stream nil)))
            ((null line))
          (setf msg (message-new line))
          (setf row (message-row-new msg))
          (gtk:widget-show-all row)
          (gtk:container-add listbox row)))
      ;; Show the window.
      (gtk:widget-show-all window))))
