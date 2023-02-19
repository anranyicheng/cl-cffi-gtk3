(in-package :gtk-test)

(def-suite gtk-widget :in gtk-suite)
(in-suite gtk-widget)

;;; --- Types and Values -------------------------------------------------------

;;;  	GtkRequisition

(test requisition
  ;; Type check
  (is-true (g:type-is-a (g:gtype "GtkRequisition") +g-type-boxed+))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkRequisition")
          (g:gtype (cffi:foreign-funcall "gtk_requisition_get_type" :size)))))

(test requisition-new
  (is (typep (gtk:requisition-new) 'gtk:requisition)))

(test requisition-copy
  (let ((requisition (gtk:requisition-new)))
    (is (typep (gtk:requisition-copy requisition) 'gtk:requisition))))

(test requisition-accessors
  (let ((requisition (gtk:requisition-new)))
    (is (= 0 (gtk:requisition-width requisition)))
    (is (= 0 (gtk:requisition-height requisition)))))

;;;     GtkAllocation

;; not implemented

;;;     GtkWidgetHelpType

(test widget-help-type
  ;; Check the type-widget-help-type
  (is-true (g:type-is-enum "GtkWidgetHelpType"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkWidgetHelpType")
          (g:gtype (cffi:foreign-funcall "gtk_widget_help_type_get_type"
                                         :size))))
  ;; Check the registered name
  (is (eq 'gtk:widget-help-type
          (gobject:symbol-for-gtype "GtkWidgetHelpType")))
  ;; Check the names
  (is (equal '("GTK_WIDGET_HELP_TOOLTIP" "GTK_WIDGET_HELP_WHATS_THIS")
             (list-enum-item-name "GtkWidgetHelpType")))
  ;; Check the values
  (is (equal '(0 1)
             (list-enum-item-value "GtkWidgetHelpType")))
  ;; Check the nick names
  (is (equal '("tooltip" "whats-this")
             (list-enum-item-nick "GtkWidgetHelpType")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkWidgetHelpType"
                             GTK-WIDGET-HELP-TYPE
                             (:EXPORT T
                              :TYPE-INITIALIZER "gtk_widget_help_type_get_type")
                             (:TOOLTIP 0)
                             (:WHATS-THIS 1))
             (gobject::get-g-type-definition "GtkWidgetHelpType"))))

;;;     GtkSizeRequestMode
;;;     GtkRequestedSize
;;;     GtkAlign

;;; --- GtkWidget --------------------------------------------------------------

(test widget-class
  ;; Type check
  (is (g:type-is-object "GtkWidget"))
  ;; Check the registered name
  (is (eq 'gtk:widget
          (gobject:symbol-for-gtype "GtkWidget")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkWidget")
          (g:gtype (cffi:foreign-funcall "gtk_widget_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GInitiallyUnowned") (g:type-parent "GtkWidget")))
  ;; Check the children
  (is (or (equal '("GtkCalendar" "GtkCellView" "GtkContainer" "GtkDrawingArea"
                   "GtkEntry" "GtkHSV" "GtkInvisible" "GtkLevelBar" "GtkMisc"
                   "GtkProgressBar" "GtkRange" "GtkSeparator" "GtkSpinner"
                   "GtkSwitch")
                 (list-children "GtkWidget"))
          (equal '("GtkCalendar" "GtkCellView" "GtkContainer" "GtkDrawingArea"
                   "GtkEntry" "GtkHSV" "GtkIcon" "GtkInvisible" "GtkLevelBar"
                   "GtkMisc" "GtkProgressBar" "GtkRange" "GtkSeparator"
                   "GtkSpinner" "GtkSwitch")
                 (list-children "GtkWidget"))))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable")
             (list-interfaces "GtkWidget")))
  ;; Get the class properties
  (is (equal '("app-paintable" "can-default" "can-focus" "composite-child"
               "double-buffered" "events" "expand" "focus-on-click" "halign"
               "has-default" "has-focus" "has-tooltip" "height-request"
               "hexpand" "hexpand-set" "is-focus" "margin" "margin-bottom"
               "margin-end" "margin-left" "margin-right" "margin-start"
               "margin-top" "name" "no-show-all" "opacity" "parent"
               "receives-default" "scale-factor" "sensitive" "style"
               "tooltip-markup" "tooltip-text" "valign" "vexpand" "vexpand-set"
               "visible" "width-request" "window")
             (list-properties "GtkWidget")))
  ;; Get the style properties
  (is (equal '("cursor-aspect-ratio" "cursor-color" "focus-line-pattern"
               "focus-line-width" "focus-padding" "interior-focus" "link-color"
               "scroll-arrow-hlength" "scroll-arrow-vlength"
               "secondary-cursor-color" "separator-height" "separator-width"
               "text-handle-height" "text-handle-width" "visited-link-color"
               "wide-separators" "window-dragging")
             (list-style-properties "GtkWidget")))
  ;; Check the signals
  (is (equal '("accel-closures-changed" "button-press-event"
               "button-release-event" "can-activate-accel" "child-notify"
               "composited-changed" "configure-event" "damage-event"
               "delete-event" "destroy" "destroy-event" "direction-changed"
               "drag-begin" "drag-data-delete" "drag-data-get"
               "drag-data-received" "drag-drop" "drag-end" "drag-failed"
               "drag-leave" "drag-motion" "draw" "enter-notify-event" "event"
               "event-after" "focus" "focus-in-event" "focus-out-event"
               "grab-broken-event" "grab-focus" "grab-notify" "hide"
               "hierarchy-changed" "key-press-event" "key-release-event"
               "keynav-failed" "leave-notify-event" "map" "map-event"
               "mnemonic-activate" "motion-notify-event" "move-focus"
               "parent-set" "popup-menu" "property-notify-event"
               "proximity-in-event" "proximity-out-event" "query-tooltip"
               "realize" "screen-changed" "scroll-event" "selection-clear-event"
               "selection-get" "selection-notify-event" "selection-received"
               "selection-request-event" "show" "show-help" "size-allocate"
               "state-changed" "state-flags-changed" "style-set" "style-updated"
               "touch-event" "unmap" "unmap-event" "unrealize"
               "visibility-notify-event" "window-state-event")
             (list-signals "GtkWidget")))
  ;; Get the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkWidget" GTK-WIDGET
                       (:SUPERCLASS G-INITIALLY-UNOWNED :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable")
                        :TYPE-INITIALIZER "gtk_widget_get_type")
                       ((APP-PAINTABLE GTK-WIDGET-APP-PAINTABLE "app-paintable"
                         "gboolean" T T)
                        (CAN-DEFAULT GTK-WIDGET-CAN-DEFAULT "can-default"
                         "gboolean" T T)
                        (CAN-FOCUS GTK-WIDGET-CAN-FOCUS "can-focus" "gboolean"
                         T T)
                        (COMPOSITE-CHILD GTK-WIDGET-COMPOSITE-CHILD
                         "composite-child" "gboolean" T NIL)
                        (DOUBLE-BUFFERED GTK-WIDGET-DOUBLE-BUFFERED
                         "double-buffered" "gboolean" T T)
                        (EVENTS GTK-WIDGET-EVENTS "events" "GdkEventMask" T T)
                        (EXPAND GTK-WIDGET-EXPAND "expand" "gboolean" T T)
                        (FOCUS-ON-CLICK GTK-WIDGET-FOCUS-ON-CLICK
                         "focus-on-click" "gboolean" T T)
                        (HALIGN GTK-WIDGET-HALIGN "halign" "GtkAlign" T T)
                        (HAS-DEFAULT GTK-WIDGET-HAS-DEFAULT "has-default"
                         "gboolean" T T)
                        (HAS-FOCUS GTK-WIDGET-HAS-FOCUS "has-focus" "gboolean"
                         T T)
                        (HAS-TOOLTIP GTK-WIDGET-HAS-TOOLTIP "has-tooltip"
                         "gboolean" T T)
                        (HEIGHT-REQUEST GTK-WIDGET-HEIGHT-REQUEST
                         "height-request" "gint" T T)
                        (HEXPAND GTK-WIDGET-HEXPAND "hexpand" "gboolean" T T)
                        (HEXPAND-SET GTK-WIDGET-HEXPAND-SET "hexpand-set"
                         "gboolean" T T)
                        (IS-FOCUS GTK-WIDGET-IS-FOCUS "is-focus" "gboolean" T
                         T)
                        (MARGIN GTK-WIDGET-MARGIN "margin" "gint" T T)
                        (MARGIN-BOTTOM GTK-WIDGET-MARGIN-BOTTOM "margin-bottom"
                         "gint" T T)
                        (MARGIN-END GTK-WIDGET-MARGIN-END "margin-end" "gint" T
                         T)
                        (MARGIN-LEFT GTK-WIDGET-MARGIN-LEFT "margin-left"
                         "gint" T T)
                        (MARGIN-RIGHT GTK-WIDGET-MARGIN-RIGHT "margin-right"
                         "gint" T T)
                        (MARGIN-START GTK-WIDGET-MARGIN-START "margin-start"
                         "gint" T T)
                        (MARGIN-TOP GTK-WIDGET-MARGIN-TOP "margin-top" "gint" T
                         T)
                        (NAME GTK-WIDGET-NAME "name" "gchararray" T T)
                        (NO-SHOW-ALL GTK-WIDGET-NO-SHOW-ALL "no-show-all"
                         "gboolean" T T)
                        (OPACITY GTK-WIDGET-OPACITY "opacity" "gdouble" T T)
                        (PARENT GTK-WIDGET-PARENT "parent" "GtkContainer" T T)
                        (RECEIVES-DEFAULT GTK-WIDGET-RECEIVES-DEFAULT
                         "receives-default" "gboolean" T T)
                        (SCALE-FACTOR GTK-WIDGET-SCALE-FACTOR "scale-factor"
                         "gint" T NIL)
                        (SENSITIVE GTK-WIDGET-SENSITIVE "sensitive" "gboolean"
                         T T)
                        (STYLE GTK-WIDGET-STYLE "style" "GtkStyle" T T)
                        (TOOLTIP-MARKUP GTK-WIDGET-TOOLTIP-MARKUP
                         "tooltip-markup" "gchararray" T T)
                        (TOOLTIP-TEXT GTK-WIDGET-TOOLTIP-TEXT "tooltip-text"
                         "gchararray" T T)
                        (VALIGN GTK-WIDGET-VALIGN "valign" "GtkAlign" T T)
                        (VEXPAND GTK-WIDGET-VEXPAND "vexpand" "gboolean" T T)
                        (VEXPAND-SET GTK-WIDGET-VEXPAND-SET "vexpand-set"
                         "gboolean" T T)
                        (VISIBLE GTK-WIDGET-VISIBLE "visible" "gboolean" T T)
                        (WIDTH-REQUEST GTK-WIDGET-WIDTH-REQUEST "width-request"
                         "gint" T T)
                        (WINDOW GTK-WIDGET-WINDOW "window" "GdkWindow" T NIL)))
             (gobject:get-g-type-definition "GtkWidget"))))

;;; ----------------------------------------------------------------------------
;;; Check accessor functions of GtkWidget
;;; ----------------------------------------------------------------------------

;;; --- widget-app-paintable ---------------------------------------------------

(test widget-app-paintable.1
  (let ((widget (make-instance 'gtk:label)))
    ;; The default value is false.
    (is-false (gtk:widget-app-paintable widget))
    (is-true (setf (gtk:widget-app-paintable widget) t))
    (is-true (gtk:widget-app-paintable widget))))

(test widget-app-paintable.2
  (let ((widget (make-instance 'gtk:label :app-paintable t)))
    ;; The value is set to true.
    (is-true (gtk:widget-app-paintable widget))
    (is-false (setf (gtk:widget-app-paintable widget) nil))
    (is-false (gtk:widget-app-paintable widget))))

;;; --- widget-can-default -------------------------------------------------

(test widget-can-default.1
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is false.
    (is-false (gtk:widget-can-default widget))
    (is-true (setf (gtk:widget-can-default widget) t))
    (is-true (gtk:widget-can-default widget))))

(test widget-can-default.2
  (let ((widget (make-instance 'gtk:button :can-default t)))
    ;; The value is set to true.
    (is-true (gtk:widget-can-default widget))
    (is-false (setf (gtk:widget-can-default widget) nil))
    (is-false (gtk:widget-can-default widget))))

;;; --- widget-can-focus ---------------------------------------------------

(test widget-can-focus.1
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is true? The documentation says false!
    (is-true (gtk:widget-can-focus widget))
    (is-false (setf (gtk:widget-can-focus widget) nil))
    (is-false (gtk:widget-can-focus widget))))

(test widget-can-focus.2
  (let ((widget (make-instance 'gtk:button :can-focus nil)))
    ;; The value is set to false.
    (is-false (gtk:widget-can-focus widget))
    (is-true (setf (gtk:widget-can-focus widget) t))
    (is-true (gtk:widget-can-focus widget))))

;;; --- widget-composite-child ---------------------------------------------

(test widget-composite-child
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is false.
    (is-false (gtk:widget-composite-child widget))
    ;; "composite-child" is not writable.
    (signals (error) (setf (gtk:widget-composite-child widget) t))))

;;; --- widget-double-buffered ---------------------------------------------

(test widget-double-buffered.1
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is true.
    (is-true (gtk:widget-double-buffered widget))
    (is-false (setf (gtk:widget-double-buffered widget) nil))
    (is-false (gtk:widget-double-buffered widget))))

(test widget-double-buffered.2
  (let ((widget (make-instance 'gtk:button :double-buffered nil)))
    ;; The value is set to false.
    (is-false (gtk:widget-double-buffered widget))
    (is-true (setf (gtk:widget-double-buffered widget) t))
    (is-true (gtk:widget-double-buffered widget))))

;;; --- widget-events ------------------------------------------------------

(test widget-events.1
  (let ((widget (make-instance 'gtk:event-box)))
    ;; The default value is false.
    (is-false (gtk:widget-events widget))
    (is (equal '(:button-press-mask)
               (setf (gtk:widget-events widget) '(:button-press-mask))))
    (is (equal '(:button-press-mask) (gtk:widget-events widget)))))

(test widget-events.2
  (let ((widget (make-instance 'gtk:event-box :events '(:button-press-mask))))
    ;; The value is set to '(:button-press-mask).
    (is (equal '(:button-press-mask) (gtk:widget-events widget)))))

;;; --- widget-expand ------------------------------------------------------

(test widget-expand.1
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is false.
    (is-false (gtk:widget-expand widget))
    ;; These are default values.
    (is-false (gtk:widget-hexpand widget))
    (is-false (gtk:widget-hexpand-set widget))
    (is-false (gtk:widget-vexpand widget))
    (is-false (gtk:widget-vexpand-set widget))
    ;; Setting "expand"
    (is-true (setf (gtk:widget-expand widget) t))
    ;; These values change to true.
    (is-true (gtk:widget-hexpand widget))
    (is-true (gtk:widget-hexpand-set widget))
    (is-true (gtk:widget-vexpand widget))
    (is-true (gtk:widget-vexpand-set widget))))

(test widget-expand.2
  (let ((widget (make-instance 'gtk:button :expand t)))
    ;; The value is set true.
    (is-true (setf (gtk:widget-expand widget) t))
    ;; These values change to true.
    (is-true (gtk:widget-hexpand widget))
    (is-true (gtk:widget-hexpand-set widget))
    (is-true (gtk:widget-vexpand widget))
    (is-true (gtk:widget-vexpand-set widget))))

;;; --- widget-focus-on-click ----------------------------------------------

(test widget-focus-on-click.1
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is true.
    (is-true (gtk:widget-focus-on-click widget))
    (is-false (setf (gtk:widget-focus-on-click widget) nil))
    (is-false (gtk:widget-focus-on-click widget))))

(test widget-focus-on-click.2
  (let ((widget (make-instance 'gtk:button :focus-on-click nil)))
    ;; The value is set to false.
    (is-false (gtk:widget-focus-on-click widget))
    (is-true (setf (gtk:widget-focus-on-click widget) t))
    (is-true (gtk:widget-focus-on-click widget))))

;;; --- widget-halign ------------------------------------------------------

(test widget-halign.1
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is :fill.
    (is (eql :fill (gtk:widget-halign widget)))
    (is (eql :start (setf (gtk:widget-halign widget) :start)))
    (is (eql :start (gtk:widget-halign widget)))))

(test widget-halign.2
  (let ((widget (make-instance 'gtk:button :halign :end)))
    ;; The value is set to :end.
    (is (eql :end (gtk:widget-halign widget)))
    (is (eql :center (setf (gtk:widget-halign widget) :center)))
    (is (eql :center (gtk:widget-halign widget)))))

;;; --- widget-has-default -------------------------------------------------

(test widget-has-default
  (let ((window (make-instance 'gtk:window :type :toplevel))
        (button (make-instance 'gtk:button :can-default t)))
    (gtk:container-add window button)
    ;; The default value is false.
    (is-false (gtk:widget-has-default button))
    (is-true (gtk:widget-can-default button))
    ;; Grab focus on button and check "has-default"
    (gtk:widget-grab-focus button)
    (is-true (gtk:widget-has-default button))))

;;; --- widget-has-focus ---------------------------------------------------

;; Implement a test which gives a widget the focus.

(test widget-has-focus
  (let ((window (make-instance 'gtk:window :type :toplevel))
        (button (make-instance 'gtk:button :can-default t
                                           :can-focus t)))
    (gtk:container-add window button)
    ;; The default value is false.
    (is-false (gtk:widget-has-focus button))
    (is-true (gtk:widget-can-default button))
    (is-true (gtk:widget-can-focus button))
    (gtk:widget-grab-focus button)
    ;; This dos not return the expected true value.
    (is-false (gtk:widget-has-focus button))))

;;; --- widget-has-tooltip -------------------------------------------------

(test widget-has-tooltip.1
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is false.
    (is-false (gtk:widget-has-tooltip widget))
    ;; Set a tooltip text and check again.
    (is (equal "Tooltip" (setf (gtk:widget-tooltip-text widget) "Tooltip")))
    (is-true (gtk:widget-has-tooltip widget))))

(test widget-has-tooltip.2
  (let ((widget (make-instance 'gtk:button :tooltip-text "Tooltip")))
    ;; A tooltip is added.
    (is-true (gtk:widget-has-tooltip widget))
    (is (equal "Tooltip" (gtk:widget-tooltip-text widget)))))

;;; --- widget-height-request ----------------------------------------------

(test widget-height-request
  (let ((widget (make-instance 'gtk:button)))
    (is (eql -1 (gtk:widget-height-request widget)))
    (is (eql 10 (setf (gtk:widget-height-request widget) 10)))
    (is (eql 10 (gtk:widget-height-request widget)))))

;;; --- widget-valign ------------------------------------------------------

(test widget-valign.1
  (let ((widget (make-instance 'gtk:button)))
    ;; The default value is :fill.
    (is (eql :fill (gtk:widget-valign widget)))
    (is (eql :start (setf (gtk:widget-valign widget) :start)))
    (is (eql :start (gtk:widget-valign widget)))))

(test widget-valign.2
  (let ((widget (make-instance 'gtk:button :valign :end)))
    ;; The value is set to :end.
    (is (eql :end (gtk:widget-valign widget)))
    (is (eql :center (setf (gtk:widget-valign widget) :center)))
    (is (eql :center (gtk:widget-valign widget)))))

;;; --- widget-width-request -----------------------------------------------

(test widget-width-request
  (let ((widget (make-instance 'gtk:button)))
    (is (eql -1 (gtk:widget-width-request widget)))
    (is (eql 10 (setf (gtk:widget-width-request widget) 10)))
    (is (eql 10 (gtk:widget-width-request widget)))))

;;; --- Signals ----------------------------------------------------------------

#+nil
(test widget-show-help-signal
  (let* ((message nil)
         (button (make-instance 'gtk:button))
         (handler-id (g-signal-connect button "show-help"
                       (lambda (widget help-type)
                         (declare (ignore widget))
                         (setf message "Signal show-help")
                         (is (eq :whats-this help-type))
                         t))))
    (is (integerp handler-id))
    ;; Emit the signal show-help
    (is-true (g-signal-emit button "show-help" :whats-this))
    (is (string= "Signal show-help" message))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_widget_new
;;;     gtk_widget_destroy
;;;     gtk_widget_in_destruction
;;;     gtk_widget_destroyed
;;;     gtk_widget_unparent
;;;     gtk_widget_show
;;;     gtk_widget_show_now
;;;     gtk_widget_hide
;;;     gtk_widget_show_all
;;;     gtk_widget_map
;;;     gtk_widget_unmap
;;;     gtk_widget_realize
;;;     gtk_widget_unrealize
;;;     gtk_widget_draw
;;;     gtk_widget_queue_draw
;;;     gtk_widget_queue_resize
;;;     gtk_widget_queue_resize_no_redraw
;;;     gtk_widget_size_request
;;;     gtk_widget_get_child_requisition
;;;     gtk_widget_size_allocate
;;;     gtk_widget_add_accelerator
;;;     gtk_widget_remove_accelerator
;;;     gtk_widget_set_accel_path
;;;     gtk_widget_list_accel_closures
;;;     gtk_widget_can_activate_accel
;;;     gtk_widget_event
;;;     gtk_widget_activate
;;;     gtk_widget_reparent
;;;     gtk_widget_intersect
;;;     gtk_widget_is_focus
;;;     gtk_widget_grab_focus
;;;     gtk_widget_grab_default
;;;     gtk_widget_set_name
;;;     gtk_widget_get_name
;;;     gtk_widget_set_state
;;;     gtk_widget_set_sensitive
;;;     gtk_widget_set_parent
;;;     gtk_widget_set_parent_window
;;;     gtk_widget_get_parent_window

;;;     gtk_widget_set_events
;;;     gtk_widget_get_events
;;;     gtk_widget_add_events

(test widget-add-events
  (let ((eventbox (make-instance 'gtk:event-box)))
    (is (equal '() (gtk:widget-events eventbox)))
    (setf (gtk:widget-events eventbox) '(:button-press-mask))
    (is (equal '(:button-press-mask) (gtk:widget-events eventbox)))
    (gtk:widget-add-events eventbox
                           '(:pointer-motion-mask :button-release-mask))
    (is (equal '(:BUTTON-PRESS-MASK :BUTTON-RELEASE-MASK :POINTER-MOTION-MASK)
               (stable-sort (gtk:widget-events eventbox)
                            #'string< :key #'symbol-name)))))

;;;     gtk_widget_set_device_events
;;;     gtk_widget_get_device_events
;;;     gtk_widget_add_device_events
;;;     gtk_widget_set_device_enabled
;;;     gtk_widget_get_device_enabled
;;;     gtk_widget_get_toplevel
;;;     gtk_widget_get_ancestor
;;;     gtk_widget_get_visual
;;;     gtk_widget_set_visual
;;;     gtk_widget_get_pointer
;;;     gtk_widget_is_ancestor
;;;     gtk_widget_translate_coordinates
;;;     gtk_widget_hide_on_delete
;;;     gtk_widget_set_style
;;;     gtk_widget_ensure_style
;;;     gtk_widget_get_style
;;;     gtk_widget_reset_rc_styles
;;;     gtk_widget_get_default_style

;;;     GtkTextDirection

(test text-direction
  ;; Check the type
  (is (g:type-is-enum "GtkTextDirection"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkTextDirection")
          (g:gtype (cffi:foreign-funcall "gtk_text_direction_get_type" :size))))
  ;; Check the registered name
  (is (eq 'gtk:text-direction
          (gobject:symbol-for-gtype "GtkTextDirection")))
  ;; Check the names
  (is (equal '("GTK_TEXT_DIR_NONE" "GTK_TEXT_DIR_LTR" "GTK_TEXT_DIR_RTL")
             (list-enum-item-name "GtkTextDirection")))
  ;; Check the values
  (is (equal '(0 1 2)
             (list-enum-item-value "GtkTextDirection")))
  ;; Check the nick names
  (is (equal '("none" "ltr" "rtl")
             (list-enum-item-nick "GtkTextDirection")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkTextDirection"
                             GTK-TEXT-DIRECTION
                             (:EXPORT T
                              :TYPE-INITIALIZER "gtk_text_direction_get_type")
                             (:NONE 0)
                             (:LTR 1)
                             (:RTL 2))
             (gobject:get-g-type-definition "GtkTextDirection"))))

;;;     gtk_widget_direction
;;;     gtk_widget_default_direction

(test widget-direction.1
  (let ((label (make-instance 'gtk:label)))
    (is (eq :ltr (gtk:widget-default-direction)))
    (is (eq :ltr (gtk:widget-direction label)))))

;; TODO: Causes test failures in a second run of the testsuite

#+nil
(test widget-direction.2
  (let ((label (make-instance 'gtk:label))
        ;; Store the default value of the text direction
        (default (gtk:widget-default-direction)))
    (is (eq :ltr (gtk:widget-default-direction)))
    (is (eq :ltr (gtk:widget-direction label)))
    (is (eq :rtl (setf (gtk:widget-direction label) :rtl)))
    (is (eq :rtl (gtk:widget-direction label)))
    ;; Set direction to :none
    (is (eq :none (setf (gtk:widget-direction label) :none)))
    ;; the default direction, if :none
    (is (eq :ltr (gtk:widget-direction label)))
    ;; Set the default direction
    (is (eq :rtl (setf (gtk:widget-default-direction) :rtl)))
    (is (eq :rtl (gtk:widget-direction label)))
    ;; Restore the default value of the text direction
    (is (eq default (setf (gtk:widget-default-direction) default)))
    (is (eq default (setf (gtk:widget-direction label) default)))))

;;;     gtk_widget_shape_combine_region
;;;     gtk_widget_input_shape_combine_region
;;;     gtk_widget_path
;;;     gtk_widget_class_pathr
;;;     gtk_widget_get_composite_name
;;;     gtk_widget_override_background_color
;;;     gtk_widget_override_color
;;;     gtk_widget_override_font
;;;     gtk_widget_override_symbolic_color
;;;     gtk_widget_override_cursor
;;;     gtk_widget_modify_style
;;;     gtk_widget_get_modifier_style
;;;     gtk_widget_modify_fg
;;;     gtk_widget_modify_bg
;;;     gtk_widget_modify_text
;;;     gtk_widget_modify_base
;;;     gtk_widget_modify_font
;;;     gtk_widget_modify_cursor
;;;     gtk_widget_create_pango_context

;;;     gtk_widget_get_pango_context

(test widget-pango-context
  (let* ((label (make-instance 'gtk:label :label "Text"))
         (context (gtk:widget-pango-context label)))

    (is (typep context 'pango:context))

    (is (typep (pango:context-font-map context) 'pango:font-map))
    (is (typep (pango:context-font-description context) 'pango:font-description))
    (is (typep (pango:context-language context) 'pango:language))
    (is (eq :ltr (pango:context-base-dir context)))
    (is (eq :south (pango:context-base-gravity context)))
    (is (eq :south (pango:context-gravity context)))

    (is (eq :natural (pango:context-gravity-hint context)))
    (is-false (pango:context-matrix context))
    (is-true (pango:context-round-glyph-positions context))
    (is (typep (pango:context-metrics context
                                      (pango:context-font-description context)
                                      (pango:context-language context))
               'pango:font-metrics))
;    (is-false (pango:context-list-families context))

))

;;;     gtk_widget_set_font_options
;;;     gtk_widget_get_font_options

#+nil
(test widget-font-options
  (let ((label (make-instance 'gtk:label))
        (options (gdk:screen-font-options (gdk:screen-default))))

    (is-false (gtk:widget-font-options label))
    (is (cairo-font-options-equal options
                                  (setf (gtk:widget-font-options label)
                                        options)))
    (is (cairo-font-options-equal options
                                  (gtk:widget-font-options label)))
    ;; Check the NIL value
;    (is-false (setf (gtk-widget-font-options label) nil))
;    (is-false (gtk-widget-font-options label))
    ))

;;;     gtk_widget_set_font_map
;;;     gtk_widget_get_font_map

;;;     gtk_widget_create_pango_layout
;;;     gtk_widget_render_icon
;;;     gtk_widget_render_icon_pixbuf
;;;     gtk_widget_pop_composite_child
;;;     gtk_widget_push_composite_child
;;;     gtk_widget_queue_draw_area
;;;     gtk_widget_queue_draw_region
;;;     gtk_widget_set_app_paintable
;;;     gtk_widget_set_double_buffered
;;;     gtk_widget_set_redraw_on_allocate
;;;     gtk_widget_set_composite_name
;;;     gtk_widget_mnemonic_activate

;;;     gtk_widget_class_install_style_property
;;;     gtk_widget_class_install_style_property_parser

;;;     gtk_widget_class_find_style_property

(test widget-class-find-style-property
  (is (string= "cursor-aspect-ratio"
               (g:param-spec-name
                 (gtk:widget-class-find-style-property "GtkFrame"
                                                       "cursor-aspect-ratio"))))
  (is (string= "cursor-color"
               (g:param-spec-name
                 (gtk:widget-class-find-style-property "GtkFrame"
                                                       "cursor-color"))))
  (is (string= "focus-line-pattern"
               (g:param-spec-name
                 (gtk:widget-class-find-style-property "GtkFrame"
                                                       "focus-line-pattern"))))
  (is-false (gtk:widget-class-find-style-property "GtkFrame" "xxx")))

;;;     gtk_widget_class_list_style_properties

(test widget-class-list-style-properties.1
  ;; Get the names of the style properties of GtkFrame.
  (is (equal '("cursor-aspect-ratio" "cursor-color" "focus-line-pattern"
               "focus-line-width" "focus-padding" "interior-focus" "link-color"
               "scroll-arrow-hlength" "scroll-arrow-vlength"
               "secondary-cursor-color" "separator-height" "separator-width"
               "text-handle-height" "text-handle-width" "visited-link-color"
               "wide-separators" "window-dragging")
             (mapcar #'g:param-spec-name
                     (gtk:widget-class-list-style-properties "GtkFrame")))))

(test widget-class-list-style-properties.2
  ;; Get the names of the style properties of GtkFrame.
  (is (equal '("cursor-aspect-ratio" "cursor-color" "focus-line-pattern"
               "focus-line-width" "focus-padding" "interior-focus" "link-color"
               "scroll-arrow-hlength" "scroll-arrow-vlength"
               "secondary-cursor-color" "separator-height" "separator-width"
               "text-handle-height" "text-handle-width" "visited-link-color"
               "wide-separators" "window-dragging")
             (mapcar #'g:param-spec-name
                     (gtk:widget-class-list-style-properties
                         (g:gtype "GtkFrame"))))))

;;;     gtk_widget_region_intersect
;;;     gtk_widget_send_expose
;;;     gtk_widget_send_focus_change
;;;     gtk_widget_style_get

;;;     gtk_widget_style_property

(test widget-style-property
  (let ((widget (make-instance 'gtk:frame)))
    (is (= 0.04 (gtk:widget-style-property widget "cursor-aspect-ratio")))
    (is-false (gtk:widget-style-property widget "cursor-color"))
    (is (= 16 (gtk:widget-style-property widget "scroll-arrow-hlength")))
    (is (= 16 (gtk:widget-style-property widget "scroll-arrow-vlength")))
    (is-false (gtk:widget-style-property widget "secondary-cursor-color"))
    (is (=  0 (gtk:widget-style-property widget "separator-height")))
    (is (=  0 (gtk:widget-style-property widget "separator-width")))
    (is (= 24 (gtk:widget-style-property widget "text-handle-height")))
    (is (= 20 (gtk:widget-style-property widget "text-handle-width")))
    (is-false  (gtk:widget-style-property widget "wide-separators"))
    (is-false (gtk:widget-style-property widget "window-dragging"))))

;;;     gtk_widget_style_get_valist
;;;     gtk_widget_style_attach
;;;     gtk_widget_class_set_accessible_type
;;;     gtk_widget_class_set_accessible_role
;;;     gtk_widget_get_accessible
;;;     gtk_widget_child_focus
;;;     gtk_widget_child_notify
;;;     gtk_widget_freeze_child_notify
;;;     gtk_widget_get_child_visible
;;;     gtk_widget_get_parent
;;;     gtk_widget_get_settings
;;;     gtk_widget_get_clipboard
;;;     gtk_widget_get_display
;;;     gtk_widget_get_root_window

;;;     gtk_widget_get_screen
;;;     gtk_widget_has_screen

(test widget-screen
  (let ((window (make-instance 'gtk:window :type :toplevel)))
    (is-true (gtk:widget-has-screen window))
    (is (typep (gtk:widget-screen window) 'gdk:screen))))

;;;     gtk_widget_size_request

(test widget-size-request
  (let ((button (make-instance 'gtk:button)))
    (is (equal '(-1 -1)
               (multiple-value-list (gtk:widget-size-request button))))
    (is (equal '(100 200)
               (multiple-value-list
                   (setf (gtk:widget-size-request button) '(100 200)))))
    (is (equal '(100 200)
               (multiple-value-list (gtk:widget-size-request button))))))

;;;     gtk_widget_set_child_visible
;;;     gtk_widget_thaw_child_notify
;;;     gtk_widget_set_no_show_all
;;;     gtk_widget_get_no_show_all

;;;     gtk_widget_list_mnemonic_labels
;;;     gtk_widget_add_mnemonic_label
;;;     gtk_widget_remove_mnemonic_label

(test widget-mnemonic-label
  (let ((button (gtk:button-new-with-mnemonic "_Hello")))
    ;; Check for the mnemonic label in the list of mnemonic labels
    (is (every (lambda (x) (typep x 'gtk:widget))
               (gtk:widget-list-mnemonic-labels button)))
    (let ((label (first (gtk:widget-list-mnemonic-labels button))))
      ;; Remove the mnemonic label
      (is-false (gtk:widget-remove-mnemonic-label button label))
      (is-false (gtk:widget-list-mnemonic-labels button))
      ;; Add again the mnemonic label
      (is-false (gtk:widget-add-mnemonic-label button label))
      (is (every (lambda (x) (typep x 'gtk:widget))
                 (gtk:widget-list-mnemonic-labels button))))))

;;;     gtk_widget_is_composited
;;;     gtk_widget_error_bell
;;;     gtk_widget_keynav_failed
;;;     gtk_widget_get_tooltip_markup
;;;     gtk_widget_set_tooltip_markup
;;;     gtk_widget_get_tooltip_text
;;;     gtk_widget_set_tooltip_text
;;;     gtk_widget_get_tooltip_window
;;;     gtk_widget_set_tooltip_window
;;;     gtk_widget_get_has_tooltip
;;;     gtk_widget_set_has_tooltip
;;;     gtk_widget_trigger_tooltip_query
;;;     gtk_widget_get_window
;;;     gtk_cairo_should_draw_window
;;;     gtk_cairo_transform_to_window

;;;     gtk_widget_get_allocated_width
;;;     gtk_widget_get_allocated_height
;;;     gtk_widget_get_allocation
;;;     gtk_widget_set_allocation

(test widget-allocation
  (let ((window (make-instance 'gtk:window :type :toplevel)))
    (is (typep (gtk:widget-allocation window) 'gdk:rectangle))
    (is (= 1 (gdk:rectangle-width (gtk:widget-allocation window))))
    (is (= 1 (gdk:rectangle-height (gtk:widget-allocation window))))
    (is (= 1 (gtk:widget-allocated-width window)))
    (is (= 1 (gtk:widget-allocated-height window)))
    (is (typep (setf (gtk:widget-allocation window)
                     (gdk:rectangle-new :width 100 :height 200))
               'gdk:rectangle))
    (is (= 100 (gdk:rectangle-width (gtk:widget-allocation window))))
    (is (= 200 (gdk:rectangle-height (gtk:widget-allocation window))))
    (is (= 100 (gtk:widget-allocated-width window)))
    (is (= 200 (gtk:widget-allocated-height window)))
    (is (= (gtk:widget-allocated-width window)
           (gdk:rectangle-width (gtk:widget-allocation window))))
    (is (= (gtk:widget-allocated-height window)
           (gdk:rectangle-height (gtk:widget-allocation window))))))

;;;     gtk_widget_get_app_paintable
;;;     gtk_widget_get_can_default
;;;     gtk_widget_set_can_default
;;;     gtk_widget_get_can_focus
;;;     gtk_widget_set_can_focus
;;;     gtk_widget_get_double_buffered
;;;     gtk_widget_get_has_window
;;;     gtk_widget_set_has_window
;;;     gtk_widget_get_sensitive
;;;     gtk_widget_is_sensitive
;;;     gtk_widget_get_state
;;;     gtk_widget_get_visible
;;;     gtk_widget_set_visible

;;;     gtk_widget_get_state_flags
;;;     gtk_widget_set_state_flags

(test widget-state-flags
  (let ((button (make-instance 'gtk:button)))
    (is (equal '(:dir-ltr) (gtk:widget-state-flags button)))
    (is (equal '(:ACTIVE :SELECTED)
               (setf (gtk:widget-state-flags button nil) '(:active :selected))))
    (is (equal '(:ACTIVE :SELECTED :DIR-LTR)
               (gtk:widget-state-flags button)))
    (is (equal '(:focused)
               (setf (gtk:widget-state-flags button t) '(:focused))))
    (is (equal '(:FOCUSED :DIR-LTR)
               (gtk:widget-state-flags button)))
    (is (equal '(:ACTIVE :SELECTED)
               (setf (gtk:widget-state-flags button) '(:active :selected))))
    (is (equal '(:ACTIVE :SELECTED :FOCUSED :DIR-LTR)
               (gtk:widget-state-flags button)))))

;;;     gtk_widget_unset_state_flags
;;;     gtk_widget_has_default
;;;     gtk_widget_has_focus
;;;     gtk_widget_has_visible_focus
;;;     gtk_widget_has_grab
;;;     gtk_widget_has_rc_style
;;;     gtk_widget_is_drawable
;;;     gtk_widget_is_toplevel
;;;     gtk_widget_set_window
;;;     gtk_widget_set_receives_default
;;;     gtk_widget_get_receives_default
;;;     gtk_widget_set_support_multidevice
;;;     gtk_widget_get_support_multidevice
;;;     gtk_widget_set_realized
;;;     gtk_widget_get_realized
;;;     gtk_widget_set_mapped
;;;     gtk_widget_get_mapped
;;;     gtk_widget_get_requisition
;;;     gtk_widget_device_is_shadowed
;;;     gtk_widget_get_modifier_mask
;;;
;;;     gtk_widget_get_path
;;;     gtk_widget_get_style_context
;;;     gtk_widget_reset_style
;;;
;;;     gtk_requisition_new
;;;     gtk_requisition_copy
;;;     gtk_requisition_free
;;;
;;;
;;;     gtk_widget_get_preferred_height
;;;     gtk_widget_get_preferred_width
;;;     gtk_widget_get_preferred_height_for_width
;;;     gtk_widget_get_preferred_width_for_height

;;; --- gtk_widget_get_request_mode --------------------------------------------

(test widget-request-mode.1
  (is (eql :constant-size
           (gtk:widget-request-mode (make-instance 'gtk:button)))))

(test widget-request-mode.2
  (is (eql :constant-size
           (gtk:widget-request-mode (make-instance 'gtk:button :label "Hello")))))

;;;     gtk_widget_preferred_size

(test widget-preferred-size.1
  (let ((button (make-instance 'gtk:button)))
    (is (listp (multiple-value-list (gtk:widget-preferred-size button))))
    (is (typep (first (multiple-value-list (gtk:widget-preferred-size button)))
                'gtk:requisition))
    (is (typep (second (multiple-value-list (gtk:widget-preferred-size button)))
                'gtk:requisition))))

(test widget-preferred-size.2
  (let ((button (make-instance 'gtk:button)))
    (multiple-value-bind (minimum-size natural-size)
        (gtk:widget-preferred-size button)
      (is (= 0 (gtk:requisition-width minimum-size)))
      (is (= 0 (gtk:requisition-height minimum-size)))
      (is (= 0 (gtk:requisition-width natural-size)))
      (is (= 0 (gtk:requisition-height natural-size))))))

;;;     gtk_distribute_natural_allocation
;;;
;;;     gtk_widget_get_halign
;;;     gtk_widget_set_halign
;;;     gtk_widget_get_valign
;;;     gtk_widget_set_valign
;;;     gtk_widget_get_margin_left
;;;     gtk_widget_set_margin_left
;;;     gtk_widget_get_margin_right
;;;     gtk_widget_set_margin_right
;;;     gtk_widget_get_margin_top
;;;     gtk_widget_set_margin_top
;;;     gtk_widget_get_margin_bottom
;;;     gtk_widget_set_margin_bottom
;;;
;;;     gtk_widget_get_hexpand
;;;     gtk_widget_set_hexpand
;;;     gtk_widget_get_hexpand_set
;;;     gtk_widget_set_hexpand_set
;;;     gtk_widget_get_vexpand
;;;     gtk_widget_set_vexpand
;;;     gtk_widget_get_vexpand_set
;;;     gtk_widget_set_vexpand_set
;;;     gtk_widget_queue_compute_expand
;;;     gtk_widget_compute_expand

;;; 2022-7-9
