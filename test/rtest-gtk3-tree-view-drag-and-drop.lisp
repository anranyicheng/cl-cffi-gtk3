(in-package :gtk-test)

(def-suite gtk-tree-view-drag-and-drop :in gtk-suite)
(in-suite gtk-tree-view-drag-and-drop)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkTreeDragSource

(test tree-drag-source
  ;; Type check
  (is (g:type-is-interface "GtkTreeDragSource"))
  ;; Check the registered name
  (is (eq 'gtk:tree-drag-source
          (gobject:symbol-for-gtype "GtkTreeDragSource")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkTreeDragSource")
          (g:gtype (cffi:foreign-funcall "gtk_tree_drag_source_get_type" :size))))
  ;; Get the names of the interface properties.
  (is (equal '()
             (list-interface-properties "GtkTreeDragSource")))
  ;; Get the interface definition
  (is (equal '(DEFINE-G-INTERFACE "GtkTreeDragSource"
                                  GTK-TREE-DRAG-SOURCE
                                  (:EXPORT T
                                   :TYPE-INITIALIZER
                                   "gtk_tree_drag_source_get_type"))
             (gobject:get-g-type-definition "GtkTreeDragSource"))))

;;;     GtkTreeDragDest

(test tree-drag-dest
  ;; Type check
  (is (g:type-is-interface "GtkTreeDragDest"))
  ;; Check the registered name
  (is (eq 'gtk:tree-drag-dest
          (gobject:symbol-for-gtype "GtkTreeDragDest")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkTreeDragDest")
          (g:gtype (cffi:foreign-funcall "gtk_tree_drag_dest_get_type" :size))))
  ;; Get the names of the interface properties.
  (is (equal '()
             (list-interface-properties "GtkTreeDragDest")))
  ;; Get the interface definition
  (is (equal '(DEFINE-G-INTERFACE "GtkTreeDragDest"
                                  GTK-TREE-DRAG-DEST
                                  (:EXPORT T
                                   :TYPE-INITIALIZER
                                   "gtk_tree_drag_dest_get_type"))
             (gobject:get-g-type-definition "GtkTreeDragDest"))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_tree_drag_source_drag_data_delete
;;;     gtk_tree_drag_source_drag_data_get
;;;     gtk_tree_drag_source_row_draggable

;;;     gtk_tree_drag_dest_drag_data_received
;;;     gtk_tree_drag_dest_row_drop_possible
;;;     gtk_tree_set_row_drag_data
;;;     gtk_tree_get_row_drag_data

;;; --- 2022-12-27 -------------------------------------------------------------
