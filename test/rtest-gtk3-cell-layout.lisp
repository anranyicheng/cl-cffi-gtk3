(in-package :gtk-test)

(def-suite gtk-cell-layout :in gtk-suite)
(in-suite gtk-cell-layout)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkCellLayout

(test cell-layout-interface
  ;; Type check
  (is-true (g:type-is-interface "GtkCellLayout"))
  ;; Check the registered name
  (is (eq 'gtk:cell-layout
          (glib:symbol-for-gtype "GtkCellLayout")))
  ;; Get the names of the interface properties.
  (is (equal '()
             (list-interface-properties "GtkCellLayout")))
  ;; Get the interface definition
  (is (equal '(DEFINE-G-INTERFACE "GtkCellLayout"
                                  GTK-CELL-LAYOUT
                                  (:EXPORT T
                                   :TYPE-INITIALIZER "gtk_cell_layout_get_type"))
             (gobject:get-g-type-definition "GtkCellLayout"))))

;;; --- Functions --------------------------------------------------------------

;;;     GtkCellLayoutDataFunc

;;;     gtk_cell_layout_pack_start

(test cell-layout-pack-start
  (let ((cell-layout (make-instance 'gtk:cell-view))
        (cell1 (make-instance 'gtk:cell-renderer-text))
        (cell2 (make-instance 'gtk:cell-renderer-text)))
    (is-false (gtk:cell-layout-pack-start cell-layout cell1))
    (is (equal cell1 (first (gtk:cell-layout-cells cell-layout))))
    (is-false (gtk:cell-layout-pack-start cell-layout cell2))
    (is (equal cell1 (first (gtk:cell-layout-cells cell-layout))))
    (is (equal cell2 (second (gtk:cell-layout-cells cell-layout))))))

;;;     gtk_cell_layout_pack_end

(test cell-layout-pack-end
  (let ((cell-layout (make-instance 'gtk:cell-view))
        (cell1 (make-instance 'gtk:cell-renderer-text))
        (cell2 (make-instance 'gtk:cell-renderer-text)))
    (is-false (gtk:cell-layout-pack-end cell-layout cell1))
    (is (equal cell1 (first (gtk:cell-layout-cells cell-layout))))
    (is-false (gtk:cell-layout-pack-end cell-layout cell2))
    (is (equal cell1 (first (gtk:cell-layout-cells cell-layout))))
    (is (equal cell2 (second (gtk:cell-layout-cells cell-layout))))))

;;;     gtk_cell_layout_get_area -> cell-layout-area

(test cell-layout-area
  (let ((cell-layout (make-instance 'gtk:cell-view))
        (cell (make-instance 'gtk:cell-renderer-text)))
    (is-false (gtk:cell-layout-pack-start cell-layout cell))
    (is (eq 'gtk:cell-area-box (type-of (gtk:cell-layout-area cell-layout))))))

;;;     gtk_cell_layout_get_cells -> cell-layout-cells

(test cell-layout-cells
  (let ((cell-layout (make-instance 'gtk:cell-view))
        (cell (make-instance 'gtk:cell-renderer-text)))
    (is-false (gtk:cell-layout-pack-start cell-layout cell))
    (is-true (listp (gtk:cell-layout-cells cell-layout)))
    (is (eq 'gtk:cell-renderer-text
            (type-of (first (gtk:cell-layout-cells cell-layout)))))))

;;;     gtk_cell_layout_reorder

(test cell-layout-reorder
  (let ((cell-layout (make-instance 'gtk:cell-view))
        (cell1 (make-instance 'gtk:cell-renderer-text))
        (cell2 (make-instance 'gtk:cell-renderer-text)))
    (is-false (gtk:cell-layout-pack-start cell-layout cell1))
    (is-false (gtk:cell-layout-pack-start cell-layout cell2))
    (is (equal cell1 (first (gtk:cell-layout-cells cell-layout))))
    (is (equal cell2 (second (gtk:cell-layout-cells cell-layout))))
    (is-false (gtk:cell-layout-reorder cell-layout cell1 1))
    (is (equal cell2 (first (gtk:cell-layout-cells cell-layout))))
    (is (equal cell1 (second (gtk:cell-layout-cells cell-layout))))))

;;;     gtk_cell_layout_clear

(test cell-layout-clear
  (let ((cell-layout (make-instance 'gtk:cell-view))
        (cell1 (make-instance 'gtk:cell-renderer-text))
        (cell2 (make-instance 'gtk:cell-renderer-text)))
    (is-false (gtk:cell-layout-pack-start cell-layout cell1))
    (is-false (gtk:cell-layout-pack-start cell-layout cell2))
    (is-false (gtk:cell-layout-clear cell-layout))
    (is (equal '() (gtk:cell-layout-cells cell-layout)))))

;;;     gtk_cell_layout_set_attributes

;;;     gtk_cell_layout_add_attribute

(test cell-layout-add-attributes
  (let ((cell-layout (make-instance 'gtk:cell-view))
        (cell1 (make-instance 'gtk:cell-renderer-text))
        (cell2 (make-instance 'gtk:cell-renderer-text)))
    (is-false (gtk:cell-layout-pack-start cell-layout cell1))
    (is-false (gtk:cell-layout-pack-start cell-layout cell2))
    (is-false (gtk:cell-layout-add-attribute cell-layout cell1 "text" 0))
    (is-false (gtk:cell-layout-add-attribute cell-layout cell2 "text" 1))))

;;;     gtk_cell_layout_set_cell_data_func
;;;     gtk_cell_layout_clear_attributes

;;; --- 2023-5-29 --------------------------------------------------------------
