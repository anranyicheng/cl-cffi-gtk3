(in-package :gtk-test)

(def-suite gtk-label :in gtk-suite)
(in-suite gtk-label)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkLabel

(test label-class
  ;; Type check
  (is (g:type-is-object "GtkLabel"))
  ;; Check the registered name
  (is (eq 'gtk:label
          (gobject:symbol-for-gtype "GtkLabel")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkLabel")
          (g:gtype (cffi:foreign-funcall "gtk_label_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkMisc")
          (g:type-parent "GtkLabel")))
  ;; Check the children
  (is (equal '("GtkAccelLabel")
             (list-children "GtkLabel")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable")
             (list-interfaces "GtkLabel")))
  ;; Check the class properties
  (is (equal '("angle" "attributes" "cursor-position" "ellipsize" "justify"
               "label" "lines" "max-width-chars" "mnemonic-keyval"
               "mnemonic-widget" "pattern" "selectable" "selection-bound"
               "single-line-mode" "track-visited-links" "use-markup"
               "use-underline" "width-chars" "wrap" "wrap-mode")
             (list-properties "GtkLabel")))
  ;; Check the style properties.
  (is (equal '()
             (list-style-properties "GtkLabel")))
  ;; Check the signal
  (is (equal '("activate-current-link" "activate-link" "copy-clipboard"
               "move-cursor" "populate-popup")
             (list-signals "GtkLabel")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkLabel" GTK-LABEL
                       (:SUPERCLASS GTK-MISC :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable")
                        :TYPE-INITIALIZER "gtk_label_get_type")
                       ((ANGLE GTK-LABEL-ANGLE "angle" "gdouble" T T)
                        (ATTRIBUTES GTK-LABEL-ATTRIBUTES "attributes"
                         "PangoAttrList" T T)
                        (CURSOR-POSITION GTK-LABEL-CURSOR-POSITION
                         "cursor-position" "gint" T NIL)
                        (ELLIPSIZE GTK-LABEL-ELLIPSIZE "ellipsize"
                         "PangoEllipsizeMode" T T)
                        (JUSTIFY GTK-LABEL-JUSTIFY "justify" "GtkJustification"
                         T T)
                        (LABEL GTK-LABEL-LABEL "label" "gchararray" T T)
                        (LINES GTK-LABEL-LINES "lines" "gint" T T)
                        (MAX-WIDTH-CHARS GTK-LABEL-MAX-WIDTH-CHARS
                         "max-width-chars" "gint" T T)
                        (MNEMONIC-KEYVAL GTK-LABEL-MNEMONIC-KEYVAL
                         "mnemonic-keyval" "guint" T NIL)
                        (MNEMONIC-WIDGET GTK-LABEL-MNEMONIC-WIDGET
                         "mnemonic-widget" "GtkWidget" T T)
                        (PATTERN GTK-LABEL-PATTERN "pattern" "gchararray" NIL
                         T)
                        (SELECTABLE GTK-LABEL-SELECTABLE "selectable"
                         "gboolean" T T)
                        (SELECTION-BOUND GTK-LABEL-SELECTION-BOUND
                         "selection-bound" "gint" T NIL)
                        (SINGLE-LINE-MODE GTK-LABEL-SINGLE-LINE-MODE
                         "single-line-mode" "gboolean" T T)
                        (TRACK-VISITED-LINKS GTK-LABEL-TRACK-VISITED-LINKS
                         "track-visited-links" "gboolean" T T)
                        (USE-MARKUP GTK-LABEL-USE-MARKUP "use-markup"
                         "gboolean" T T)
                        (USE-UNDERLINE GTK-LABEL-USE-UNDERLINE "use-underline"
                         "gboolean" T T)
                        (WIDTH-CHARS GTK-LABEL-WIDTH-CHARS "width-chars" "gint"
                         T T)
                        (WRAP GTK-LABEL-WRAP "wrap" "gboolean" T T)
                        (WRAP-MODE GTK-LABEL-WRAP-MODE "wrap-mode"
                         "PangoWrapMode" T T)
                        (XALIGN GTK-LABEL-XALIGN "xalign" "gfloat" T T)
                        (YALIGN GTK-LABEL-YALIGN "yalign" "gfloat" T T)))
             (gobject:get-g-type-definition "GtkLabel"))))

;;; --- Properties -------------------------------------------------------------

(test label-properties
  (let ((label (make-instance 'gtk:label)))
    ;; angle
    (is (=  0.0d0 (gtk:label-angle label)))
    (is (= 15.0d0 (setf (gtk:label-angle label) 15)))
    (is (= 15.0d0 (gtk:label-angle label)))
    ;; attributes
    (is-false (gtk:label-attributes label))
    (is (typep (setf (gtk:label-attributes label)
                     (pango:attr-list-new))
                'pango:attr-list))
    (is (typep (gtk:label-attributes label) 'pango:attr-list))
    ;; cursor-position
    (is (= 0 (gtk:label-cursor-position label)))
    (signals (error) (setf (gtk:label-cursor-position label) 10))
    ;; ellipsize
    (is (eq :none (gtk:label-ellipsize label)))
    (is (eq :start (setf (gtk:label-ellipsize label) :start)))
    (is (eq :start (gtk:label-ellipsize label)))
    ;; justify
    (is (eq :left (gtk:label-justify label)))
    (is (eq :center (setf (gtk:label-justify label) :center)))
    (is (eq :center (gtk:label-justify label)))
    ;; label
    (is (string= "" (gtk:label-label label)))
    (is (string= "text" (setf (gtk:label-label label) "text")))
    (is (string= "text" (gtk:label-label label)))
    ;; lines
    (is (= -1 (gtk:label-lines label)))
    (is (=  1 (setf (gtk:label-lines label) 1)))
    (is (=  1 (gtk:label-lines label)))
    ;; max-width-chars
    (is (= -1 (gtk:label-max-width-chars label)))
    (is (=  1 (setf (gtk:label-max-width-chars label) 1)))
    (is (=  1 (gtk:label-max-width-chars label)))
    ;; mnemonic-keyval
    (is (= 16777215 (gtk:label-mnemonic-keyval label)))
    (signals (error) (setf (gtk:label-mnemonic-keyval label) 0))
    ;; mnemonic-widget
    (let ((button (make-instance 'gtk:button)))
      (is-false (gtk:label-mnemonic-widget label))
      (is (typep (setf (gtk:label-mnemonic-widget label) button) 'gtk:button))
      (is (typep (gtk:label-mnemonic-widget label) 'gtk:button)))
    ;; pattern
    (signals (error) (gtk:label-pattern label))
    (is (string= " _ _" (setf (gtk:label-pattern label) " _ _")))
    ;; selectable
    (is-false (gtk:label-selectable label))
    (is-true (setf (gtk:label-selectable label) t))
    (is-true (gtk:label-selectable label))
    ;; selection-bound
    (is (= 0 (gtk:label-selection-bound label)))
    (signals (error) (setf (gtk:label-selection-bound label) 1))
    ;; single-line-mode
    (is-false (gtk:label-single-line-mode label))
    (is-true (setf (gtk:label-single-line-mode label) t))
    (is-true (gtk:label-single-line-mode label))
    ;; track-visited-links
    (is-true (gtk:label-track-visited-links label))
    (is-false (setf (gtk:label-track-visited-links label) nil))
    (is-false (gtk:label-track-visited-links label))
    ;; use-markup
    (is-false (gtk:label-use-markup label))
    (is-true (setf (gtk:label-use-markup label) t))
    (is-true (gtk:label-use-markup label))
    ;; use-underline
    (is-false (gtk:label-use-underline label))
    (is-true (setf (gtk:label-use-underline label) t))
    (is-true (gtk:label-use-underline label))
    ;; width-chars
    (is (= -1 (gtk:label-width-chars label)))
    (is (=  1 (setf (gtk:label-width-chars label) 1)))
    (is (=  1 (gtk:label-width-chars label)))
    ;; wrap
    (is-false (gtk:label-wrap label))
    (is-true (setf (gtk:label-wrap label) t))
    (is-true (gtk:label-wrap label))
    ;; wrap-mode
    (is (eq :word (gtk:label-wrap-mode label)))
    (is (eq :char (setf (gtk:label-wrap-mode label) :char)))
    (is (eq :char (gtk:label-wrap-mode label)))
    ;; xalign
    (is (= 0.5 (gtk:label-xalign label)))
    (is (= 1.0 (setf (gtk:label-xalign label) 1.0)))
    (is (= 1.0 (gtk:label-xalign label)))
    ;; yalign
    (is (= 0.5 (gtk:label-yalign label)))
    (is (= 1.0 (setf (gtk:label-yalign label) 1.0)))
    (is (= 1.0 (gtk:label-yalign label)))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_label_new

(test label-new
  (is (eq 'gtk:label (type-of (gtk:label-new nil))))
  (is (eq 'gtk:label (type-of (gtk:label-new "text")))))

;;;     gtk_label-text

(test label-text.1
  (let ((label (gtk:label-new nil)))
    (is (string= "" (gtk:label-text label)))
    (is (string= "" (gtk:label-label label)))
    (is (string= "neu" (setf (gtk:label-text label) "neu")))
    (is (string= "neu" (gtk:label-text label)))
    (is (string= "neu" (gtk:label-label label)))))

(test label-text.2
  (let ((label (gtk:label-new "text")))
    (is (string= "text" (gtk:label-text label)))
    (is (string= "text" (gtk:label-label label)))
    (is (string= "neu" (setf (gtk:label-text label) "neu")))
    (is (string= "neu" (gtk:label-text label)))
    (is (string= "neu" (gtk:label-label label)))))

;;;     gtk_label_set_markup

(test label-set-markup
  (let ((label (make-instance 'gtk:label)))
    (is-false (gtk:label-set-markup label
                                    "<span style=\"italic\"><small>Small text</small></span>"))
    ;; use-markup is set to true
    (is-true (gtk:label-use-markup label))
    ;; get the label text
    (is (string= "<span style=\"italic\"><small>Small text</small></span>"
                 (gtk:label-label label)))
    ;; get the verbatim text
    (is (string= "Small text" (gtk:label-text label)))))

;;;     gtk_label_set_markup_with_mnemonic

(test label-set-markup-with-mnemonic
  (let ((label (make-instance 'gtk:label)))
    (is-false (gtk:label-set-markup-with-mnemonic label
                                                  "<span style=\"italic\"><small>_Small text</small></span>"))
    ;; use-markup is set to true
    (is-true (gtk:label-use-markup label))
    ;; get the label text
    (is (string= "<span style=\"italic\"><small>_Small text</small></span>"
                 (gtk:label-label label)))
    ;; get the verbatim text
    (is (string= "Small text" (gtk:label-text label)))))

;;;     gtk_label_set_line_wrap
;;;     gtk_label_get_line_wrap

(test label-line-wrap
  (let ((label (make-instance 'gtk:label)))
    (is-false (gtk:label-line-wrap label))
    (is-true (setf (gtk:label-line-wrap label) t))
    (is-true (gtk:label-line-wrap label))))

;;;     gtk_label_set_line_wrap_mode
;;;     gtk_label_get_line_wrap_mode

(test label-line-wrap-mode
  (let ((label (make-instance 'gtk:label)))
    (is (eq :word (gtk:label-line-wrap-mode label)))
    (is (eq :char (setf (gtk:label-line-wrap-mode label) :char)))
    (is (eq :char (gtk:label-line-wrap-mode label)))))

;;;     gtk_label_get_layout_offsets

(test label-layout-offsets
  (let ((label (gtk:label-new "some text")))
    #-windows
    (multiple-value-bind (x-offset y-offset)
        (gtk:label-layout-offsets label)
      (is (= -34 x-offset))
      (is (=  -9 y-offset)))
    #+windows
    (multiple-value-bind (x-offset y-offset)
        (gtk:label-layout-offsets label)
      (is (= -26 x-offset))
      (is (=  -8 y-offset)))))

;;;     gtk_label_new_with_mnemonic

(test label-new-with-mnemonic
  (let ((label nil))
    (is (typep (setf label (gtk:label-new-with-mnemonic "_Print")) 'gtk:label))
    (is (string= "_Print" (gtk:label-label label)))
    (is (string= "Print" (gtk:label-text label)))
    (is (= 112 (gtk:label-mnemonic-keyval label)))
    (is-true (gtk:label-use-underline label))))

;;;     gtk_label_select_region
;;;     gtk_label_get_selection_bounds

(test label-select-region
  (let ((label (make-instance 'gtk:label :label "some text")))
    (is-true (setf (gtk:label-selectable label) t))
    (is-false (gtk:label-select-region label -1 -1))
    (multiple-value-bind (start end)
        (gtk:label-selection-bounds label)
      (is-false start)
      (is-false end))
    (is-false (gtk:label-select-region label 2 5))
    (multiple-value-bind (start end)
        (gtk:label-selection-bounds label)
      (is (= 2 start))
      (is (= 5 end)))
    (is-false (gtk:label-select-region label 2 -1))
    (multiple-value-bind (start end)
        (gtk:label-selection-bounds label)
      (is (= 2 start))
      (is (= 9 end)))
    (is-false (gtk:label-select-region label -1 5))
    (multiple-value-bind (start end)
        (gtk:label-selection-bounds label)
      (is (= 5 start))
      (is (= 9 end)))))

;;;     gtk_label_set_text_with_mnemonic

(test label-set-text-with-mnemonic
  (let ((label (make-instance 'gtk:label)))
    (is-false (gtk:label-set-text-with-mnemonic label "_Print"))
    (is (string= "_Print" (gtk:label-label label)))
    (is (string= "Print" (gtk:label-text label)))
    (is (= 112 (gtk:label-mnemonic-keyval label)))
    (is-true (gtk:label-use-underline label))))

;;;     gtk_label_get_layout

(test label-layout
  (let ((label (make-instance 'gtk:label :label "some text")))
    (is (eq 'pango:layout (type-of (gtk:label-layout label))))))

;;;     gtk_label_get_current_uri

(test label-current-uri
  (let ((label (make-instance 'gtk:label :label "some text")))
    (is-false (gtk:label-current-uri label))))

;;; --- 2023-3-5 ---------------------------------------------------------------
