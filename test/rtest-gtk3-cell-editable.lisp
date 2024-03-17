(in-package :gtk-test)

(def-suite gtk-cell-editable :in gtk-suite)
(in-suite gtk-cell-editable)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkCellEditable

(test gtk-cell-editable
  ;; Type check
  (is (g:type-is-interface "GtkCellEditable"))
  ;; Check the registered name
  (is (eq 'gtk:cell-editable
          (glib:symbol-for-gtype "GtkCellEditable")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkCellEditable")
          (g:gtype (cffi:foreign-funcall "gtk_cell_editable_get_type" :size))))
  ;; Check the interface prerequisites
  (is (equal '("GtkWidget")
             (list-interface-prerequisites "GtkCellEditable")))
  ;; Check the interface properties
  (is (equal '("editing-canceled")
             (list-interface-properties "GtkCellEditable")))
  ;; Check the signals
  (is (equal '("editing-done" "remove-widget")
             (list-signals "GtkCellEditable")))
  ;; Get the interface definition
  (is (equal '(GOBJECT:DEFINE-G-INTERFACE "GtkCellEditable" GTK-CELL-EDITABLE
                            (:EXPORT T :TYPE-INITIALIZER
                             "gtk_cell_editable_get_type")
                            (EDITING-CANCELED
                             GTK-CELL-EDITABLE-EDITING-CANCELED
                             "editing-canceled" "gboolean" T T))
             (gobject:get-g-type-definition "GtkCellEditable"))))

;;; --- Properties -------------------------------------------------------------

;;;     editing-canceled

(test gtk-cell-editable-properties
  (let ((entry (gtk:entry-new)))
    (is-false (gtk:cell-editable-editing-canceled entry))))

;;; --- Signals ----------------------------------------------------------------

;;;     editing-done
;;;     remove-widget

;;; --- Functions --------------------------------------------------------------

;;;     gtk_cell_editable_start_editing
;;;     gtk_cell_editable_editing_done
;;;     gtk_cell_editable_remove_widget

;;; 2024-3-17
