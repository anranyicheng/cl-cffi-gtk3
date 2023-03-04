(in-package :gtk-test)

(def-suite gtk-cell-renderer-accel :in gtk-suite)
(in-suite gtk-cell-renderer-accel)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkCellRendererAccelMode

(test gtk-cell-renderer-accel-mode
  ;; Check the type
  (is (g:type-is-enum "GtkCellRendererAccelMode"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkCellRendererAccelMode")
          (g:gtype (cffi:foreign-funcall "gtk_cell_renderer_accel_mode_get_type"
                                         :size))))
  ;; Check the registered name
  (is (eq 'gtk:cell-renderer-accel-mode
          (gobject:symbol-for-gtype "GtkCellRendererAccelMode")))
  ;; Check the names
  (is (equal '("GTK_CELL_RENDERER_ACCEL_MODE_GTK"
               "GTK_CELL_RENDERER_ACCEL_MODE_OTHER"
               "GTK_CELL_RENDERER_ACCEL_MODE_MODIFIER_TAP")
             (list-enum-item-name "GtkCellRendererAccelMode")))
  ;; Check the values
  (is (equal '(0 1 2)
             (list-enum-item-value "GtkCellRendererAccelMode")))
  ;; Check the nick names
  (is (equal '("gtk" "other" "modifier-tap")
             (list-enum-item-nick "GtkCellRendererAccelMode")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkCellRendererAccelMode"
                             GTK-CELL-RENDERER-ACCEL-MODE
                             (:EXPORT T
                              :TYPE-INITIALIZER
                              "gtk_cell_renderer_accel_mode_get_type")
                             (:GTK 0)
                             (:OTHER 1)
                             (:MODIFIER-TAP 2))
             (gobject:get-g-type-definition "GtkCellRendererAccelMode"))))

;;;     GtkCellRendererAccel

(test cell-renderer-accel-class
  ;; Type check
  (is (g:type-is-object "GtkCellRendererAccel"))
  ;; Check the registered name
  (is (eq 'gtk:cell-renderer-accel
          (gobject:symbol-for-gtype "GtkCellRendererAccel")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkCellRendererAccel")
          (g:gtype (cffi:foreign-funcall "gtk_cell_renderer_accel_get_type"
                                         :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkCellRendererText")
          (g:type-parent "GtkCellRendererAccel")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkCellRendererAccel")))
  ;; Check the interfaces
  (is (equal '()
             (list-interfaces "GtkCellRendererAccel")))
  ;; Check the class properties
  (is (equal '("accel-key" "accel-mode" "accel-mods" "keycode")
             (list-properties "GtkCellRendererAccel")))
  ;; Check the signals
  (is (equal '("accel-cleared" "accel-edited")
             (list-signals "GtkCellRendererAccel")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkCellRendererAccel"
                                     GTK-CELL-RENDERER-ACCEL
                       (:SUPERCLASS GTK-CELL-RENDERER-TEXT :EXPORT T
                        :INTERFACES NIL :TYPE-INITIALIZER
                        "gtk_cell_renderer_accel_get_type")
                       ((ACCEL-KEY GTK-CELL-RENDERER-ACCEL-ACCEL-KEY
                         "accel-key" "guint" T T)
                        (ACCEL-MODE GTK-CELL-RENDERER-ACCEL-ACCEL-MODE
                         "accel-mode" "GtkCellRendererAccelMode" T T)
                        (ACCEL-MODS GTK-CELL-RENDERER-ACCEL-ACCEL-MODS
                         "accel-mods" "GdkModifierType" T T)
                        (KEYCODE GTK-CELL-RENDERER-ACCEL-KEYCODE "keycode"
                         "guint" T T)))
             (gobject:get-g-type-definition "GtkCellRendererAccel"))))

;;; --- Properties -------------------------------------------------------------

;;;     accel-key
;;;     accel-mode
;;;     accel-mods
;;;     keycode

;;; --- Signals ----------------------------------------------------------------

;;;     accel-cleared
;;;     accel-edited

;;; --- Functions --------------------------------------------------------------

;;;     gtk_cell_renderer_accel_new

;;; --- 2023-2-22 --------------------------------------------------------------
