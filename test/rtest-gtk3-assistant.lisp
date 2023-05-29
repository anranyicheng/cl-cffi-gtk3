(in-package :gtk-test)

(def-suite gtk-assistant :in gtk-suite)
(in-suite gtk-assistant)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkAssistantPageType

;;;     GtkAssistant

(test assistant-class
  ;; Type check
  (is (g:type-is-object "GtkAssistant"))
  ;; Check the registered name
  (is (eq 'gtk:assistant
          (glib:symbol-for-gtype "GtkAssistant")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkAssistant")
          (g:gtype (cffi:foreign-funcall "gtk_assistant_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GtkWindow")
          (g:type-parent "GtkAssistant")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkAssistant")))
  ;; Check the interfaces
  (is (equal '("AtkImplementorIface" "GtkBuildable")
             (list-interfaces "GtkAssistant")))
  ;; Check the class properties
  (is (equal '("use-header-bar")
             (list-properties "GtkAssistant")))
  ;; Get the names of the style properties
  (is (equal '("content-padding" "header-padding")
             (list-style-properties "GtkAssistant")))
  ;; Get the names of the child properties
  (is (equal '("complete" "has-padding" "header-image" "page-type"
               "sidebar-image" "title")
             (list-child-properties "GtkAssistant")))
  ;; Check the signals
  (is (equal '("apply" "cancel" "close" "escape" "prepare")
             (list-signals "GtkAssistant")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkAssistant" GTK-ASSISTANT
                       (:SUPERCLASS GTK-WINDOW :EXPORT T :INTERFACES
                        ("AtkImplementorIface" "GtkBuildable")
                        :TYPE-INITIALIZER "gtk_assistant_get_type")
                       ((USE-HEADER-BAR GTK-ASSISTANT-USE-HEADER-BAR
                         "use-header-bar" "gint" T NIL)))
             (gobject:get-g-type-definition "GtkAssistant"))))

;;; --- Properties -------------------------------------------------------------

;;;     use-header-bar

;;; --- Child Properties -------------------------------------------------------

;;;     complete
;;;     has-padding
;;;     header-image
;;;     page-type
;;;     sidebar-image
;;;     title

;;; --- Style Properties -------------------------------------------------------

;;;     content-padding
;;;     header-padding

;;; --- Signals ----------------------------------------------------------------

;;;     apply
;;;     cancel
;;;     close
;;;     escape
;;;     prepare

;;; --- Functions --------------------------------------------------------------

;;;     gtk_assistant_new

(test assistant-new
  (is (typep (gtk:assistant-new) 'gtk:assistant)))

;;;     gtk_assistant_get_current_page
;;;     gtk_assistant_set_current_page
;;;     gtk_assistant_get_n_pages
;;;     gtk_assistant_get_nth_page
;;;     gtk_assistant_prepend_page
;;;     gtk_assistant_append_page
;;;     gtk_assistant_insert_page
;;;     gtk_assistant_remove_page
;;;
;;;     GtkAssistantPageFunc

#+nil
(test gtk-assistant-page-func
  (is (equal '(PROGN
 (DEFCALLBACK GTK-ASSISTANT-PAGE-FUNC-CB
     :INT
     ((CURRENT-PAGE :INT) (#:DATA810 :POINTER))
   (LET* ((#:OBJECT807
           (CONVERT-FROM-FOREIGN
            (FOREIGN-SLOT-VALUE #:DATA810 '(:STRUCT GOBJECT::OBJECT-FUNC-REF)
                                :OBJECT)
            'G-OBJECT))
          (#:FN-ID808
           (FOREIGN-SLOT-VALUE #:DATA810 '(:STRUCT GOBJECT::OBJECT-FUNC-REF)
                               :FN-ID))
          (#:FN809
           (GOBJECT::RETRIEVE-HANDLER-FROM-OBJECT #:OBJECT807 #:FN-ID808)))
     (FUNCALL #:FN809 CURRENT-PAGE)))
 (DEFCALLBACK GTK-ASSISTANT-PAGE-FUNC-DESTROY-NOTIFY
     :VOID
     ((#:DATA810 :POINTER))
   (LET* ((#:OBJECT807
           (CONVERT-FROM-FOREIGN
            (FOREIGN-SLOT-VALUE #:DATA810 '(:STRUCT GOBJECT::OBJECT-FUNC-REF)
                                :OBJECT)
            'G-OBJECT))
          (#:FN-ID808
           (FOREIGN-SLOT-VALUE #:DATA810 '(:STRUCT GOBJECT::OBJECT-FUNC-REF)
                               :FN-ID)))
     (GOBJECT::DELETE-HANDLER-FROM-OBJECT #:OBJECT807 #:FN-ID808))
   (FOREIGN-FREE #:DATA810)))
             (macroexpand '(define-cb-methods gtk-assistant-page-func :int
                               ((current-page :int)))))))

;;;     gtk_assistant_set_forward_page_func
;;;
;;;     gtk_assistant_set_page_type
;;;     gtk_assistant_get_page_type
;;;     gtk_assistant_set_page_title
;;;     gtk_assistant_get_page_title
;;;     gtk_assistant_set_page_header_image                * deprecated
;;;     gtk_assistant_get_page_header_image                * deprecated
;;;     gtk_assistant_set_page_side_image                  * deprecated
;;;     gtk_assistant_get_page_side_image                  * deprecated
;;;     gtk_assistant_set_page_complete
;;;     gtk_assistant_get_page_complete
;;;     gtk_assistant_set_page_has_padding
;;;     gtk_assistant_get_page_has_padding
;;;     gtk_assistant_add_action_widget
;;;     gtk_assistant_remove_action_widget
;;;     gtk_assistant_update_buttons_state
;;;     gtk_assistant_commit
;;;     gtk_assistant_next_page
;;;     gtk_assistant_previous_page

;;; --- 2023-5-29 --------------------------------------------------------------
