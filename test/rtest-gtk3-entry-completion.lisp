(in-package :gtk-test)

(def-suite gtk-entry-completion :in gtk-suite)
(in-suite gtk-entry-completion)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkEntryCompletion

(test gtk-entry-completion-class
  ;; Type check
  (is (g:type-is-object "GtkEntryCompletion"))
  ;; Check the registered name
  (is (eq 'gtk:entry-completion
          (glib:symbol-for-gtype "GtkEntryCompletion")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkEntryCompletion")
          (g:gtype (cffi:foreign-funcall "gtk_entry_completion_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GObject")
          (g:type-parent "GtkEntryCompletion")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkEntryCompletion")))
  ;; Check the interfaces
  (is (equal '("GtkCellLayout" "GtkBuildable")
             (list-interfaces "GtkEntryCompletion")))
  ;; Check the class properties
  (is (equal '("cell-area" "inline-completion" "inline-selection"
               "minimum-key-length" "model" "popup-completion" "popup-set-width"
               "popup-single-match" "text-column")
             (list-properties "GtkEntryCompletion")))
  (is (equal '("action-activated" "cursor-on-match" "insert-prefix"
               "match-selected" "no-matches")
             (list-signals "GtkEntryCompletion")))
  ;; Check the class definition
  (is (equal '(GOBJECT:DEFINE-G-OBJECT-CLASS "GtkEntryCompletion" GTK-ENTRY-COMPLETION
                       (:SUPERCLASS G-OBJECT :EXPORT T :INTERFACES
                        ("GtkBuildable" "GtkCellLayout") :TYPE-INITIALIZER
                        "gtk_entry_completion_get_type")
                       ((CELL-AREA GTK-ENTRY-COMPLETION-CELL-AREA "cell-area"
                         "GtkCellArea" T NIL)
                        (INLINE-COMPLETION
                         GTK-ENTRY-COMPLETION-INLINE-COMPLETION
                         "inline-completion" "gboolean" T T)
                        (INLINE-SELECTION GTK-ENTRY-COMPLETION-INLINE-SELECTION
                         "inline-selection" "gboolean" T T)
                        (MINIMUM-KEY-LENGTH
                         GTK-ENTRY-COMPLETION-MINIMUM-KEY-LENGTH
                         "minimum-key-length" "gint" T T)
                        (MODEL GTK-ENTRY-COMPLETION-MODEL "model"
                         "GtkTreeModel" T T)
                        (POPUP-COMPLETION GTK-ENTRY-COMPLETION-POPUP-COMPLETION
                         "popup-completion" "gboolean" T T)
                        (POPUP-SET-WIDTH GTK-ENTRY-COMPLETION-POPUP-SET-WIDTH
                         "popup-set-width" "gboolean" T T)
                        (POPUP-SINGLE-MATCH
                         GTK-ENTRY-COMPLETION-POPUP-SINGLE-MATCH
                         "popup-single-match" "gboolean" T T)
                        (TEXT-COLUMN GTK-ENTRY-COMPLETION-TEXT-COLUMN
                         "text-column" "gint" T T)))
             (gobject:get-g-type-definition "GtkEntryCompletion"))))

;;; --- Properties -------------------------------------------------------------

(test gtk-entry-completion-properties
  (let ((completion (make-instance 'gtk:entry-completion)))
    (is (typep (gtk:entry-completion-cell-area completion) 'gtk:cell-area))
    (is-false (gtk:entry-completion-inline-completion completion))
    (is-false (gtk:entry-completion-inline-selection completion))
    (is (= 1 (gtk:entry-completion-minimum-key-length completion)))
    (is-false (gtk:entry-completion-model completion))
    (is-true (gtk:entry-completion-popup-completion completion))
    (is-true (gtk:entry-completion-popup-set-width completion))
    (is-true (gtk:entry-completion-popup-single-match completion))
    (is (= -1 (gtk:entry-completion-text-column completion)))))

;;; --- Signals ----------------------------------------------------------------

;;;     action-activated
;;;     cursor-on-match
;;;     insert-prefix
;;;     match-selected
;;;     no-matches

;;; --- Functions --------------------------------------------------------------

;;;     GtkEntryCompletionMatchFunc

;;;     gtk_entry_completion_new

(test gtk-entry-completion-new
  (is (typep (gtk:entry-completion-new) 'gtk:entry-completion)))

;;;     gtk_entry_completion_new_with_area

(test gtk-entry-completion-new-with-area
  (let ((area (gtk:cell-area-box-new)))
    (is (typep (gtk:entry-completion-new-with-area area)
               'gtk:entry-completion))))

;;;     gtk_entry_completion_get_entry
;;;     gtk_entry_completion_set_match_func
;;;     gtk_entry_completion_compute_prefix
;;;     gtk_entry_completion_complete
;;;     gtk_entry_completion_get_completion_prefix
;;;     gtk_entry_completion_insert_prefix
;;;     gtk_entry_completion_insert_action_text
;;;     gtk_entry_completion_insert_action_markup
;;;     gtk_entry_completion_delete_action

;;; 2024-3-17
