(in-package :gtk-test)

(def-suite gtk-cell-renderer :in gtk-suite)
(in-suite gtk-cell-renderer)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkCellRendererState

(test gtk-cell-renderer-state
  ;; Check type
  (is (g:type-is-flags "GtkCellRendererState"))
  ;; Check registered name
  (is (eq 'gtk:cell-renderer-state
          (glib:symbol-for-gtype "GtkCellRendererState")))
  ;; Check type initializer
  (is (eq (g:gtype "GtkCellRendererState")
          (g:gtype (cffi:foreign-funcall "gtk_cell_renderer_state_get_type"
                                         :size))))
  ;; Check names
  (is (equal '("GTK_CELL_RENDERER_SELECTED" "GTK_CELL_RENDERER_PRELIT"
               "GTK_CELL_RENDERER_INSENSITIVE" "GTK_CELL_RENDERER_SORTED"
               "GTK_CELL_RENDERER_FOCUSED" "GTK_CELL_RENDERER_EXPANDABLE"
               "GTK_CELL_RENDERER_EXPANDED")
             (glib-test:list-flags-item-names "GtkCellRendererState")))
  ;; Check values
  (is (equal '(1 2 4 8 16 32 64)
             (glib-test:list-flags-item-values "GtkCellRendererState")))
  ;; Check nick names
  (is (equal '("selected" "prelit" "insensitive" "sorted" "focused" "expandable"
               "expanded")
             (glib-test:list-flags-item-nicks "GtkCellRendererState")))
  ;; Check flags definition
  (is (equal '(GOBJECT:DEFINE-GFLAGS "GtkCellRendererState"
                                     GTK:CELL-RENDERER-STATE
                       (:EXPORT T
                        :TYPE-INITIALIZER "gtk_cell_renderer_state_get_type")
                       (:SELECTED 1)
                       (:PRELIT 2)
                       (:INSENSITIVE 4)
                       (:SORTED 8)
                       (:FOCUSED 16)
                       (:EXPANDABLE 32)
                       (:EXPANDED 64))
             (gobject:get-gtype-definition "GtkCellRendererState"))))

;;;     GtkCellRendererMode

(test gtk-cell-renderer-mode
  ;; Check type
  (is (g:type-is-enum "GtkCellRendererMode"))
  ;; Check type initializer
  (is (eq (g:gtype "GtkCellRendererMode")
          (g:gtype (cffi:foreign-funcall "gtk_cell_renderer_mode_get_type" :size))))
  ;; Check registered name
  (is (eq 'gtk:cell-renderer-mode
          (glib:symbol-for-gtype "GtkCellRendererMode")))
  ;; Check names
  (is (equal '("GTK_CELL_RENDERER_MODE_INERT"
               "GTK_CELL_RENDERER_MODE_ACTIVATABLE"
               "GTK_CELL_RENDERER_MODE_EDITABLE")
             (glib-test:list-enum-item-names "GtkCellRendererMode")))
  ;; Check values
  (is (equal '(0 1 2)
             (glib-test:list-enum-item-values "GtkCellRendererMode")))
  ;; Check nick names
  (is (equal '("inert" "activatable" "editable")
             (glib-test:list-enum-item-nicks "GtkCellRendererMode")))
  ;; Check enum definition
  (is (equal '(GOBJECT:DEFINE-GENUM "GtkCellRendererMode" GTK:CELL-RENDERER-MODE
                       (:EXPORT T
                        :TYPE-INITIALIZER "gtk_cell_renderer_mode_get_type")
                       (:INERT 0)
                       (:ACTIVATABLE 1)
                       (:EDITABLE 2))
             (gobject:get-gtype-definition "GtkCellRendererMode"))))

;;;     GtkCellRenderer

(test gtk-cell-renderer-class
  ;; Check type
  (is (g:type-is-object "GtkCellRenderer"))
  ;; Check registered name
  (is (eq 'gtk:cell-renderer
          (glib:symbol-for-gtype "GtkCellRenderer")))
  ;; Check type initializer
  (is (eq (g:gtype "GtkCellRenderer")
          (g:gtype (cffi:foreign-funcall "gtk_cell_renderer_get_type" :size))))
  ;; Check parent
  (is (eq (g:gtype "GInitiallyUnowned")
          (g:type-parent "GtkCellRenderer")))
  ;; Check children
  (is (equal '("GtkCellRendererPixbuf" "GtkCellRendererProgress"
               "GtkCellRendererSpinner" "GtkCellRendererText"
               "GtkCellRendererToggle")
             (glib-test:list-children "GtkCellRenderer")))
  ;; Check interfaces
  (is (equal '()
             (glib-test:list-interfaces "GtkCellRenderer")))
  ;; Check class properties
  (is (equal '("cell-background" "cell-background-gdk" "cell-background-rgba"
               "cell-background-set" "editing" "height" "is-expanded"
               "is-expander" "mode" "sensitive" "visible" "width" "xalign"
               "xpad" "yalign" "ypad")
             (glib-test:list-properties "GtkCellRenderer")))
  ;; Check signals
  (is (equal '("editing-canceled" "editing-started")
             (glib-test:list-signals "GtkCellRenderer")))
  ;; Check class definition
  (is (equal '(GOBJECT:DEFINE-GOBJECT "GtkCellRenderer" GTK:CELL-RENDERER
                       (:SUPERCLASS G:INITIALLY-UNOWNED
                        :EXPORT T
                        :INTERFACES NIL
                        :TYPE-INITIALIZER "gtk_cell_renderer_get_type")
                       ((CELL-BACKGROUND CELL-RENDERER-CELL-BACKGROUND
                         "cell-background" "gchararray" NIL T)
                        (CELL-BACKGROUND-GDK CELL-RENDERER-CELL-BACKGROUND-GDK
                         "cell-background-gdk" "GdkColor" T T)
                        (CELL-BACKGROUND-RGBA CELL-RENDERER-CELL-BACKGROUND-RGBA
                         "cell-background-rgba" "GdkRGBA" T T)
                        (CELL-BACKGROUND-SET CELL-RENDERER-CELL-BACKGROUND-SET
                         "cell-background-set" "gboolean" T T)
                        (EDITING CELL-RENDERER-EDITING
                         "editing" "gboolean" T NIL)
                        (HEIGHT CELL-RENDERER-HEIGHT "height" "gint" T T)
                        (IS-EXPANDED CELL-RENDERER-IS-EXPANDED
                         "is-expanded" "gboolean" T T)
                        (IS-EXPANDER CELL-RENDERER-IS-EXPANDER
                         "is-expander" "gboolean" T T)
                        (MODE CELL-RENDERER-MODE
                         "mode" "GtkCellRendererMode" T T)
                        (SENSITIVE CELL-RENDERER-SENSITIVE
                         "sensitive" "gboolean" T T)
                        (VISIBLE CELL-RENDERER-VISIBLE
                         "visible" "gboolean" T T)
                        (WIDTH CELL-RENDERER-WIDTH "width" "gint" T T)
                        (XALIGN CELL-RENDERER-XALIGN "xalign" "gfloat" T T)
                        (XPAD CELL-RENDERER-XPAD "xpad" "guint" T T)
                        (YALIGN CELL-RENDERER-YALIGN "yalign" "gfloat" T T)
                        (YPAD CELL-RENDERER-YPAD "ypad" "guint" T T)))
             (gobject:get-gtype-definition "GtkCellRenderer"))))

;;; --- Properties -------------------------------------------------------------

(test gtk-cell-renderer-properties
  (let ((renderer (make-instance 'gtk:cell-renderer-text)))
    (signals (error) (gtk:cell-renderer-cell-background renderer))
    (is (typep (gtk:cell-renderer-cell-background-rgba renderer) 'gdk:rgba))
    (is-false (gtk:cell-renderer-cell-background-set renderer))
    (is-false (gtk:cell-renderer-editing renderer))
    (is (= -1 (gtk:cell-renderer-height renderer)))
    (is-false (gtk:cell-renderer-is-expanded renderer))
    (is-false (gtk:cell-renderer-is-expander renderer))
    (is (eq :inert (gtk:cell-renderer-mode renderer)))
    (is-true (gtk:cell-renderer-sensitive renderer))
    (is-true (gtk:cell-renderer-visible renderer))
    (is (= -1 (gtk:cell-renderer-width renderer)))
    (is (= 0.0 (gtk:cell-renderer-xalign renderer)))
    (is (= 2 (gtk:cell-renderer-xpad renderer)))
    (is (= 0.5 (gtk:cell-renderer-yalign renderer)))
    (is (= 2 (gtk:cell-renderer-ypad renderer)))))

;;; --- Signals ----------------------------------------------------------------

;;;     editing-canceled

(test gtk-cell-renderer-editing-canceled-signal
  ;; Query info for "editing-canceled" signal
  (let ((query (g:signal-query (g:signal-lookup "editing-canceled"
                                                "GtkCellRenderer"))))
    (is (string= "editing-canceled" (g:signal-query-signal-name query)))
    (is (string= "GtkCellRenderer"
                 (g:type-name (g:signal-query-owner-type query))))
    (is (equal '(:RUN-FIRST)
               (sort (g:signal-query-signal-flags query) #'string<)))
    (is (string= "void" (g:type-name (g:signal-query-return-type query))))
    (is (equal '()
               (mapcar #'g:type-name (g:signal-query-param-types query))))
    (is-false (g:signal-query-signal-detail query))))

;;;     editing-started

(test gtk-cell-renderer-editing-started-signal
  ;; Query info for "editing-canceled" signal
  (let ((query (g:signal-query (g:signal-lookup "editing-started"
                                                "GtkCellRenderer"))))
    (is (string= "editing-started" (g:signal-query-signal-name query)))
    (is (string= "GtkCellRenderer"
                 (g:type-name (g:signal-query-owner-type query))))
    (is (equal '(:RUN-FIRST)
               (sort (g:signal-query-signal-flags query) #'string<)))
    (is (string= "void" (g:type-name (g:signal-query-return-type query))))
    (is (equal '("GtkCellEditable" "gchararray")
               (mapcar #'g:type-name (g:signal-query-param-types query))))
    (is-false (g:signal-query-signal-detail query))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_cell_renderer_class_set_accessible_type
;;;     gtk_cell_renderer_get_aligned_area

;;;     gtk_cell_renderer_size

(test gtk-cell-renderer-size
  (let ((renderer (make-instance 'gtk:cell-renderer-text)))
    #-windows
    (is (equal '(0 0 4 21)
                (multiple-value-list
                  (gtk:cell-renderer-size renderer
                                          (make-instance 'gtk:button)
                                          (gdk:rectangle-new)))))
    #+windows
    (is (equal '(0 0 4 19)
                (multiple-value-list
                  (gtk:cell-renderer-size renderer
                                          (make-instance 'gtk:button)
                                          (gdk:rectangle-new)))))))

;;;     gtk_cell_renderer_render
;;;     gtk_cell_renderer_activate
;;;     gtk_cell_renderer_start_editing
;;;     gtk_cell_renderer_stop_editing
;;;     gtk_cell_renderer_get_fixed_size
;;;     gtk_cell_renderer_set_fixed_size

;;;     gtk_cell_renderer_get_alignment
;;;     gtk_cell_renderer_set_alignment

(test gtk-cell-renderer-alignment.1
  (let ((renderer (make-instance 'gtk:cell-renderer-text)))
    (is (equal '(0.0 0.5)
               (multiple-value-list (gtk:cell-renderer-alignment renderer))))
    (is (equal '(0.2 0.2)
               (multiple-value-list (setf (gtk:cell-renderer-alignment renderer)
                                          '(0.2 0.2)))))
    (is (equal '(0.2 0.2)
               (multiple-value-list (gtk:cell-renderer-alignment renderer))))))

(test gtk-cell-renderer-alignment.2
  (let ((renderer (make-instance 'gtk:cell-renderer-text)))
    (is (equal '(0.5 0.75)
               (multiple-value-list (setf (gtk:cell-renderer-alignment renderer)
                                          '(1/2 0.75d0)))))
    (is (equal '(0.5 0.75)
               (multiple-value-list (gtk:cell-renderer-alignment renderer))))))

;;;     gtk_cell_renderer_get_padding
;;;     gtk_cell_renderer_set_padding
;;;     gtk_cell_renderer_get_state
;;;     gtk_cell_renderer_is_activatable
;;;     gtk_cell_renderer_get_preferred_height
;;;     gtk_cell_renderer_get_preferred_height_for_width
;;;     gtk_cell_renderer_get_preferred_size
;;;     gtk_cell_renderer_get_preferred_width
;;;     gtk_cell_renderer_get_preferred_width_for_height
;;;     gtk_cell_renderer_get_request_mode

;;; 2024-9-22

