;;;; Create Page Setup Dialog
;;;;
;;;; 2024-1-5

(in-package :gtk3-example)

(defun create-page-setup-dialog (&optional parent)
  (let ((page-setup (gtk:page-setup-new))
        (dialog (make-instance 'gtk:page-setup-unix-dialog
                               :title "Page Setup Dialog"
                               :transient-for parent
                               :default-height 250
                               :default-width 400)))
    ;; Load and set Page setup from file
    (if (gtk:page-setup-load-file page-setup (sys-path "page-setup.ini"))
        (format t "PAGE SETUP successfully loaded~%")
        (format t "PAGE SETUP cannot be loaded, use standard settings~%"))
    (setf (gtk:page-setup-unix-dialog-page-setup dialog) page-setup)
    ;; Run the dialog
    (when (eq :ok (gtk:dialog-run dialog))
      (setf page-setup (gtk:page-setup-unix-dialog-page-setup dialog))
      (gtk:page-setup-to-file page-setup (sys-path "page-setup.ini")))
    ;; Destroy the dialog
    (gtk:widget-destroy dialog)))
