(in-package :gtk-test)

(def-suite gtk-entry-completion :in gtk-suite)
(in-suite gtk-entry-completion)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkEntryCompletion

(test gtk-entry-completion-class
  ;; Check type
  (is (g:type-is-object "GtkEntryCompletion"))
  ;; Check registered name
  (is (eq 'gtk:entry-completion
          (glib:symbol-for-gtype "GtkEntryCompletion")))
  ;; Check type initializer
  (is (eq (g:gtype "GtkEntryCompletion")
          (g:gtype (cffi:foreign-funcall "gtk_entry_completion_get_type" :size))))
  ;; Check parent
  (is (eq (g:gtype "GObject")
          (g:type-parent "GtkEntryCompletion")))
  ;; Check children
  (is (equal '()
             (glib-test:list-children "GtkEntryCompletion")))
  ;; Check interfaces
  (is (equal '("GtkCellLayout" "GtkBuildable")
             (glib-test:list-interfaces "GtkEntryCompletion")))
  ;; Check class properties
  (is (equal '("cell-area" "inline-completion" "inline-selection"
               "minimum-key-length" "model" "popup-completion" "popup-set-width"
               "popup-single-match" "text-column")
             (glib-test:list-properties "GtkEntryCompletion")))
  (is (equal '("action-activated" "cursor-on-match" "insert-prefix"
               "match-selected" "no-matches")
             (glib-test:list-signals "GtkEntryCompletion")))
  ;; Check class definition
  (is (equal '(GOBJECT:DEFINE-GOBJECT "GtkEntryCompletion" GTK:ENTRY-COMPLETION
                       (:SUPERCLASS G:OBJECT
                        :EXPORT T
                        :INTERFACES ("GtkBuildable" "GtkCellLayout")
                        :TYPE-INITIALIZER "gtk_entry_completion_get_type")
                       ((CELL-AREA ENTRY-COMPLETION-CELL-AREA
                         "cell-area" "GtkCellArea" T NIL)
                        (INLINE-COMPLETION ENTRY-COMPLETION-INLINE-COMPLETION
                         "inline-completion" "gboolean" T T)
                        (INLINE-SELECTION ENTRY-COMPLETION-INLINE-SELECTION
                         "inline-selection" "gboolean" T T)
                        (MINIMUM-KEY-LENGTH ENTRY-COMPLETION-MINIMUM-KEY-LENGTH
                         "minimum-key-length" "gint" T T)
                        (MODEL ENTRY-COMPLETION-MODEL "model" "GtkTreeModel" T T)
                        (POPUP-COMPLETION ENTRY-COMPLETION-POPUP-COMPLETION
                         "popup-completion" "gboolean" T T)
                        (POPUP-SET-WIDTH ENTRY-COMPLETION-POPUP-SET-WIDTH
                         "popup-set-width" "gboolean" T T)
                        (POPUP-SINGLE-MATCH ENTRY-COMPLETION-POPUP-SINGLE-MATCH
                         "popup-single-match" "gboolean" T T)
                        (TEXT-COLUMN ENTRY-COMPLETION-TEXT-COLUMN
                         "text-column" "gint" T T)))
             (gobject:get-gtype-definition "GtkEntryCompletion"))))

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

;;; 2024-9-22
