(in-package :gtk-test)

(def-suite gtk-scrollable :in gtk-suite)
(in-suite gtk-scrollable)

;;;     GtkScrollablePolicy

(test scrollable-policy
  ;; Check the type
  (is-true (g:type-is-enum "GtkScrollablePolicy"))
  ;; Check the registered name
  (is (eq 'gtk:scrollable-policy
          (gobject::symbol-for-gtype "GtkScrollablePolicy")))
  ;; Check the names
  (is (equal '("GTK_SCROLL_MINIMUM" "GTK_SCROLL_NATURAL")
             (mapcar #'gobject:enum-item-name
                     (gobject:get-enum-items "GtkScrollablePolicy"))))
  ;; Check the values
  (is (equal '(0 1)
             (mapcar #'gobject:enum-item-value
                     (gobject:get-enum-items "GtkScrollablePolicy"))))
  ;; Check the nick names
  (is (equal '("minimum" "natural")
             (mapcar #'gobject:enum-item-nick
                     (gobject:get-enum-items "GtkScrollablePolicy"))))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkScrollablePolicy"
                              GTK-SCROLLABLE-POLICY
                  (:EXPORT T :TYPE-INITIALIZER "gtk_scrollable_policy_get_type")
                  (:MINIMUM 0)
                  (:NATURAL 1))
             (gobject:get-g-type-definition "GtkScrollablePolicy"))))

;;;     GtkScrollable

(test scrollable-interface
  ;; Type check
  (is-true (g:type-is-interface "GtkScrollable"))
  ;; Check the registered name
  (is (eq 'gtk:scrollable
          (gobject:symbol-for-gtype "GtkScrollable")))
  ;; Get the names of the interface properties.
  (is (equal '("hadjustment" "hscroll-policy" "vadjustment" "vscroll-policy")
             (list-interface-properties "GtkScrollable")))
  ;; Get the interface definition
  (is (equal '(DEFINE-G-INTERFACE "GtkScrollable"
                                  GTK-SCROLLABLE
      (:EXPORT T :TYPE-INITIALIZER "gtk_scrollable_get_type")
      (HADJUSTMENT GTK-SCROLLABLE-HADJUSTMENT "hadjustment" "GtkAdjustment" T T)
      (HSCROLL-POLICY GTK-SCROLLABLE-HSCROLL-POLICY "hscroll-policy"
                                                    "GtkScrollablePolicy" T T)
      (VADJUSTMENT GTK-SCROLLABLE-VADJUSTMENT "vadjustment" "GtkAdjustment" T T)
      (VSCROLL-POLICY GTK-SCROLLABLE-VSCROLL-POLICY "vscroll-policy"
                                                    "GtkScrollablePolicy" T T))
             (gobject:get-g-type-definition "GtkScrollable"))))

;;; --- gtk_scrollable_properties ----------------------------------------------

(test scrollable-properties
  (let ((scrollable (make-instance 'gtk:layout)))
    (is (eq 'gtk:adjustment (type-of (gtk:scrollable-hadjustment scrollable))))
    (is (eq 'gtk:adjustment (type-of (gtk:scrollable-vadjustment scrollable))))
    (is (eq :minimum (gtk:scrollable-hscroll-policy scrollable)))
    (is (eq :minimum (gtk:scrollable-vscroll-policy scrollable)))))

;;; --- gtk_scrollable-border --------------------------------------------------

(test scrollable-border
  (let ((scrollable (make-instance 'gtk:layout)))
    (is (eq 'gtk:border (type-of (gtk:scrollable-border scrollable))))))

;;; 2022-12-18
