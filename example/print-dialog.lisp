;;;; Create Print Dialog - 2022-12-22

(in-package :gtk3-example)

(defun create-print-dialog ()
  (let* ((filename (sys-path "print-dialog.ini"))
         (settings (gtk:print-settings-new-from-file filename))
         (dialog (gtk:print-unix-dialog-new "Print Dialog" nil)))
    ;; Signal handler to print the selected printer
    (g:signal-connect dialog "notify::selected-printer"
        (lambda (widget param)
          (declare (ignore param))
          (let ((printer (gtk:print-unix-dialog-selected-printer widget)))
            (format t "Selected printer is ~a~%" (gtk:printer-name printer)))))
    ;; Set the print settings and a size for the window.
    (setf (gtk:window-default-size dialog) '(350 200))
    (setf (gtk:print-unix-dialog-print-settings dialog) settings)
    ;; Run the dialog
    (when (eq :ok (gtk:dialog-run dialog))
      (format t "~&Save print settings to ~A~%" (sys-path "print-dialog.ini"))
      (setf settings (gtk:print-unix-dialog-print-settings dialog))
      (gtk:print-settings-to-file settings (sys-path "print-dialog.ini")))
    ;; Destroy the dialog
    (gtk:widget-destroy dialog)))
