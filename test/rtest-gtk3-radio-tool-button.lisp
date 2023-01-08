(in-package :gtk-test)

(def-suite gtk-radio-tool-button :in gtk-suite)
(in-suite gtk-radio-tool-button)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkRadioToolButton

(test radio-tool-button-class
  ;; Type check
  (is (g:type-is-object "GtkRadioToolButton"))
  ;; Check the registered name
  (is (eq 'gtk:radio-tool-button
          (gobject:symbol-for-gtype "GtkRadioToolButton")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkRadioToolButton")
          (g:gtype (cffi:foreign-funcall "gtk_radio_tool_button_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkToggleToolButton") (g:type-parent "GtkRadioToolButton")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkRadioToolButton")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable" "GtkActivatable"
               "GtkActionable")
             (list-interfaces "GtkRadioToolButton")))

  ;; Check the class properties
  (is (equal '("group")
             (list-properties "GtkRadioToolButton")))
  ;; Check the style properties
  (is (equal '()
             (list-style-properties "GtkRadioToolButton")))
  ;; Get the names of the child properties
  (is (equal '()
             (list-child-properties "GtkRadioToolButton")))
  ;; Check the signals
  (is (equal '()
             (list-signals "GtkRadioToolButton")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkRadioToolButton" GTK-RADIO-TOOL-BUTTON
                       (:SUPERCLASS GTK-TOGGLE-TOOL-BUTTON :EXPORT T
                        :INTERFACES
                        ("AtkImplementorIface" "GtkActionable" "GtkActivatable"
                         "GtkBuildable")
                        :TYPE-INITIALIZER "gtk_radio_tool_button_get_type")
                       ((GROUP GTK-RADIO-TOOL-BUTTON-GROUP "group"
                         "GtkRadioToolButton" NIL T)))
             (gobject:get-g-type-definition "GtkRadioToolButton"))))

;;; --- Properties -------------------------------------------------------------

;;;     GtkRadioToolButton*   group    Write

(test radio-tool-button-properties
  (let ((button (make-instance 'gtk:radio-tool-button)))
    ;; group is not readable
    (signals (error) (gtk:radio-tool-button-group button))
    ;; group is writable
    (is-false (setf (gtk:radio-tool-button-group button) nil))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_radio_tool_button_new

(test radio-tool-button-new
  (let (button)
  ;; First radio button
  (is (typep (setf button (gtk:radio-tool-button-new nil))
             'gtk:radio-tool-button))
  ;; Second radio button
  (is (typep (setf button
                   (gtk:radio-tool-button-new
                       (gtk:radio-tool-button-get-group button)))
             'gtk:radio-tool-button))
  ;; Check group list
  (is (= 2 (length (gtk:radio-tool-button-get-group button))))
  (is (typep (first (gtk:radio-tool-button-get-group button))
             'gtk:radio-button))
  ;; No bin child
  (is (typep (gtk:bin-child button) 'gtk:radio-button))))

;;;     gtk_radio_tool_button_new_from_stock

;;;     gtk_radio_tool_button_new_from_widget

(test radio-tool-button-new-from-widget
  (let (button)
  ;; First radio button
  (is (typep (setf button (gtk:radio-tool-button-new-from-widget nil))
             'gtk:radio-tool-button))
  ;; Second radio button
  (is (typep (setf button (gtk:radio-tool-button-new-from-widget button))
             'gtk:radio-tool-button))
  ;; Check group list
  (is (= 2 (length (gtk:radio-tool-button-get-group button))))
  (is (typep (first (gtk:radio-tool-button-get-group button))
             'gtk:radio-button))
  ;; No bin child
  (is (typep (gtk:bin-child button) 'gtk:radio-button))))

;;;     gtk_radio_tool_button_new_with_stock_from_widget

;;;     gtk_radio_tool_button_get_group
;;;     gtk_radio_tool_button_set_group

(test radio-tool-button-group
  (let (button)
    ;; First radio button
    (is (typep (setf button (gtk:radio-tool-button-new nil))
               'gtk:radio-tool-button))
    (is (listp (gtk:radio-tool-button-get-group button)))
    (is (= 1 (length (gtk:radio-tool-button-get-group button))))
    (is (typep (first (gtk:radio-tool-button-get-group button))
               'gtk:radio-button))
    ;; Second radio button
    (is (typep (setf button
                     (gtk:radio-tool-button-new
                         (gtk:radio-tool-button-get-group button)))
               'gtk:radio-tool-button))
    (is (listp (gtk:radio-tool-button-get-group button)))
    (is (= 2 (length (gtk:radio-tool-button-get-group button))))
    (is (typep (first (gtk:radio-tool-button-get-group button))
               'gtk:radio-button))
    ;; Third radio button
    (is (typep (setf button
                     (gtk:radio-tool-button-new
                         (gtk:radio-tool-button-get-group button)))
               'gtk:radio-tool-button))
    (is (listp (gtk:radio-tool-button-get-group button)))
    (is (= 3 (length (gtk:radio-tool-button-get-group button))))
    (is (typep (first (gtk:radio-tool-button-get-group button))
               'gtk:radio-button))))

;;; --- 2022-12-27 -------------------------------------------------------------
