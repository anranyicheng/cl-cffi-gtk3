;;;; Font Chooser Button - 2023-2-12

(in-package :gtk3-example)

(defun font-filter (family face)
  (declare (ignore face))
  (member (pango:font-family-name family)
          '("Sans" "Serif")
          :test #'equal))

(defun example-font-button (&optional application)
  (within-main-loop
    (let ((window (make-instance 'gtk:window
                                 :title "Example Font Chooser Button"
                                 :type :toplevel
                                 :application application
                                 :border-width 12
                                 :default-width 300
                                 :default-height 100))
          (button (make-instance 'gtk:font-button
                                 :use-font t
                                 :use-size t)))
      (g:signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)))
      ;; Set a filter function to select fonts for the font chooser
      (gtk:font-chooser-set-filter-func button #'font-filter)
      (g:signal-connect button "font-set"
         (lambda (widget)
           (declare (ignore widget))
           (format t "Font is set:~%")
           (format t "   Font name   : ~A~%"
                     (gtk:font-chooser-font button))
           (format t "   Font family : ~A~%"
                     (pango:font-family-name
                       (gtk:font-chooser-font-family button)))
           (format t "   Font face   : ~A~%"
                     (pango:font-face-face-name
                       (gtk:font-chooser-font-face button)))
           (format t "   Font size   : ~A~%"
                     (gtk:font-chooser-font-size button))))
      (gtk:container-add window button)
      (gtk:widget-show-all window))))
