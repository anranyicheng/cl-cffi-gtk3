(in-package :gtk3-example)

(defun demo-dialog-toplevel (message)
 (let ((response nil))
   (gtk:within-main-loop
    (let (;; Create the widgets
          (dialog (gtk:dialog-new-with-buttons "Demo Toplevel Dialog"
                                               nil ; No Parent window
                                               '(:modal)
                                               "gtk-ok"
                                               :none
                                               "gtk-cancel"
                                               :cancel))
          (label (gtk:label-new message)))
      ;; Signal handler for the dialog to handle the signal "destroy".
      (g:signal-connect dialog "destroy"
                        (lambda (widget)
                          (declare (ignore widget))
                          ;; Quit the main loop and destroy the thread
                          (gtk:leave-gtk-main)))
      ;; Ensure that the dialog window is destroyed when the user responds.
      (g:signal-connect dialog "response"
                        (lambda (dialog response-id)
                          (setf response response-id)
                          (gtk:widget-destroy dialog)))
      ;; Add the label, and show everything we have added to the dialog.
      (gtk:container-add (gtk:dialog-content-area dialog) label)
      (gtk:widget-show-all dialog)))
    (gtk:join-gtk-main)
    (when response
      (format t "The response ID is ~A" response))))
