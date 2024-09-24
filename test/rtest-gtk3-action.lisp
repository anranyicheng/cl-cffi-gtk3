(in-package :gtk-test)

(def-suite gtk-action :in gtk-suite)
(in-suite gtk-action)

(defvar *verbose-gtk-action* nil)

;;;   GtkAction

(test gtk-action-class
  ;; Check type
  (is (g:type-is-object "GtkAction"))
  ;; Check registered name
  (is (eq 'gtk:action
          (glib:symbol-for-gtype "GtkAction")))
  ;; Check parent
  (is (eq (g:gtype "GObject") (g:type-parent "GtkAction")))
  ;; Check children
  (is (equal '("GtkRecentAction" "GtkToggleAction")
             (glib-test:list-children "GtkAction")))
  ;; Check interfaces
  (is (equal '("GtkBuildable")
             (glib-test:list-interfaces "GtkAction")))
  ;; Check class properties
  (is (equal '("action-group" "always-show-image" "gicon" "hide-if-empty"
               "icon-name" "is-important" "label" "name" "sensitive"
               "short-label" "stock-id" "tooltip" "visible" "visible-horizontal"
               "visible-overflown" "visible-vertical")
             (glib-test:list-properties "GtkAction")))
  ;; Check signals
  (is (equal '("activate")
             (glib-test:list-signals "GtkAction")))
  ;; Check the class definition
  (is (equal '(GOBJECT:DEFINE-GOBJECT "GtkAction" GTK:ACTION
                       (:SUPERCLASS G:OBJECT
                        :EXPORT T
                        :INTERFACES ("GtkBuildable")
                        :TYPE-INITIALIZER "gtk_action_get_type")
                       ((ACTION-GROUP ACTION-ACTION-GROUP
                         "action-group" "GtkActionGroup" T T)
                        (ALWAYS-SHOW-IMAGE ACTION-ALWAYS-SHOW-IMAGE
                         "always-show-image" "gboolean" T T)
                        (GICON ACTION-GICON "gicon" "GIcon" T T)
                        (HIDE-IF-EMPTY ACTION-HIDE-IF-EMPTY
                         "hide-if-empty" "gboolean" T T)
                        (ICON-NAME ACTION-ICON-NAME "icon-name" "gchararray" T T)
                        (IS-IMPORTANT ACTION-IS-IMPORTANT
                         "is-important" "gboolean" T T)
                        (LABEL ACTION-LABEL "label" "gchararray" T T)
                        (NAME ACTION-NAME "name" "gchararray" T NIL)
                        (SENSITIVE ACTION-SENSITIVE "sensitive" "gboolean" T T)
                        (SHORT-LABEL ACTION-SHORT-LABEL
                         "short-label" "gchararray" T T)
                        (STOCK-ID ACTION-STOCK-ID "stock-id" "gchararray" T T)
                        (TOOLTIP ACTION-TOOLTIP "tooltip" "gchararray" T T)
                        (VISIBLE ACTION-VISIBLE "visible" "gboolean" T T)
                        (VISIBLE-HORIZONTAL ACTION-VISIBLE-HORIZONTAL
                         "visible-horizontal" "gboolean" T T)
                        (VISIBLE-OVERFLOWN  ACTION-VISIBLE-OVERFLOWN
                         "visible-overflown" "gboolean" T T)
                        (VISIBLE-VERTICAL ACTION-VISIBLE-VERTICAL
                         "visible-vertical" "gboolean" T T)))
             (gobject:get-gtype-definition "GtkAction"))))

;;;   gtk_action_new

(test gtk-action-new.1
  (let ((action (gtk:action-new "action")))
    (is (string= "action" (gtk:action-name action)))
    (is-false (gtk:action-label action))
    (is-false (gtk:action-tooltip action))
    (is-false (gtk:action-stock-id action))))

(test gtk-action-new.2
  (let ((action (gtk:action-new "action" "label" "tooltip" "stock-id")))
    (is (string= "action" (gtk:action-name action)))
    (is (string= "label" (gtk:action-label action)))
    (is (string= "tooltip" (gtk:action-tooltip action)))
    (is (string= "stock-id" (gtk:action-stock-id action)))))

;;;   gtk-action-name

(test gtk-action-name
  (let ((action (gtk:action-new "action")))
    (is (string= "action" (gtk:action-name action)))))

;;;   gtk-action-is-sensitive
;;;   gtk-action-sensitive

(test gtk-action-sensitive
  (let ((action (gtk:action-new "action")))
    (is-true (gtk:action-sensitive action))
    (is-true (gtk:action-is-sensitive action))
    (setf (gtk:action-sensitive action) nil)
    (is-false (gtk:action-sensitive action))
    (is-false (gtk:action-is-sensitive action))))

;;;   gtk-action-is-visible
;;;   gtk-action-visible

(test gtk-action-visible
  (let ((action (gtk:action-new "action")))
    (is-true (gtk:action-visible action))
    (is-true (gtk:action-is-visible action))
    (setf (gtk:action-visible action) nil)
    (is-false (gtk:action-visible action))
    (is-false (gtk:action-is-visible action))))

;;;   gtk-action-activate

#+nil
(test gtk-action-activate
  (let ((message nil))
    (within-main-loop
      (let ((action (gtk:action-new "action")))
        (g-signal-connect action "activate"
           (lambda (action)
             (setf message "ACTIVATE CALLED")
             (when *verbose-gtk-action*
               (format t "~&Signal ACTIVATE for ~A~%" (gtk:action-name action)))
             (leave-gtk-main)))
        (gtk:action-activate action)))
    (join-gtk-main)
    (is (equal "ACTIVATE CALLED" message))))

;;;   gtk-action-create-icon

(test gtk-action-create-icon
  (let ((action (gtk:action-new "action")))
    ;; Check for a stock-id, also check for icon-name and gicon
    (setf (gtk:action-stock-id action) "gtk-ok")
    (is (typep (gtk:action-create-icon action :dialog) 'gtk:image))))

;;;   gtk-action-create-menu-item

(test gtk-action-create-menu-item
  (let ((action (gtk:action-new "action")))
    (is (typep (gtk:action-create-menu-item action) 'gtk:image-menu-item))))

;;;   gtk-action-create-tool-item

(test gtk-action-create-tool-item
  (let ((action (gtk:action-new "action")))
    (is (typep (gtk:action-create-tool-item action) 'gtk:tool-button))))

;;;   gtk-action-create-menu

(test gtk-action-create-menu
  (let ((action (gtk:action-new "action")))
    ;; Create an test for an result not nil
    (is-false (gtk:action-create-menu action))))

;;;   gtk_action_get_proxies

(test gtk-action-proxies
  (let ((action (gtk:action-new "action")))
    (is-false (gtk:action-proxies action))
    ;; Add a tool item to list of proxies
    (gtk:action-create-tool-item action)
    (is (typep (first (gtk:action-proxies action)) 'gtk:tool-button))
    ;; Add a menu item to list of proxies
    (gtk:action-create-menu-item action)
    (is (typep (first (gtk:action-proxies action)) 'gtk:image-menu-item))))

;;;   gtk-action-connect-accelerator

(test gtk-action-connect-accelerator
  (let ((accel-group (gtk:accel-group-new))
        (action (gtk:action-new "action")))
    (setf (gtk:action-accel-path action) "<test>/File/Exit")
    (gtk:action-set-accel-group action accel-group)
    (gtk:action-connect-accelerator action)))

;;;    gtk_action_disconnect_accelerator
;;;    gtk_action_block_activate
;;;    gtk_action_unblock_activate
;;;    gtk_action_get_always_show_image
;;;    gtk_action_set_always_show_image
;;;    gtk_action_get_accel_path
;;;    gtk_action_set_accel_path
;;;    gtk_action_get_accel_closure
;;;    gtk_action_set_accel_group
;;;    gtk_action_set_label
;;;    gtk_action_get_label
;;;    gtk_action_set_short_label
;;;    gtk_action_get_short_label
;;;    gtk_action_set_tooltip
;;;    gtk_action_get_tooltip
;;;    gtk_action_set_stock_id
;;;    gtk_action_get_stock_id
;;;    gtk_action_set_gicon
;;;    gtk_action_get_gicon
;;;    gtk_action_set_icon_name
;;;    gtk_action_get_icon_name
;;;    gtk_action_set_visible_horizontal
;;;    gtk_action_get_visible_horizontal
;;;    gtk_action_set_visible_vertical
;;;    gtk_action_get_visible_vertical
;;;    gtk_action_set_is_important
;;;    gtk_action_get_is_important

;;; 2024-9-23
