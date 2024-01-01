(in-package :gtk-test)

(def-suite gtk-revealer :in gtk-suite)
(in-suite gtk-revealer)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkRevealerTransitionType

(test gtk-revealer-transition-type
  ;; Check the type
  (is (g:type-is-enum "GtkRevealerTransitionType"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkRevealerTransitionType")
          (g:gtype (cffi:foreign-funcall "gtk_revealer_transition_type_get_type"
                                         :size))))
  ;; Check the registered name
  (is (eq 'gtk:revealer-transition-type
          (glib:symbol-for-gtype "GtkRevealerTransitionType")))
  ;; Check the names
  (is (equal '("GTK_REVEALER_TRANSITION_TYPE_NONE"
               "GTK_REVEALER_TRANSITION_TYPE_CROSSFADE"
               "GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT"
               "GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT"
               "GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP"
               "GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN")
             (list-enum-item-name "GtkRevealerTransitionType")))
  ;; Check the values
  (is (equal '(0 1 2 3 4 5)
             (list-enum-item-value "GtkRevealerTransitionType")))
  ;; Check the nick names
  (is (equal '("none" "crossfade" "slide-right" "slide-left" "slide-up"
               "slide-down")
             (list-enum-item-nick "GtkRevealerTransitionType")))
  ;; Check the enum definition
  (is (equal '(GOBJECT:DEFINE-G-ENUM "GtkRevealerTransitionType"
                                     GTK-REVEALER-TRANSITION-TYPE
                                     (:EXPORT T
                                      :TYPE-INITIALIZER
                                      "gtk_revealer_transition_type_get_type")
                                     (:NONE 0)
                                     (:CROSSFADE 1)
                                     (:SLIDE-RIGHT 2)
                                     (:SLIDE-LEFT 3)
                                     (:SLIDE-UP 4)
                                     (:SLIDE-DOWN 5))
             (gobject:get-g-type-definition "GtkRevealerTransitionType"))))

;;;     GtkRevealer

(test gtk-revealer-class
  ;; Type check
  (is (g:type-is-object "GtkRevealer"))
  ;; Check the registered name
  (is (eq 'gtk:revealer
          (glib:symbol-for-gtype "GtkRevealer")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkRevealer")
          (g:gtype (cffi:foreign-funcall "gtk_revealer_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkBin")
          (g:type-parent "GtkRevealer")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkRevealer")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable")
             (list-interfaces "GtkRevealer")))
  ;; Check the class properties
  (is (equal '("child-revealed" "reveal-child" "transition-duration"
               "transition-type")
             (list-properties "GtkRevealer")))
  ;; Get the names of the style properties
  (is (equal '()
             (list-style-properties "GtkRevealer")))
  ;; Get the names of the child properties
  (is (equal '()
             (list-child-properties "GtkRevealer")))
  ;; Check the signals
  (is (equal '()
             (list-signals "GtkRevealer")))
  ;; CSS information
  (is (string= "revealer"
               (gtk:widget-class-css-name "GtkRevealer")))
  ;; Check the class definition
  (is (equal '(GOBJECT:DEFINE-G-OBJECT-CLASS "GtkRevealer" GTK-REVEALER
                       (:SUPERCLASS GTK-BIN :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable")
                        :TYPE-INITIALIZER "gtk_revealer_get_type")
                       ((CHILD-REVEALED GTK-REVEALER-CHILD-REVEALED
                         "child-revealed" "gboolean" T NIL)
                        (REVEAL-CHILD GTK-REVEALER-REVEAL-CHILD "reveal-child"
                         "gboolean" T T)
                        (TRANSITION-DURATION GTK-REVEALER-TRANSITION-DURATION
                         "transition-duration" "guint" T T)
                        (TRANSITION-TYPE GTK-REVEALER-TRANSITION-TYPE
                         "transition-type" "GtkRevealerTransitionType" T T)))
             (gobject:get-g-type-definition "GtkRevealer"))))

;;; --- Properties -------------------------------------------------------------

;;;     child-revealed
;;;     reveal-child
;;;     transition-duration
;;;     transition-type

(test gtk-revealer-properties
  (let ((revealer (make-instance 'gtk:revealer)))
    (is-false (gtk:revealer-child-revealed revealer))
    (is-false (gtk:revealer-reveal-child revealer))
    (is (= 250 (gtk:revealer-transition-duration revealer)))
    (is (eq :slide-down (gtk:revealer-transition-type revealer)))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_revealer_new

(test gtk-revealer-new
  (is (typep (gtk:revealer-new) 'gtk:revealer)))

;;; 2024-1-1
