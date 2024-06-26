(in-package :gtk-test)

(def-suite gtk-offscreen-window :in gtk-suite)
(in-suite gtk-offscreen-window)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkOffscreenWindow

(test gtk-offscreen-window-class
  ;; Type check
  (is (g:type-is-object "GtkOffscreenWindow"))
  ;; Check the registered name
  (is (eq 'gtk:offscreen-window
          (glib:symbol-for-gtype "GtkOffscreenWindow")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkOffscreenWindow")
          (g:gtype (cffi:foreign-funcall "gtk_offscreen_window_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkWindow")
          (g:type-parent "GtkOffscreenWindow")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkOffscreenWindow")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable")
             (list-interfaces "GtkOffscreenWindow")))
  ;; Check the class properties
  (is (equal '()
             (list-properties "GtkOffscreenWindow")))
  ;; Get the names of the style properties
  (is (equal '()
             (list-style-properties "GtkOffscreenWindow")))
  ;; Get the names of the child properties
  (is (equal '()
             (list-child-properties "GtkOffscreenWindow")))
  ;; Check the signals
  (is (equal '()
             (list-signals "GtkOffscreenWindow")))
  ;; Check the class definition
  (is (equal '(GOBJECT:DEFINE-G-OBJECT-CLASS "GtkOffscreenWindow"
                                             GTK-OFFSCREEN-WINDOW
                       (:SUPERCLASS GTK-WINDOW :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable")
                        :TYPE-INITIALIZER "gtk_offscreen_window_get_type")
                       NIL)
             (gobject:get-g-type-definition "GtkOffscreenWindow"))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_offscreen_window_new

(test gtk-offscreen-window-new
  (is (typep (gtk:offscreen-window-new) 'gtk:offscreen-window)))

;;;     gtk_offscreen_window_get_surface

#+nil
(test gtk-offscreen-window-surface
  (let ((offscreen (gtk:offscreen-window-new)))
    (is-false (gtk:offscreen-window-surface offscreen))))

;;;     gtk_offscreen_window_get_pixbuf

#+nil
(test gtk-offscreen-window-pixbuf
  (let ((offscreen (gtk:offscreen-window-new)))
    (is-false (gtk:offscreen-window-pixbuf offscreen))))

;;; 2024-3-17
