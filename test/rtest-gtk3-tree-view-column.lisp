(in-package :gtk-test)

(def-suite gtk-tree-view-column :in gtk-suite)
(in-suite gtk-tree-view-column)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkTreeViewColumnSizing

(test gtk-tree-view-column-sizing
  ;; Check the type
  (is (g:type-is-enum "GtkTreeViewColumnSizing"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkTreeViewColumnSizing")
          (g:gtype (cffi:foreign-funcall "gtk_tree_view_column_sizing_get_type"
                                         :size))))
  ;; Check the registered name
  (is (eq 'gtk:tree-view-column-sizing
          (glib:symbol-for-gtype "GtkTreeViewColumnSizing")))
  ;; Check the names
  (is (equal '("GTK_TREE_VIEW_COLUMN_GROW_ONLY" "GTK_TREE_VIEW_COLUMN_AUTOSIZE"
               "GTK_TREE_VIEW_COLUMN_FIXED")
             (list-enum-item-name "GtkTreeViewColumnSizing")))
  ;; Check the values
  (is (equal '(0 1 2)
             (list-enum-item-value "GtkTreeViewColumnSizing")))
  ;; Check the nick names
  (is (equal '("grow-only" "autosize" "fixed")
             (list-enum-item-nick "GtkTreeViewColumnSizing")))
  ;; Check the enum definition
  (is (equal '(GOBJECT:DEFINE-G-ENUM "GtkTreeViewColumnSizing"
                                     GTK-TREE-VIEW-COLUMN-SIZING
                                     (:EXPORT T
                                      :TYPE-INITIALIZER
                                      "gtk_tree_view_column_sizing_get_type")
                                     (:GROW-ONLY 0)
                                     (:AUTOSIZE 1)
                                     (:FIXED 2))
             (gobject:get-g-type-definition "GtkTreeViewColumnSizing"))))

;;;     GtkTreeViewColumn

(test gtk-tree-view-column-class
  ;; Type check
  (is (g:type-is-object "GtkTreeViewColumn"))
  ;; Check the registered name
  (is (eq 'gtk:tree-view-column
          (glib:symbol-for-gtype "GtkTreeViewColumn")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkTreeViewColumn")
          (g:gtype (cffi:foreign-funcall "gtk_tree_view_column_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GInitiallyUnowned")
          (g:type-parent "GtkTreeViewColumn")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkTreeViewColumn")))
  ;; Check the interfaces
  (is (equal '("GtkCellLayout" "GtkBuildable")
             (list-interfaces "GtkTreeViewColumn")))
  ;; Check the class properties
  (is (equal '("alignment" "cell-area" "clickable" "expand" "fixed-width"
               "max-width" "min-width" "reorderable" "resizable" "sizing"
               "sort-column-id" "sort-indicator" "sort-order" "spacing" "title"
               "visible" "widget" "width" "x-offset")
             (list-properties "GtkTreeViewColumn")))
  ;; Check the signals
  (is (equal '("clicked")
             (list-signals "GtkTreeViewColumn")))
  ;; Check the class definition
  (is (equal '(GOBJECT:DEFINE-G-OBJECT-CLASS "GtkTreeViewColumn"
                                             GTK-TREE-VIEW-COLUMN
                       (:SUPERCLASS G-INITIALLY-UNOWNED :EXPORT T :INTERFACES
                        ("GtkBuildable" "GtkCellLayout") :TYPE-INITIALIZER
                        "gtk_tree_view_column_get_type")
                       ((ALIGNMENT GTK-TREE-VIEW-COLUMN-ALIGNMENT "alignment"
                         "gfloat" T T)
                        (CELL-AREA GTK-TREE-VIEW-COLUMN-CELL-AREA "cell-area"
                         "GtkCellArea" T NIL)
                        (CLICKABLE GTK-TREE-VIEW-COLUMN-CLICKABLE "clickable"
                         "gboolean" T T)
                        (EXPAND GTK-TREE-VIEW-COLUMN-EXPAND "expand" "gboolean"
                         T T)
                        (FIXED-WIDTH GTK-TREE-VIEW-COLUMN-FIXED-WIDTH
                         "fixed-width" "gint" T T)
                        (MAX-WIDTH GTK-TREE-VIEW-COLUMN-MAX-WIDTH "max-width"
                         "gint" T T)
                        (MIN-WIDTH GTK-TREE-VIEW-COLUMN-MIN-WIDTH "min-width"
                         "gint" T T)
                        (REORDERABLE GTK-TREE-VIEW-COLUMN-REORDERABLE
                         "reorderable" "gboolean" T T)
                        (RESIZABLE GTK-TREE-VIEW-COLUMN-RESIZABLE "resizable"
                         "gboolean" T T)
                        (SIZING GTK-TREE-VIEW-COLUMN-SIZING "sizing"
                         "GtkTreeViewColumnSizing" T T)
                        (SORT-COLUMN-ID GTK-TREE-VIEW-COLUMN-SORT-COLUMN-ID
                         "sort-column-id" "gint" T T)
                        (SORT-INDICATOR GTK-TREE-VIEW-COLUMN-SORT-INDICATOR
                         "sort-indicator" "gboolean" T T)
                        (SORT-ORDER GTK-TREE-VIEW-COLUMN-SORT-ORDER
                         "sort-order" "GtkSortType" T T)
                        (SPACING GTK-TREE-VIEW-COLUMN-SPACING "spacing" "gint"
                         T T)
                        (TITLE GTK-TREE-VIEW-COLUMN-TITLE "title" "gchararray"
                         T T)
                        (VISIBLE GTK-TREE-VIEW-COLUMN-VISIBLE "visible"
                         "gboolean" T T)
                        (WIDGET GTK-TREE-VIEW-COLUMN-WIDGET "widget"
                         "GtkWidget" T T)
                        (WIDTH GTK-TREE-VIEW-COLUMN-WIDTH "width" "gint" T NIL)
                        (X-OFFSET GTK-TREE-VIEW-COLUMN-X-OFFSET "x-offset"
                         "gint" T NIL)))
             (gobject:get-g-type-definition "GtkTreeViewColumn"))))

;;; --- Properties -------------------------------------------------------------

(test gtk-tree-view-column-properties
  (let ((column (make-instance 'gtk:tree-view-column)))
    (is (= 0.0 (gtk:tree-view-column-alignment column)))
    (is (typep (gtk:tree-view-column-cell-area column) 'gtk:cell-area))
    (is-false (gtk:tree-view-column-clickable column))
    (is-false (gtk:tree-view-column-expand column))
    (is (= -1 (gtk:tree-view-column-fixed-width column)))
    (is (= -1 (gtk:tree-view-column-max-width column)))
    (is (= -1 (gtk:tree-view-column-min-width column)))
    (is-false (gtk:tree-view-column-reorderable column))
    (is-false (gtk:tree-view-column-resizable column))
    (is (eq :grow-only (gtk:tree-view-column-sizing column)))
    (is (= -1 (gtk:tree-view-column-sort-column-id column)))
    (is-false (gtk:tree-view-column-sort-indicator column))
    (is (eq :ascending (gtk:tree-view-column-sort-order column)))
    (is (= 0 (gtk:tree-view-column-spacing column)))
    (is (string= "" (gtk:tree-view-column-title column)))
    (is-true (gtk:tree-view-column-visible column))
    (is-false (gtk:tree-view-column-widget column))
    (is (= 0 (gtk:tree-view-column-width column)))
    (is (= 0 (gtk:tree-view-column-x-offset column)))))

;;; --- Signals ----------------------------------------------------------------

;;;     clicked

;;; --- Functions --------------------------------------------------------------

;;;     GtkTreeCellDataFunc

;;;     gtk_tree_view_column_new

(test gtk-tree-view-column-new
  (is (typep (gtk:tree-view-column-new) 'gtk:tree-view-column)))

;;;     gtk_tree_view_column_new_with_area

(test gtk-tree-view-column-new-with-area
  (let ((area (gtk:cell-area-box-new)))
    (is (typep (gtk:tree-view-column-new-with-area area)
               'gtk:tree-view-column))))

;;;     gtk_tree_view_column_new_with_attributes

(test gtk-tree-view-column-new-with-attributes
  (let ((renderer (gtk:cell-renderer-text-new)))
    (is (typep (gtk:tree-view-column-new-with-attributes "Example"
                                                         renderer
                                                         "text" 0
                                                         "foreground" 1)
               'gtk:tree-view-column))))

;;;     gtk_tree_view_column_pack_start
;;;     gtk_tree_view_column_pack_end
;;;     gtk_tree_view_column_clear
;;;     gtk_tree_view_column_add_attribute
;;;     gtk_tree_view_column_set_attributes
;;;     gtk_tree_view_column_set_cell_data_func
;;;     gtk_tree_view_column_clear_attributes
;;;     gtk_tree_view_column_clicked
;;;     gtk_tree_view_column_get_button
;;;     gtk_tree_view_column_cell_set_cell_data
;;;     gtk_tree_view_column_cell_get_size
;;;     gtk_tree_view_column_cell_get_position
;;;     gtk_tree_view_column_cell_is_visible
;;;     gtk_tree_view_column_focus_cell
;;;     gtk_tree_view_column_queue_resize
;;;     gtk_tree_view_column_get_tree_view

;;; 2024-3-15
