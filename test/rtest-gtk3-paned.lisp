(in-package :gtk-test)

(def-suite gtk-paned :in gtk-suite)
(in-suite gtk-paned)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkPaned

(test paned-class
  ;; Type check
  (is (g:type-is-object "GtkPaned"))
  ;; Check the registered name
  (is (eq 'gtk:paned
          (gobject:symbol-for-gtype "GtkPaned")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkPaned")
          (g:gtype (cffi:foreign-funcall "gtk_paned_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkContainer") (g:type-parent "GtkPaned")))
  ;; Check the children
  (is (equal '("GtkHPaned" "GtkVPaned")
             (list-children "GtkPaned")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable" "GtkOrientable")
             (list-interfaces "GtkPaned")))
  ;; Check the class properties
  (is (equal '("max-position" "min-position" "orientation" "position"
               "position-set" "wide-handle")
             (list-properties "GtkPaned")))
  ;; Get the names of the style properties.
  (is (equal '("handle-size")
             (list-style-properties "GtkPaned")))
  ;; Get the names of the child properties
  (is (equal '("resize" "shrink")
             (list-child-properties "GtkPaned")))
  ;; Check the signals
  (is (equal '("accept-position" "cancel-position" "cycle-child-focus"
               "cycle-handle-focus" "move-handle" "toggle-handle-focus")
             (list-signals "GtkPaned")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkPaned" GTK-PANED
                       (:SUPERCLASS GTK-CONTAINER :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable" "GtkOrientable")
                        :TYPE-INITIALIZER "gtk_paned_get_type")
                       ((MAX-POSITION GTK-PANED-MAX-POSITION "max-position"
                         "gint" T NIL)
                        (MIN-POSITION GTK-PANED-MIN-POSITION "min-position"
                         "gint" T NIL)
                        (POSITION GTK-PANED-POSITION "position" "gint" T T)
                        (POSITION-SET GTK-PANED-POSITION-SET "position-set"
                         "gboolean" T T)
                        (WIDE-HANDLE GTK-PANED-WIDE-HANDLE "wide-handle"
                         "gboolean" T T)))
             (gobject:get-g-type-definition "GtkPaned"))))

;;; --- Properties -------------------------------------------------------------

(test paned-properties
  (let ((paned (make-instance 'gtk:paned :orientation :horizontal)))
    ;; max-position
    (is (= 2147483647 (gtk:paned-max-position paned)))
    (signals (error) (setf (gtk:paned-max-position paned) 1000))
    ;; min-position
    (is (= 0 (gtk:paned-min-position paned)))
    (signals (error) (setf (gtk:paned-max-position paned) 1000))
    ;; position
    (is (= 0 (gtk:paned-position paned)))
    (is (= 100 (setf (gtk:paned-position paned) 100)))
    (is (= 100 (gtk:paned-position paned) 100))
    ;; position-set
    (is-true (gtk:paned-position-set paned))
    (is-false (setf (gtk:paned-position-set paned) nil))
    (is-false (gtk:paned-position-set paned))
    ;; wide-handle
    (is-false (gtk:paned-wide-handle paned))
    (is-true (setf (gtk:paned-wide-handle paned) t))
    (is-true (gtk:paned-wide-handle paned))))

;;; --- Child Properties -------------------------------------------------------

(test paned-child-properties
  (let* ((paned (make-instance 'gtk:paned :orientation :horizontal))
         (child1 (make-instance 'gtk:button))
         (child2 (make-instance 'gtk:button)))
    ;; add child1
    (is-false (gtk:paned-add1 paned child1))
    ;; resize for child1
    (is-false (gtk:paned-child-resize paned child1))
    (is-true (setf (gtk:paned-child-resize paned child1) t))
    (is-true (gtk:paned-child-resize paned child1))
    ;; shrink for child1
    (is-true (gtk:paned-child-shrink paned child1))
    (is-false (setf (gtk:paned-child-shrink paned child1) nil))
    (is-false (gtk:paned-child-shrink paned child1))
    ;; add child2
    (is-false (gtk:paned-add2 paned child2))
    ;; resize for child2
    (is-true (gtk:paned-child-resize paned child2))
    (is-false (setf (gtk:paned-child-resize paned child2) nil))
    (is-false (gtk:paned-child-resize paned child2))
    ;; shrink for child2
    (is-true (gtk:paned-child-shrink paned child2))
    (is-false (setf (gtk:paned-child-shrink paned child2) nil))
    (is-false (gtk:paned-child-shrink paned child2))))

;;; --- Style Properties -------------------------------------------------------

(test paned-style-properties
  (let ((paned (make-instance 'gtk:paned :orientation :horizontal)))
    (is (= 5 (gtk:widget-style-property paned "handle-size")))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_paned_new

(test paned-new
  (is (eq 'gtk:paned (type-of (gtk:paned-new :vertical))))
  (is (eq 'gtk:paned (type-of (gtk:paned-new :horizontal)))))

;;;     gtk_paned_add1
;;;     gtk_paned_add2

(test paned-add
  (let ((paned (gtk:paned-new :horizontal))
        (child1 (make-instance 'gtk:frame))
        (child2 (make-instance 'gtk:frame)))

    (is-false (gtk:paned-add1 paned child1))
    (is-false (gtk:paned-child-resize paned child1))
    (is-true (gtk:paned-child-shrink paned child1))

    (is-false (gtk:paned-add2 paned child2))
    (is-true (gtk:paned-child-resize paned child2))
    (is-true (gtk:paned-child-shrink paned child2))))

;;;     gtk_paned_pack1
;;;     gtk_paned_pack2

(test paned-pack.1
  (let ((paned (gtk:paned-new :horizontal))
        (child1 (make-instance 'gtk:frame))
        (child2 (make-instance 'gtk:frame)))

    (is-false (gtk:paned-pack1 paned child1))
    (is-false (gtk:paned-child-resize paned child1))
    (is-true (gtk:paned-child-shrink paned child1))

    (is-false (gtk:paned-pack2 paned child2))
    (is-true (gtk:paned-child-resize paned child2))
    (is-true (gtk:paned-child-shrink paned child2))))

(test paned-pack.2
  (let ((paned (gtk:paned-new :horizontal))
        (child1 (make-instance 'gtk:frame))
        (child2 (make-instance 'gtk:frame)))

    (is-false (gtk:paned-pack1 paned child1 :resize t :shrink nil))
    (is-true (gtk:paned-child-resize paned child1))
    (is-false (gtk:paned-child-shrink paned child1))

    (is-false (gtk:paned-pack2 paned child2 :resize nil :shrink nil))
    (is-false (gtk:paned-child-resize paned child2))
    (is-false (gtk:paned-child-shrink paned child2))))

;;;     gtk_paned_get_child1
;;;     gtk_paned_get_child2

(test paned-child
  (let ((paned (gtk:paned-new :horizontal))
        (child1 (make-instance 'gtk:frame))
        (child2 (make-instance 'gtk:frame)))

    (is-false (gtk:paned-pack1 paned child1 :resize t :shrink nil))
    (is (eq 'gtk:frame (type-of (gtk:paned-child1 paned))))

    (is-false (gtk:paned-pack2 paned child2 :resize nil :shrink nil))
    (is (eq 'gtk:frame (type-of (gtk:paned-child2 paned))))))

;;;     gtk_paned_get_handle_window

(test -paned-handle-window
  (let ((paned (gtk:paned-new :horizontal)))
    ;; no handle because paned is not realized
    (is-false (gtk:paned-handle-window paned))))

;;; --- 2023-1-29 --------------------------------------------------------------
