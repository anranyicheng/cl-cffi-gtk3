;;;; CSS Accordion - 2023-2-16
;;;;
;;;; A accordion demo written using CSS transitions and multiple backgrounds.

(in-package #:gtk3-example)

(defun example-css-accordion (&optional application)
  (within-main-loop
    (let ((window (make-instance 'gtk:window
                                 :type :toplevel
                                 :application application
                                 :title "CSS Accordion"
                                 :default-height 300
                                 :default-width 600))
          (container (make-instance 'gtk:box
                                    :orientation :horizontal
                                    :halign :center
                                    :valign :center))
          (provider (make-instance 'gtk:css-provider))
          (csspath (sys-path "resource/css-accordion.css")))
      (g:signal-connect window "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)))
      ;; Add the buttons to the container
      (gtk:container-add container
                         (gtk:button-new-with-label "This"))
      (gtk:container-add container
                         (gtk:button-new-with-label "Is"))
      (gtk:container-add container
                         (gtk:button-new-with-label "A"))
      (gtk:container-add container
                         (gtk:button-new-with-label "CSS"))
      (gtk:container-add container
                         (gtk:button-new-with-label "Accordion"))
      (gtk:container-add container
                         (gtk:button-new-with-label "."))
      ;; Add the container to the window
      (gtk:container-add window container)
      ;; Load CSS from file into the provider
      (gtk:css-provider-load-from-path provider csspath)
      ;; Apply CSS to the widgets
      (apply-css-to-widget provider window)
      ;; Show the window
      (gtk:widget-show-all window))))
