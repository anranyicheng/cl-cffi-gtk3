(in-package :gtk-test)

(def-suite gtk-box :in gtk-suite)
(in-suite gtk-box)

;; GtkPrinterOptionWidget is a child of GtkBox
#-win32
(eval-when (:compile-toplevel :load-toplevel :execute)
  (cffi:foreign-funcall "gtk_printer_option_widget_get_type" :size))

;;; --- Types and Values -------------------------------------------------------

(test box-class
  ;; Type check
  (is (g:type-is-object "GtkBox"))
  ;; Check the registered name
  (is (eq 'gtk:box
          (gobject:symbol-for-gtype "GtkBox")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkBox")
          (g:gtype (cffi:foreign-funcall "gtk_box_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkContainer") (g:type-parent "GtkBox")))
  ;; Check the children
  #-windows
  (is (or (equal '("GtkAppChooserWidget" "GtkButtonBox" "GtkColorChooserWidget"
                   "GtkColorSelection" "GtkFileChooserButton"
                   "GtkFileChooserWidget" "GtkFontChooserWidget"
                   "GtkFontSelection" "GtkHBox" "GtkInfoBar"
                   "GtkPrinterOptionWidget" "GtkRecentChooserWidget"
                   "GtkShortcutsGroup" "GtkShortcutsSection"
                   "GtkShortcutsShortcut" "GtkStackSwitcher" "GtkStatusbar"
                   "GtkVBox")
                 (list-children "GtkBox"))
          (equal '("GtkAppChooserWidget" "GtkButtonBox" "GtkColorChooserWidget"
                   "GtkColorSelection" "GtkFileChooserButton"
                   "GtkFileChooserWidget" "GtkFontChooserWidget"
                   "GtkFontSelection" "GtkHBox" "GtkInfoBar" "GtkPlacesView"
                   "GtkPrinterOptionWidget" "GtkRecentChooserWidget"
                   "GtkShortcutsGroup" "GtkShortcutsSection"
                   "GtkShortcutsShortcut" "GtkStackSwitcher" "GtkStatusbar"
                   "GtkVBox")
                 (list-children "GtkBox"))))
  #+windows
  (is (equal '("GtkHBox" "GtkVBox" "GtkStackSwitcher" "GtkButtonBox"
               "GtkStatusbar" "GtkInfoBar" "GtkColorChooserWidget"
               "GtkColorSelection" "GtkFileChooserWidget"
               "GtkFileChooserButton" "GtkFontChooserWidget"
               "GtkFontSelection" "GtkRecentChooserWidget"
               "GtkAppChooserWidget" "GtkShortcutsSection"
               "GtkShortcutsGroup" "GtkShortcutsShortcut")
             (list-children "GtkBox")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable" "GtkOrientable")
             (list-interfaces "GtkBox")))
  ;; Check the class properties
  (is (equal '("baseline-position" "homogeneous" "orientation" "spacing")
             (list-properties "GtkBox")))
  ;; Get the names of the style properties.
  (is (equal '()
             (list-style-properties "GtkBox")))
  ;; Get the names of the child properties
  (is (equal '("expand" "fill" "pack-type" "padding" "position")
             (list-child-properties "GtkBox")))
  (is (equal '()
             (list-signals "GtkBox")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkBox" GTK-BOX
                       (:SUPERCLASS GTK-CONTAINER :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable" "GtkOrientable")
                        :TYPE-INITIALIZER "gtk_box_get_type")
                       ((BASELINE-POSITION GTK-BOX-BASELINE-POSITION
                         "baseline-position" "GtkBaselinePosition" T T)
                        (HOMOGENEOUS GTK-BOX-HOMOGENEOUS "homogeneous"
                         "gboolean" T T)
                        (SPACING GTK-BOX-SPACING "spacing" "gint" T T)))
             (gobject:get-g-type-definition "GtkBox"))))

;;; --- Properties -------------------------------------------------------------

(test box-properties
  (let ((box (make-instance 'gtk:box :orientation :vertical :spacing 12)))
    (is (eq :vertical (gtk:orientable-orientation box)))
    (is (eq :center (gtk:box-baseline-position box)))
    (is-false (gtk:box-homogeneous box))
    (is (= 12 (gtk:box-spacing box)))))

;;; --- Child Properties -------------------------------------------------------

(test box-child-properties
  (let* ((box (make-instance 'gtk:box :orientation :vertical))
         (button (make-instance 'gtk:button)))
    (is-false (gtk:container-add box button))
    (is-false (gtk:box-child-expand box button))
    (is-true (gtk:box-child-fill box button))
    (is (eq :start (gtk:box-child-pack-type box button)))
    (is (= 0 (gtk:box-child-padding box button)))
    (is (= 0 (gtk:box-child-position box button)))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_box_new

(test box-new
  ;; Create a box
  (let ((box (gtk:box-new :vertical 12)))
    (is (eq :vertical (gtk:orientable-orientation box)))
    (is (eq :center (gtk:box-baseline-position box)))
    (is-false (gtk:box-homogeneous box))
    (is (= 12 (gtk:box-spacing box))))
  ;; Create a box with the default value for spacing
  (let ((box (gtk:box-new :horizontal)))
    (is (eq :horizontal (gtk:orientable-orientation box)))
    (is (eq :center (gtk:box-baseline-position box)))
    (is-false (gtk:box-homogeneous box))
    (is (= 0 (gtk:box-spacing box))))
  ;; Use make-instance with default values
  (let ((box (make-instance 'gtk:box)))
    (is (eq :horizontal (gtk:orientable-orientation box)))
    (is (eq :center (gtk:box-baseline-position box)))
    (is-false (gtk:box-homogeneous box))
    (is (= 0 (gtk:box-spacing box))))
  ;; Use make-instance and set some properties
  (let ((box (make-instance 'gtk:box
                            :orientation :vertical
                            :baseline-position :top
                            :homogeneous t
                            :spacing 12)))
    (is (eq :vertical (gtk:orientable-orientation box)))
    (is (eq :top (gtk:box-baseline-position box)))
    (is-true (gtk:box-homogeneous box))
    (is (= 12 (gtk:box-spacing box)))))

;;;     gtk_box_pack_start

(test box-pack-start
  (let ((box (make-instance 'gtk:box :orientation :vertical))
        (button1 (make-instance 'gtk:button))
        (button2 (make-instance 'gtk:button))
        (button3 (make-instance 'gtk:button)))
    ;; Pack first button
    (is-false (gtk:box-pack-start box button1))
    (is (= 0 (gtk:box-child-position box button1)))
    ;; Pack second button
    (is-false (gtk:box-pack-start box button2))
    (is (= 0 (gtk:box-child-position box button1)))
    (is (= 1 (gtk:box-child-position box button2)))
    ;; Pack third button
    (is-false (gtk:box-pack-start box button3))
    (is (= 0 (gtk:box-child-position box button1)))
    (is (= 1 (gtk:box-child-position box button2)))
    (is (= 2 (gtk:box-child-position box button3)))
    ;; Check the pack type
    (is (eq :start (gtk:box-child-pack-type box button1)))
    (is (eq :start (gtk:box-child-pack-type box button2)))
    (is (eq :start (gtk:box-child-pack-type box button3)))))

;;;     gtk_box_pack_end

(test box-pack-end
  (let ((box (make-instance 'gtk:box :orientation :vertical))
        (button1 (make-instance 'gtk:button))
        (button2 (make-instance 'gtk:button))
        (button3 (make-instance 'gtk:button)))
    ;; Pack first button
    (is-false (gtk:box-pack-end box button1))
    (is (= 0 (gtk:box-child-position box button1)))
    ;; Pack second button
    (is-false (gtk:box-pack-end box button2))
    (is (= 0 (gtk:box-child-position box button1)))
    (is (= 1 (gtk:box-child-position box button2)))
    ;; Pack third button
    (is-false (gtk:box-pack-end box button3))
    (is (= 0 (gtk:box-child-position box button1)))
    (is (= 1 (gtk:box-child-position box button2)))
    (is (= 2 (gtk:box-child-position box button3)))
    ;; Check the pack type
    (is (eq :end (gtk:box-child-pack-type box button1)))
    (is (eq :end (gtk:box-child-pack-type box button2)))
    (is (eq :end (gtk:box-child-pack-type box button3)))))

;;;     gtk_box_reorder_child

(test box-reorder-child
  (let ((box (make-instance 'gtk:box :orientation :vertical))
        (label (make-instance 'gtk:label))
        (button (make-instance 'gtk:button))
        (image (make-instance 'gtk:image)))
    ;; Pack three widgets in the box
    (is-false (gtk:box-pack-start box label))
    (is-false (gtk:box-pack-start box button))
    (is-false (gtk:box-pack-start box image))
    ;; Check the position of the children
    (is (= 0 (gtk:box-child-position box label)))
    (is (= 1 (gtk:box-child-position box button)))
    (is (= 2 (gtk:box-child-position box image)))
    ;; Reorder the children
    (gtk:box-reorder-child box label 1)
    ;; Check again the position of the children
    (is (= 1 (gtk:box-child-position box label)))
    (is (= 0 (gtk:box-child-position box button)))
    (is (= 2 (gtk:box-child-position box image)))
    ;; Reorder the children
    (gtk:box-reorder-child box label 2)
    ;; Check again the position of the children
    (is (= 2 (gtk:box-child-position box label)))
    (is (= 0 (gtk:box-child-position box button)))
    (is (= 1 (gtk:box-child-position box image)))))

;;;     gtk_box_query_child_packing
;;;     gtk_box_child_packing

(test box-child-packing
  (let ((box (make-instance 'gtk:box))
        (button (make-instance 'gtk:button)))
    ;; Pack a button in the box
    (is-false (gtk:container-add box button))
    ;; Query and check the child properties
    (multiple-value-bind (expand fill padding pack-type)
        (gtk:box-query-child-packing box button)
      (is-false expand)
      (is-true fill)
      (is (= 0 padding))
      (is (eq :start pack-type)))
    ;; Set new child properties
    (is (eq :end (gtk:box-child-packing box button t nil 10 :end)))
    ;; Query and check the child properties
    (multiple-value-bind (expand fill padding pack-type)
        (gtk:box-query-child-packing box button)
      (is-true expand)
      (is-false fill)
      (is (= 10 padding))
      (is (eq :end pack-type)))))

;;;     gtk_box_center_widget

(test box-center-widget
  (let ((box (make-instance 'gtk:box :orientation :vertical)))
    ;; Not center widget set
    (is-false (gtk:box-center-widget box))
    ;; Set a center widget
    (is (eq 'gtk:button
            (type-of (setf (gtk:box-center-widget box)
                           (make-instance 'gtk:button)))))
    ;; Retrieve the center widget
    (is (eq 'gtk:button (type-of (gtk:box-center-widget box))))))

;;; --- 2023-2-18 --------------------------------------------------------------
