;;;; Text View Insert Image - 2022-12-22

(in-package :gtk3-example)

(defun example-text-view-insert-image ()
  (within-main-loop
    (let ((window (make-instance 'gtk:window
                                 :type :toplevel
                                 :title "Text View Insert Image"
                                 :default-width 350
                                 :default-height 200))
          (textview (make-instance 'gtk:text-view
                                    :top-margin 6
                                    :left-margin 6
                                    :right-margin 6))
          (button (make-instance 'gtk:button
                                 :label "Insert Image"))
          (vbox (make-instance 'gtk:box
                               :orientation :vertical)))
    (g:signal-connect window "destroy"
                      (lambda (widget)
                        (declare (ignore widget))
                        (leave-gtk-main)))
    ;; Signal handler to insert an image at the current cursor position.
    (g:signal-connect button "clicked"
       (lambda (widget)
         (declare (ignore widget))
         (let* ((pixbuf (gdk:pixbuf-new-from-file (sys-path "save.png")))
                (buffer (gtk:text-view-buffer textview))
                (cursor (gtk:text-buffer-get-insert buffer))
                (iter (gtk:text-buffer-iter-at-mark buffer cursor)))
           (gtk:text-buffer-insert-pixbuf buffer iter pixbuf))))
    (gtk:box-pack-start vbox textview)
    (gtk:box-pack-start vbox button :expand nil)
    (gtk:container-add window vbox)
    (gtk:widget-show-all window))))
