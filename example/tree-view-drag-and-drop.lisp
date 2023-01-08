;;;; Example Tree View Drag and Drop - 2022-12-22

(in-package :gtk3-example)

(let ((col-uri 0)
      (target-string 0) (target-url 1))

  (defun create-and-fill-model-drag-and-drop ()
    (let ((model (gtk:list-store-new "gchararray")))
      ;; Append a row and fill in some data
      (gtk:list-store-set model (gtk:list-store-append model)
                                "Hans Müller")
      ;; Append another row and fill in some data
      (gtk:list-store-set model (gtk:list-store-append model)
                                "Barbara Schmidt")
      ;; Append a third row
      (gtk:list-store-set model (gtk:list-store-append model)
                                "Peter Schneider")
      ;; Append a third row
      (gtk:list-store-set model (gtk:list-store-append model)
                                "Ursula Fischer")
      ;; Append a third row
      (gtk:list-store-set model (gtk:list-store-append model)
                                "Wolfgang Weber")
      model))

  (defun create-view-and-model-drag-and-drop ()
    (let* ((model (create-and-fill-model-drag-and-drop))
           (view (gtk:tree-view-new-with-model model))
           (targets (list (list "STRING" 0 target-string)
                          (list "text/plain" 0 target-string)
                          (list "text/uri-list" 0 target-url))))

      ;; Create renderer for first column
      (let* ((renderer (gtk:cell-renderer-text-new))
             (column (gtk:tree-view-column-new-with-attributes "URI"
                                                               renderer
                                                               "text"
                                                                col-uri)))
        (gtk:tree-view-append-column view column))

      (gtk:drag-dest-set view :all targets '(:copy :move :link))

      (g:signal-connect view "drag-data-received"
          (lambda (widget context x y data info time)
            (declare (ignore context x y info time))
            (format t "Drag data received in the tree view.~%")
            (format t "GtkSelectionData: ~a~%" data)
            (format t "~a~%" (gtk:selection-data-data-type data))
            (format t "~a~%"
                    (cffi:foreign-string-to-lisp
                        (gtk:selection-data-data data)))

            (when (string= "STRING" (gtk:selection-data-data-type data))

              (let ((model (gtk:tree-view-model widget))
                    (url (cffi:foreign-string-to-lisp
                             (gtk:selection-data-data data))))

              (gtk:list-store-set model (gtk:list-store-append model)
                                  url)

      ))))

      view))

  (defun example-tree-view-drag-and-drop ()
    (within-main-loop
      (let ((window (make-instance 'gtk:window
                                   :title "Example Tree View Drag and Drop"
                                   :type :toplevel
                                   :default-width 350
                                   :default-height 200))
            (vbox (make-instance 'gtk:box
                                 :orientation :vertical))
            (view (create-view-and-model-drag-and-drop))
            (msg "Drag and Drop links from the browser into the tree view."))
        (g:signal-connect window "destroy"
                          (lambda (widget)
                            (declare (ignore widget))
                            (leave-gtk-main)))
        (gtk:box-pack-start vbox
                            (make-instance 'gtk:label :label msg)
                            :expand nil)
        (gtk:box-pack-start vbox view :expand t)
        (gtk:container-add window vbox)
        (gtk:widget-show-all window)))))
