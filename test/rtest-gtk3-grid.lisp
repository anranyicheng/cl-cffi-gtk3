(in-package :gtk-test)

(def-suite gtk-grid :in gtk-suite)
(in-suite gtk-grid)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkGrid

(test grid-class
  ;; Type check
  (is (g:type-is-object "GtkGrid"))
  ;; Check the registered name
  (is (eq 'gtk:grid
          (glib:symbol-for-gtype "GtkGrid")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkGrid")
          (g:gtype (cffi:foreign-funcall "gtk_grid_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkContainer") (g:type-parent "GtkGrid")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkGrid")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable" "GtkOrientable")
             (list-interfaces "GtkGrid")))
  ;; Check the class properties
  (is (equal '("baseline-row" "column-homogeneous" "column-spacing"
               "orientation" "row-homogeneous" "row-spacing")
             (list-properties "GtkGrid")))
  ;; Get the names of the style properties.
  (is (equal '()
             (list-style-properties "GtkGrid")))
  ;; Get the names of the child properties
  (is (equal '("height" "left-attach" "top-attach" "width")
             (list-child-properties "GtkGrid")))
  ;; Check the signals
  (is (equal '()
             (list-signals "GtkGrid")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkGrid" GTK-GRID
                       (:SUPERCLASS GTK-CONTAINER :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable" "GtkOrientable")
                        :TYPE-INITIALIZER "gtk_grid_get_type")
                       ((BASELINE-ROW GTK-GRID-BASELINE-ROW "baseline-row"
                         "gint" T T)
                        (COLUMN-HOMOGENEOUS GTK-GRID-COLUMN-HOMOGENEOUS
                         "column-homogeneous" "gboolean" T T)
                        (COLUMN-SPACING GTK-GRID-COLUMN-SPACING
                         "column-spacing" "gint" T T)
                        (ROW-HOMOGENEOUS GTK-GRID-ROW-HOMOGENEOUS
                         "row-homogeneous" "gboolean" T T)
                        (ROW-SPACING GTK-GRID-ROW-SPACING "row-spacing" "gint"
                         T T)))
             (gobject:get-g-type-definition "GtkGrid"))))

;;; --- Properties -------------------------------------------------------------

(test grid-properties
  (let ((grid (make-instance 'gtk:grid)))
    (is (= 0 (gtk:grid-baseline-row grid)))
    (is-false (gtk:grid-column-homogeneous grid))
    (is (= 0 (gtk:grid-column-spacing grid)))
    (is-false (gtk:grid-row-homogeneous grid))
    (is (= 0 (gtk:grid-row-spacing grid)))))

;;; --- Child Properties -------------------------------------------------------

(test grid-child-properties
  (let ((grid (make-instance 'gtk:grid))
        (child (make-instance 'gtk:button)))
    (is-false (gtk:grid-attach grid child 0 0 1 1 ))
    (is (= 1 (gtk:grid-child-height grid child)))
    (is (= 0 (gtk:grid-child-left-attach grid child)))
    (is (= 0 (gtk:grid-child-top-attach grid child)))
    (is (= 1 (gtk:grid-child-width grid child)))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_grid_new

(test grid-new
  (is (eq 'gtk:grid (type-of (gtk:grid-new)))))

;;;     gtk_grid_attach
;;;     gtk_grid_attach_next_to
;;;     gtk_grid_get_child_at

(test grid-attach
  (let ((grid (make-instance 'gtk:grid))
        (button1 (make-instance 'gtk:button))
        (button2 (make-instance 'gtk:button))
        (button3 (make-instance 'gtk:button))
        (button4 (make-instance 'gtk:button)))

    (is (= 1 (gobject::ref-count button1)))

    (gtk:grid-attach grid button1 0 0 2 1)
    (gtk:grid-attach grid button2 1 1 1 2)

    (gtk:grid-attach-next-to grid button3 button1 :right 1 1)
    (gtk:grid-attach-next-to grid button4 button2 :left 1 1)

    (is (= 2 (gobject::ref-count button1)))

    (is (equal button1 (gtk:grid-child-at grid 0 0)))
    (let ((button (gtk:grid-child-at grid 0 0)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 0 (gtk:grid-child-left-attach grid button)))
      (is (= 0 (gtk:grid-child-top-attach grid button)))
      (is (= 2 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))

    (is (equal button2 (gtk:grid-child-at grid 1 1)))
    (let ((button (gtk:grid-child-at grid 1 1)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 1 (gtk:grid-child-left-attach grid button)))
      (is (= 1 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 2 (gtk:grid-child-height grid button))))

    (is (equal button3 (gtk:grid-child-at grid 2 0)))
    (let ((button (gtk:grid-child-at grid 2 0)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 2 (gtk:grid-child-left-attach grid button)))
      (is (= 0 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))

    (is (equal button4 (gtk:grid-child-at grid 0 1)))
    (let ((button (gtk:grid-child-at grid 0 1)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 0 (gtk:grid-child-left-attach grid button)))
      (is (= 1 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))
))

;;;     gtk_grid_insert_row
;;;     gtk_grid_insert_column
;;;     gtk_grid_remove_row
;;;     gtk_grid_remove_column

(test grid-insert
  (let ((grid (make-instance 'gtk:grid))
        (button1 (make-instance 'gtk:button))
        (button2 (make-instance 'gtk:button))
        (button3 (make-instance 'gtk:button))
        (button4 (make-instance 'gtk:button)))

    (is (= 1 (gobject::ref-count button1)))

    (gtk:grid-attach grid button1 0 0 2 1)
    (gtk:grid-attach grid button2 1 1 1 2)

    (gtk:grid-attach-next-to grid button3 button1 :right 1 1)
    (gtk:grid-attach-next-to grid button4 button2 :left 1 1)

    ;; Insert a row and a column
    (gtk:grid-insert-row grid 1)
    (gtk:grid-insert-column grid 1)

    (is (= 2 (gobject::ref-count button1)))

    (is (equal button1 (gtk:grid-child-at grid 0 0)))
    (let ((button (gtk:grid-child-at grid 0 0)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 0 (gtk:grid-child-left-attach grid button)))
      (is (= 0 (gtk:grid-child-top-attach grid button)))
      (is (= 3 (gtk:grid-child-width grid button)))  ; new width
      (is (= 1 (gtk:grid-child-height grid button))))

    (is (equal button2 (gtk:grid-child-at grid 2 2)))
    (let ((button (gtk:grid-child-at grid 2 2))) ; new position

      (is (= 2 (gobject::ref-count button)))

      (is (= 2 (gtk:grid-child-left-attach grid button)))
      (is (= 2 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 2 (gtk:grid-child-height grid button))))

    (is (equal button3 (gtk:grid-child-at grid 3 0)))
    (let ((button (gtk:grid-child-at grid 3 0))) ; new position

      (is (= 2 (gobject::ref-count button)))

      (is (= 3 (gtk:grid-child-left-attach grid button)))
      (is (= 0 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))

    (is (equal button4 (gtk:grid-child-at grid 0 2)))
    (let ((button (gtk:grid-child-at grid 0 2))) ; new position

      (is (= 2 (gobject::ref-count button)))

      (is (= 0 (gtk:grid-child-left-attach grid button)))
      (is (= 2 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))

    ;; Remove a row and a column
    (gtk:grid-remove-row grid 1)
    (gtk:grid-remove-column grid 1)

    (is (equal button1 (gtk:grid-child-at grid 0 0)))
    (let ((button (gtk:grid-child-at grid 0 0)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 0 (gtk:grid-child-left-attach grid button)))
      (is (= 0 (gtk:grid-child-top-attach grid button)))
      (is (= 2 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))

    (is (equal button2 (gtk:grid-child-at grid 1 1)))
    (let ((button (gtk:grid-child-at grid 1 1)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 1 (gtk:grid-child-left-attach grid button)))
      (is (= 1 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 2 (gtk:grid-child-height grid button))))

    (is (equal button3 (gtk:grid-child-at grid 2 0)))
    (let ((button (gtk:grid-child-at grid 2 0)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 2 (gtk:grid-child-left-attach grid button)))
      (is (= 0 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))

    (is (equal button4 (gtk:grid-child-at grid 0 1)))
    (let ((button (gtk:grid-child-at grid 0 1)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 0 (gtk:grid-child-left-attach grid button)))
      (is (= 1 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))
))

;;;     gtk_grid_insert_next_to

(test grid-insert-next-to
  (let ((grid (make-instance 'gtk:grid))
        (button1 (make-instance 'gtk:button))
        (button2 (make-instance 'gtk:button))
        (button3 (make-instance 'gtk:button))
        (button4 (make-instance 'gtk:button)))

    (is (= 1 (gobject::ref-count button1)))

    (gtk:grid-attach grid button1 0 0 2 1)
    (gtk:grid-attach grid button2 1 1 1 2)

    (gtk:grid-attach-next-to grid button3 button1 :right 1 1)
    (gtk:grid-attach-next-to grid button4 button2 :left 1 1)

    (gtk:grid-insert-next-to grid button2 :left)
    (gtk:grid-insert-next-to grid button2 :top)

    (is (= 2 (gobject::ref-count button1)))

    (is (equal button1 (gtk:grid-child-at grid 0 0)))
    (let ((button (gtk:grid-child-at grid 0 0)))

      (is (= 2 (gobject::ref-count button)))

      (is (= 0 (gtk:grid-child-left-attach grid button)))
      (is (= 0 (gtk:grid-child-top-attach grid button)))
      (is (= 3 (gtk:grid-child-width grid button)))  ; new width
      (is (= 1 (gtk:grid-child-height grid button))))

    (is (equal button2 (gtk:grid-child-at grid 2 2)))
    (let ((button (gtk:grid-child-at grid 2 2))) ; new position

      (is (= 2 (gobject::ref-count button)))

      (is (= 2 (gtk:grid-child-left-attach grid button)))
      (is (= 2 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 2 (gtk:grid-child-height grid button))))

    (is (equal button3 (gtk:grid-child-at grid 3 0)))
    (let ((button (gtk:grid-child-at grid 3 0))) ; new position

      (is (= 2 (gobject::ref-count button)))

      (is (= 3 (gtk:grid-child-left-attach grid button)))
      (is (= 0 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))

    (is (equal button4 (gtk:grid-child-at grid 0 2)))
    (let ((button (gtk:grid-child-at grid 0 2))) ; new position

      (is (= 2 (gobject::ref-count button)))

      (is (= 0 (gtk:grid-child-left-attach grid button)))
      (is (= 2 (gtk:grid-child-top-attach grid button)))
      (is (= 1 (gtk:grid-child-width grid button)))
      (is (= 1 (gtk:grid-child-height grid button))))
))

;;;     gtk_grid_get_row_baseline_position
;;;     gtk_grid_set_row_baseline_position

(test grid-row-baseline-position
  (let ((grid (make-instance 'gtk:grid))
        (button (make-instance 'gtk:button)))
    (is-false (gtk:grid-attach grid button 0 0 1 1))
    (is (eq :right (gtk:grid-row-baseline-position grid 0)))
    (is (eq :left (setf (gtk:grid-row-baseline-position grid 0) :left)))
    (is (eq :left (gtk:grid-row-baseline-position grid 0)))))

;;; --- 2023-5-29 --------------------------------------------------------------
