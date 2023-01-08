;;;; Example Aspect Frame - 2022-12-15

(in-package :gtk3-example)

(defun example-aspect-frame (&optional (application nil))
  (within-main-loop
    (let ((window (make-instance 'gtk:window
                                 :type :toplevel
                                 :title "Example Aspect Frame"
                                 :application application
                                 :default-width 300
                                 :default-height 240
                                 :border-width 12))
          (frame (make-instance 'gtk:aspect-frame
                                :label "Ratio 2 x 1"
                                :label-yalign 1.0
                                :xalign 0.5
                                :yalign 0.5
                                :ratio 2
                                :obey-child nil))
          (area (make-instance 'gtk:drawing-area
                               :width-request 200
                               :hight-request 200)))
      (g:signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)))
      (gtk:container-add window frame)
      (gtk:container-add frame area)
      (gtk:widget-show-all window))))
