(in-package :gtk-test)

(def-suite gdk-app-launch-context :in gdk-suite)
(in-suite gdk-app-launch-context)

;;; --- Types and Values -------------------------------------------------------

;;;     GdkAppLaunchContext

(test gdk-app-launch-context-class
  ;; Type check
  (is (g:type-is-object "GdkAppLaunchContext"))
  ;; Check the registered name
  (is (eq 'gdk:app-launch-context
          (glib:symbol-for-gtype "GdkAppLaunchContext")))
  ;; Check the type initializer
  (is (eq (g:gtype "GdkAppLaunchContext")
          (g:gtype (cffi:foreign-funcall "gdk_app_launch_context_get_type"
                                         :size))))
  ;; Check the parent
  (is (eq (g:gtype "GAppLaunchContext")
          (g:type-parent "GdkAppLaunchContext")))
  ;; Check the children
  #-windows
  (is (or (member "GdkX11AppLaunchContext"
                  (list-children "GdkAppLaunchContext") :test #'string=)
          (member "GdkWaylandAppLaunchContext"
                  (list-children "GdkAppLaunchContext") :test #'string=)))
  #+windows
  (is (equal '()
             (list-children "GdkAppLaunchContext")))
  ;; Check the interfaces
  (is (equal '()
             (list-interfaces "GdkAppLaunchContext")))
  ;; Check the class properties
  (is (equal '("display")
             (list-properties "GdkAppLaunchContext")))
  ;; Check the signals
  (is (equal '()
             (list-signals "GdkAppLaunchContext")))
  ;; Check the class definition
  (is (equal '(GOBJECT:DEFINE-G-OBJECT-CLASS "GdkAppLaunchContext" 
                                             GDK-APP-LAUNCH-CONTEXT
                       (:SUPERCLASS G-APP-LAUNCH-CONTEXT :EXPORT T :INTERFACES
                        NIL :TYPE-INITIALIZER
                        "gdk_app_launch_context_get_type")
                       ((DISPLAY GDK-APP-LAUNCH-CONTEXT-DISPLAY "display"
                         "GdkDisplay" T NIL)))
             (gobject:get-g-type-definition "GdkAppLaunchContext"))))

;;; --- Properties -------------------------------------------------------------

;;;     display

(test gdk-app-launch-context-properties
  (let* ((display (gdk:display-default))
         (context (gdk:display-app-launch-context display)))
    (is (typep (gdk:app-launch-context-display context) 'gdk:display))
    (is (eq display
            (gdk:app-launch-context-display context)))
    ;; Fails to signal an error, should not be writable, but generates a
    ;; GLib-GObject-warning
;    (is (eq display (setf (gdk:app-launch-context-display context) display)))
    ))

;;; --- Functions --------------------------------------------------------------

;;;     gdk_app_launch_context_new                         deprecated

(test gdk-app-launch-context-new
  (is (typep (gdk:app-launch-context-new) 'gdk:app-launch-context)))

;;;     gdk_app_launch_context_set_screen

(test gdk-app-launch-context-set-screen
  (let* ((display (gdk:display-default))
         (screen (gdk:display-default-screen display))
         (context (gdk:display-app-launch-context display)))
    (is (typep display 'gdk:display))
    (is (typep screen 'gdk:screen))
    (is (typep context 'gdk:app-launch-context))
    (is-false (gdk:app-launch-context-set-screen context screen))))

;;;     gdk_app_launch_context_set_desktop

(test gdk-app-launch-context-set-desktop
  (let ((context (gdk:display-app-launch-context (gdk:display-default))))
    (is-false (gdk:app-launch-context-set-desktop context -1))))

;;;     gdk_app_launch_context_set_timestamp

(test gdk-app-launch-context-set-timestamp
  (let ((context (gdk:display-app-launch-context (gdk:display-default))))
    (is-false (gdk:app-launch-context-set-timestamp context
                                                    gdk:+gdk-current-time+))))

;;;     gdk_app_launch_context_set_icon

(test gdk-app-launch-context-set-icon
  (let ((context (gdk:display-app-launch-context (gdk:display-default)))
        (icon (g:themed-icon-new "list-add")))
    (is (typep context 'gdk:app-launch-context))
    (is (typep icon 'g:icon))
    (is-false (gdk:app-launch-context-set-icon context icon))))

;;;     gdk_app_launch_context_set_icon_name

(test gdk-app-launch-context-set-icon-name
  (let ((context (gdk:display-app-launch-context (gdk:display-default))))
    (is (typep context 'gdk:app-launch-context))
    (is-false (gdk:app-launch-context-set-icon-name context "list-add"))
    (is-false (gdk:app-launch-context-set-icon-name context
                                                    (cffi:null-pointer)))))

;;; --- 2023-5-29 --------------------------------------------------------------
