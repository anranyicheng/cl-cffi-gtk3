(in-package :gtk-test)

(def-suite gtk-message-dialog :in gtk-suite)
(in-suite gtk-message-dialog)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkMessageType
;;;     GtkButtonsType

;;;     GtkMessageDialog

(test message-dialog-class
  ;; Type check
  (is (g:type-is-object "GtkMessageDialog"))
  ;; Check the registered name
  (is (eq 'gtk:message-dialog
          (gobject:symbol-for-gtype "GtkMessageDialog")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkMessageDialog")
          (g:gtype (cffi:foreign-funcall "gtk_message_dialog_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkDialog")
          (g:type-parent "GtkMessageDialog")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkMessageDialog")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable")
             (list-interfaces "GtkMessageDialog")))
  ;; Check the class properties
  (is (equal '("buttons" "image" "message-area" "message-type" "secondary-text"
               "secondary-use-markup" "text" "use-markup")
             (list-properties "GtkMessageDialog")))
  ;; Get the names of the style properties
  (is (equal '("message-border")
             (list-style-properties "GtkMessageDialog")))
  ;; Get the names of the child properties
  (is (equal '()
             (list-child-properties "GtkMessageDialog")))
  (is (equal '()
             (list-signals "GtkMessageDialog")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkMessageDialog" GTK-MESSAGE-DIALOG
                       (:SUPERCLASS GTK-DIALOG :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable")
                        :TYPE-INITIALIZER "gtk_message_dialog_get_type")
                       ((BUTTONS GTK-MESSAGE-DIALOG-BUTTONS "buttons"
                         "GtkButtonsType" NIL NIL)
                        (IMAGE GTK-MESSAGE-DIALOG-IMAGE "image" "GtkWidget" T
                         T)
                        (MESSAGE-AREA GTK-MESSAGE-DIALOG-MESSAGE-AREA
                         "message-area" "GtkWidget" T NIL)
                        (MESSAGE-TYPE GTK-MESSAGE-DIALOG-MESSAGE-TYPE
                         "message-type" "GtkMessageType" T T)
                        (SECONDARY-TEXT GTK-MESSAGE-DIALOG-SECONDARY-TEXT
                         "secondary-text" "gchararray" T T)
                        (SECONDARY-USE-MARKUP
                         GTK-MESSAGE-DIALOG-SECONDARY-USE-MARKUP
                         "secondary-use-markup" "gboolean" T T)
                        (TEXT GTK-MESSAGE-DIALOG-TEXT "text" "gchararray" T T)
                        (USE-MARKUP GTK-MESSAGE-DIALOG-USE-MARKUP "use-markup"
                         "gboolean" T T)))
             (gobject:get-g-type-definition "GtkMessageDialog"))))

;;; --- Properties -------------------------------------------------------------

(test message-dialog-properties
  (let ((dialog (make-instance 'gtk:message-dialog)))
    ;; Property buttons is not readable
    (signals (error) (gtk:message-dialog-buttons dialog))
    (is (typep (gtk:message-dialog-image dialog) 'gtk:image))
    (is (typep (gtk:message-dialog-message-area dialog) 'gtk:box))
    (is (eq :info (gtk:message-dialog-message-type dialog)))
    (is-false (gtk:message-dialog-secondary-text dialog))
    (is-false (gtk:message-dialog-secondary-use-markup dialog))
    (is (string= "" (gtk:message-dialog-text dialog)))
    (is-false (gtk:message-dialog-use-markup dialog))))

;;; --- Style Properties -------------------------------------------------------

(test message-dialog-style-properties
  (let ((dialog (make-instance 'gtk:message-dialog)))
    (is (= 12
           (gtk:widget-style-property dialog "message-border")))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_message_dialog_new

(test message-dialog-new
  (let ((dialog (gtk:message-dialog-new nil
                                        '(:modal :use-header-bar)
                                        :question
                                        :ok-cancel
                                        "The ~a value."
                                        10)))
    (is (typep (gtk:message-dialog-image dialog) 'gtk:image))
    (is (typep (gtk:message-dialog-message-area dialog) 'gtk:box))
    (is (eq :question (gtk:message-dialog-message-type dialog)))
    (is-false (gtk:message-dialog-secondary-text dialog))
    (is-false (gtk:message-dialog-secondary-use-markup dialog))
    (is (string= "The 10 value." (gtk:message-dialog-text dialog)))
    (is-false (gtk:message-dialog-use-markup dialog))))

;;;     gtk_message_dialog_new_with_markup

(test message-dialog-new-with-markup
  (let ((dialog (gtk:message-dialog-new-with-markup nil
                                                    '(:modal :use-header-bar)
                                                    :question
                                                    :ok-cancel
                                                    "<b>The ~a value.</b>"
                                                    10)))
    (is (typep (gtk:message-dialog-image dialog) 'gtk:image))
    (is (typep (gtk:message-dialog-message-area dialog) 'gtk:box))
    (is (eq :question (gtk:message-dialog-message-type dialog)))
    (is-false (gtk:message-dialog-secondary-text dialog))
    (is-false (gtk:message-dialog-secondary-use-markup dialog))
    (is (string= "<b>The 10 value.</b>" (gtk:message-dialog-text dialog)))
    (is-true (gtk:message-dialog-use-markup dialog))))

;;;     gtk_message_dialog_set_markup
;;;     gtk_message_dialog_set_image
;;;     gtk_message_dialog_get_image
;;;     gtk_message_dialog_format_secondary_text
;;;     gtk_message_dialog_format_secondary_markup
;;;     gtk_message_dialog_get_message_area

;;; --- 2022-12-26 -------------------------------------------------------------
