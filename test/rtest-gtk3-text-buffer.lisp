(in-package :gtk-test)

(def-suite gtk-text-buffer :in gtk-suite)
(in-suite gtk-text-buffer)

(defvar *sample-text-1*
  "Weit hinten, hinter den Wortbergen, fern der Länder Vokalien und Konsonantien
leben die Blindtexte. Abgeschieden wohnen Sie in Buchstabenhausen an der Küste
des Semantik, eines großen Sprachozeans. Ein kleines Bächlein namens Duden
fließt durch ihren Ort und versorgt sie mit den nötigen Regelialien. Es ist ein
paradiesmatisches Land, in dem einem gebratene Satzteile in den Mund fliegen.
Nicht einmal von der allmächtigen Interpunktion werden die Blindtexte beherrscht
– ein geradezu unorthographisches Leben.

Eines Tages aber beschloss eine kleine Zeile Blindtext, ihr Name war Lorem
Ipsum, hinaus zu gehen in die weite Grammatik. Der große Oxmox riet ihr davon
ab, da es dort wimmele von bösen Kommata, wilden Fragezeichen und hinterhältigen
Semikola, doch das Blindtextchen ließ sich nicht beirren. Es packte seine sieben
Versalien, schob sich sein Initial in den Gürtel und machte sich auf den Weg.

Als es die ersten Hügel des Kursivgebirges erklommen hatte, warf es einen
letzten Blick zurück auf die Skyline seiner Heimatstadt Buchstabenhausen, die
Headline von Alphabetdorf und die Subline seiner eigenen Straße, der
Zeilengasse. Wehmütig lief ihm eine rhetorische Frage über die Wange, dann
setzte es seinen Weg fort.

Unterwegs traf es eine Copy. Die Copy warnte das Blindtextchen, da, wo sie
herkäme, wäre sie zigmal umgeschrieben worden und alles, was von ihrem Ursprung
noch übrig wäre, sei das Wort »und« und das Blindtextchen solle umkehren und
wieder in sein eigenes, sicheres Land zurückkehren.

Doch alles Gutzureden konnte es nicht überzeugen und so dauerte es nicht lange,
bis ihm ein paar heimtückische Werbetexter auflauerten, es mit Longe und Parole
betrunken machten und es dann in ihre Agentur schleppten, wo sie es für ihre
Projekte wieder und wieder missbrauchten. Und wenn es nicht umgeschrieben wurde,
dann benutzen Sie es immer noch.")

(defvar *sample-text-2*
  "Dies ist ein Typoblindtext.
An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. Manchmal
benutzt man Worte wie Hamburgefonts, Rafgenduks oder Handgloves, um Schriften zu
testen. Manchmal Sätze, die alle Buchstaben des Alphabets enthalten – man nennt
diese Sätze »Pangramme«. Sehr bekannt ist dieser: The quick brown fox jumps over
the lazy dog. Oft werden in Typoblindtexte auch fremdsprachige Satzteile
eingebaut (AVAIL® and Wefox™ are testing aussi la Kerning), um die Wirkung in
anderen Sprachen zu testen. In Lateinisch sieht zum Beispiel fast jede Schrift
gut aus. Quod erat demonstrandum.

Seit 1975 fehlen in den meisten Testtexten die Zahlen, weswegen nach TypoGb.
204 § ab dem Jahr 2034 Zahlen in 86 der Texte zur Pflicht werden.
Nichteinhaltung wird mit bis zu 245 € oder 368 $ bestraft. Genauso wichtig in
sind mittlerweile auch Â ç c è ñ t ë , die in neueren Schriften aber fast immer
enthalten sind. Ein wichtiges, aber schwierig zu integrierendes Feld sind
OpenType-Funktionalitäten. Je nach Software und Voreinstellungen können
eingebaute Kapitälchen, Kerning oder Ligaturen (sehr pfi ffi g) nicht richtig
dargestellt werden.")

;;; --- Types and Values -------------------------------------------------------

;;;   GtkTextBuffer

(test text-buffer-class
  ;; Type check
  (is (g:type-is-object "GtkTextBuffer"))
  ;; Check the registered name
  (is (eq 'gtk:text-buffer
          (gobject:symbol-for-gtype "GtkTextBuffer")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkTextBuffer")
          (g:gtype (cffi:foreign-funcall "gtk_text_buffer_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GObject") (g:type-parent "GtkTextBuffer")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkTextBuffer")))
  ;; Check the interfaces
  (is (equal '()
             (list-interfaces "GtkTextBuffer")))
  ;; Check the class properties
  (is (equal '("copy-target-list" "cursor-position" "has-selection"
               "paste-target-list" "tag-table" "text")
             (list-properties "GtkTextBuffer")))
  ;; Check the signals
  (is (equal '("apply-tag" "begin-user-action" "changed" "delete-range"
               "end-user-action" "insert-child-anchor" "insert-pixbuf"
               "insert-text" "mark-deleted" "mark-set" "modified-changed"
               "paste-done" "remove-tag")
             (list-signals "GtkTextBuffer")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkTextBuffer" GTK-TEXT-BUFFER
                       (:SUPERCLASS G-OBJECT :EXPORT T :INTERFACES NIL
                        :TYPE-INITIALIZER "gtk_text_buffer_get_type")
                       ((COPY-TARGET-LIST GTK-TEXT-BUFFER-COPY-TARGET-LIST
                         "copy-target-list" "GtkTargetList" T NIL)
                        (CURSOR-POSITION GTK-TEXT-BUFFER-CURSOR-POSITION
                         "cursor-position" "gint" T NIL)
                        (HAS-SELECTION GTK-TEXT-BUFFER-HAS-SELECTION
                         "has-selection" "gboolean" T NIL)
                        (PASTE-TARGET-LIST GTK-TEXT-BUFFER-PASTE-TARGET-LIST
                         "paste-target-list" "GtkTargetList" T NIL)
                        (TAG-TABLE GTK-TEXT-BUFFER-TAG-TABLE "tag-table"
                         "GtkTextTagTable" T NIL)
                        (TEXT GTK-TEXT-BUFFER-TEXT "text" "gchararray" T T)))
             (gobject:get-g-type-definition "GtkTextBuffer"))))

;;; --- Properties -------------------------------------------------------------

;;;       GtkTargetList*  copy-target-list       Read
;;;                gint   cursor-position        Read
;;;            gboolean   has-selection          Read
;;;       GtkTargetList*  paste-target-list      Read
;;;     GtkTextTagTable*  tag-table              Read / Write / Construct Only
;;;               gchar*  text                   Read / Write

(test text-buffer-properties
  (let ((buffer (make-instance 'gtk:text-buffer)))
    (is (typep (gtk:text-buffer-copy-target-list buffer) 'gtk:target-list))
    (is (= 0 (gtk:text-buffer-cursor-position buffer)))
    (is-false (gtk:text-buffer-has-selection buffer))
    (is (typep (gtk:text-buffer-paste-target-list buffer) 'gtk:target-list))
    (is (typep (gtk:text-buffer-tag-table buffer) 'gtk:text-tag-table))
    (is (string= "" (gtk:text-buffer-text buffer)))))

;;; --- Functions --------------------------------------------------------------

;;;   gtk_text_buffer_new

(test text-buffer-new.1
  (is (typep (gtk:text-buffer-new) 'gtk:text-buffer))
  (is (typep (gtk:text-buffer-tag-table (gtk:text-buffer-new))
             'gtk:text-tag-table)))

(test text-buffer-new.2
  (is (typep (gtk:text-buffer-new nil) 'gtk:text-buffer))
  (is (typep (gtk:text-buffer-tag-table (gtk:text-buffer-new nil))
             'gtk:text-tag-table)))

(test text-buffer-new.3
  (let ((tag-table (gtk:text-tag-table-new)))
    (is (typep (gtk:text-buffer-new tag-table) 'gtk:text-buffer))
    (is (eq tag-table
            (gtk:text-buffer-tag-table (gtk:text-buffer-new tag-table))))))

;;;   gtk_text_buffer_get_line_count

(test text-buffer-line-count.1
  (let ((buffer (gtk:text-buffer-new)))
    (setf (gtk:text-buffer-text buffer) *sample-text-1*)
    (is (= 30 (gtk:text-buffer-line-count buffer)))))

(test text-buffer-line-count.2
  (let ((buffer (gtk:text-buffer-new)))
    (setf (gtk:text-buffer-text buffer) *sample-text-2*)
    (is (= 18 (gtk:text-buffer-line-count buffer)))))

;;;   gtk_text_buffer_get_char_count

#-windows
(test text-buffer-char-count.1
  (let ((buffer (gtk:text-buffer-new)))
    (setf (gtk:text-buffer-text buffer) *sample-text-1*)
    (is (= 1866 (gtk:text-buffer-char-count buffer)))))

#-windows
(test text-buffer-char-count.2
  (let ((buffer (gtk:text-buffer-new)))
    (setf (gtk:text-buffer-text buffer) *sample-text-2*)
    (is (= 1160 (gtk:text-buffer-char-count buffer)))))

;;;     gtk_text_buffer_insert
;;;     gtk_text_buffer_insert_at_cursor
;;;     gtk_text_buffer_insert_interactive
;;;     gtk_text_buffer_insert_interactive_at_cursor

(test text-buffer-insert.1
  (let* ((buffer (make-instance 'gtk:text-buffer))
         (iter (gtk:text-buffer-start-iter buffer)))
    (is-true (gtk:text-buffer-insert buffer "text1"))
    (is (string= "text1" (gtk:text-buffer-text buffer)))
    (is (= 5 (gtk:text-buffer-cursor-position buffer)))

    (is-true (setf iter (gtk:text-buffer-end-iter buffer)))
    (is-true (gtk:text-buffer-insert buffer "text2" :position iter))
    (is (string= "text1text2" (gtk:text-buffer-text buffer)))
    (is (= 10 (gtk:text-buffer-cursor-position buffer)))

    (is-true (gtk:text-buffer-insert buffer "text3" :interactive t))
    (is (string= "text1text2text3" (gtk:text-buffer-text buffer)))
    (is (= 15 (gtk:text-buffer-cursor-position buffer)))

    (is-true (setf iter (gtk:text-buffer-end-iter buffer)))
    (is-true (gtk:text-buffer-insert buffer "text4" :position iter :interactive t))
    (is (string= "text1text2text3text4" (gtk:text-buffer-text buffer)))
    (is (= 20 (gtk:text-buffer-cursor-position buffer)))))

(test text-buffer-insert.2
  (let ((buffer (make-instance 'gtk:text-buffer)))
    (is-true (gtk:text-buffer-insert buffer "text"))
    (is (string= "text" (gtk:text-buffer-text buffer)))
    (is (= 4 (gtk:text-buffer-cursor-position buffer)))

    (is-true (gtk:text-buffer-insert buffer "text"))
    (is (string= "texttext" (gtk:text-buffer-text buffer)))
    (is (= 8 (gtk:text-buffer-cursor-position buffer)))))

(test text-buffer-insert.3
  (let* ((buffer (make-instance 'gtk:text-buffer))
         (iter (gtk:text-buffer-start-iter buffer)))
    (is-true (gtk:text-buffer-insert buffer "text" :position iter :interactive t))
    (is (string= "text" (gtk:text-buffer-text buffer)))
    (is (= 4 (gtk:text-buffer-cursor-position buffer)))

    (is-true (gtk:text-buffer-insert buffer "text" :position iter :interactive t))
    (is (string= "texttext" (gtk:text-buffer-text buffer)))
    (is (= 8 (gtk:text-buffer-cursor-position buffer)))

    (is-false (gtk:text-buffer-insert buffer "text" :position iter
                                                    :interactive t
                                                    :editable nil))
    (is (string= "texttext" (gtk:text-buffer-text buffer)))
    (is (= 8 (gtk:text-buffer-cursor-position buffer)))))

(test text-buffer-insert.4
  (let ((buffer (make-instance 'gtk:text-buffer)))
    (is-true (gtk:text-buffer-insert buffer "text" :interactive t))
    (is (string= "text" (gtk:text-buffer-text buffer)))
    (is (= 4 (gtk:text-buffer-cursor-position buffer)))

    (is-true (gtk:text-buffer-insert buffer "text" :interactive t))
    (is (string= "texttext" (gtk:text-buffer-text buffer)))
    (is (= 8 (gtk:text-buffer-cursor-position buffer)))

    (is-false (gtk:text-buffer-insert buffer "text" :interactive t
                                                    :editable nil))
    (is (string= "texttext" (gtk:text-buffer-text buffer)))
    (is (= 8 (gtk:text-buffer-cursor-position buffer)))))

;;;     gtk_text_buffer_insert_range
;;;     gtk_text_buffer_insert_range_interactive

;;;     gtk_text_buffer_insert_with_tags
;;;     gtk_text_buffer_insert_with_tags_by_name

(test text-buffer-insert-with-tags.1
  (let* ((buffer (make-instance 'gtk:text-buffer))
         (iter (gtk:text-buffer-start-iter buffer))
         (bold (make-instance 'gtk:text-tag
                              :name "bold"
                              :weight 700))
         (underline (make-instance 'gtk:text-tag
                                   :name "underline"
                                   :underline :single)))
    (is-true (gtk:text-tag-table-add (gtk:text-buffer-tag-table buffer) bold))
    (is-true (gtk:text-tag-table-add (gtk:text-buffer-tag-table buffer) underline))

    (is-true (gtk:text-buffer-insert-with-tags buffer iter "text1"))
    (is (string= "text1" (gtk:text-buffer-text buffer)))
    (is (= 5 (gtk:text-buffer-cursor-position buffer)))

    (is-true (setf iter (gtk:text-buffer-end-iter buffer)))
    (is-true (gtk:text-buffer-insert-with-tags buffer iter "text2" bold))
    (is (string= "text1text2" (gtk:text-buffer-text buffer)))
    (is (= 10 (gtk:text-buffer-cursor-position buffer)))

    (is-true (gtk:text-buffer-insert-with-tags buffer iter "text3" bold underline))
    (is (string= "text1text2text3" (gtk:text-buffer-text buffer)))
    (is (= 15 (gtk:text-buffer-cursor-position buffer)))))

(test text-buffer-insert-with-tags.2
  (let* ((buffer (make-instance 'gtk:text-buffer))
         (iter (gtk:text-buffer-start-iter buffer))
         (bold (make-instance 'gtk:text-tag
                              :name "bold"
                              :weight 700))
         (underline (make-instance 'gtk:text-tag
                                   :name "underline"
                                   :underline :single)))
    (is-true (gtk:text-tag-table-add (gtk:text-buffer-tag-table buffer) bold))
    (is-true (gtk:text-tag-table-add (gtk:text-buffer-tag-table buffer) underline))

    (is-true (gtk:text-buffer-insert-with-tags buffer iter "text1"))
    (is (string= "text1" (gtk:text-buffer-text buffer)))
    (is (= 5 (gtk:text-buffer-cursor-position buffer)))

    (is-true (setf iter (gtk:text-buffer-end-iter buffer)))
    (is-true (gtk:text-buffer-insert-with-tags buffer iter "text2" "bold"))
    (is (string= "text1text2" (gtk:text-buffer-text buffer)))
    (is (= 10 (gtk:text-buffer-cursor-position buffer)))

    (is-true (gtk:text-buffer-insert-with-tags buffer
                                               iter "text3" "bold" "underline"))
    (is (string= "text1text2text3" (gtk:text-buffer-text buffer)))
    (is (= 15 (gtk:text-buffer-cursor-position buffer)))))

;;;     gtk_text_buffer_delete
;;;     gtk_text_buffer_delete_interactive
;;;     gtk_text_buffer_backspace

;;;   gtk_text_buffer_set_text

(test text-buffer-text.1
  (let ((buffer (gtk:text-buffer-new)))
    (setf (gtk:text-buffer-text buffer) *sample-text-1*)
    (is (string= *sample-text-1* (gtk:text-buffer-text buffer)))))

(test text-buffer-text.2
  (let ((buffer (gtk:text-buffer-new)))
    (setf (gtk:text-buffer-text buffer) *sample-text-2*)
    (is (string= *sample-text-2* (gtk:text-buffer-text buffer)))))

;;;     gtk_text_buffer_get_text
;;;     gtk_text_buffer_get_slice
;;;     gtk_text_buffer_insert_pixbuf
;;;     gtk_text_buffer_insert_child_anchor
;;;     gtk_text_buffer_create_child_anchor
;;;     gtk_text_buffer_create_mark
;;;     gtk_text_buffer_move_mark
;;;     gtk_text_buffer_move_mark_by_name
;;;     gtk_text_buffer_add_mark

;;;     gtk_text_buffer_delete_mark
;;;     gtk_text_buffer_delete_mark_by_name

(test text-buffer-delete-mark
  (let ((buffer (gtk:text-buffer-new)))

    (is (stringp (setf (gtk:text-buffer-text buffer) *sample-text-1*)))

    (let ((iter (gtk:text-buffer-start-iter buffer))
          (mark (gtk:text-mark-new "mark" t)))

      (is-false (gtk:text-buffer-add-mark buffer mark iter))
      (is-false (gtk:text-mark-deleted mark))
      (is-false (gtk:text-buffer-delete-mark buffer mark))
      (is-true (gtk:text-mark-deleted mark))

      (is-false (gtk:text-buffer-add-mark buffer mark iter))
      (is-false (gtk:text-mark-deleted mark))
      (is-false (gtk:text-buffer-delete-mark buffer "mark"))
      (is-true (gtk:text-mark-deleted mark))

)))

;;;     gtk_text_buffer_get_mark
;;;     gtk_text_buffer_get_insert
;;;     gtk_text_buffer_get_selection_bound
;;;     gtk_text_buffer_get_has_selection
;;;     gtk_text_buffer_place_cursor
;;;     gtk_text_buffer_select_range
;;;     gtk_text_buffer_apply_tag
;;;     gtk_text_buffer_remove_tag
;;;     gtk_text_buffer_apply_tag_by_name
;;;     gtk_text_buffer_remove_tag_by_name
;;;     gtk_text_buffer_remove_all_tags

;;;     gtk_text_buffer_create_tag

(test text-buffer-create-tag
  (let ((buffer (make-instance 'gtk:text-buffer :text "Some sample text.")))
    (is (typep (gtk:text-buffer-create-tag buffer "bold" :weight 400)
               'gtk:text-tag))
    (is (typep (gtk:text-buffer-create-tag buffer "font-italic"
                                                  :font "fixed"
                                                  :style :italic)
               'gtk:text-tag))))

;;;     gtk_text_buffer_get_iter_at_line_offset
;;;     gtk_text_buffer_get_iter_at_offset
;;;     gtk_text_buffer_get_iter_at_line
;;;     gtk_text_buffer_get_iter_at_line_index
;;;     gtk_text_buffer_get_iter_at_mark
;;;     gtk_text_buffer_get_iter_at_child_anchor
;;;     gtk_text_buffer_get_start_iter
;;;     gtk_text_buffer_get_end_iter
;;;     gtk_text_buffer_get_bounds

;;;     gtk_text_buffer_get_modified
;;;     gtk_text_buffer_set_modified

(test text-buffer-modified
  (let ((buffer (make-instance 'gtk:text-buffer :text *sample-text-1*)))
    (is-true (gtk:text-buffer-modified buffer))
    (is-false (setf (gtk:text-buffer-modified buffer) nil))
    (is-false (gtk:text-buffer-modified buffer))
    ;; Modify the buffer
    (is-true (gtk:text-buffer-insert buffer "text"))
    (is-true (gtk:text-buffer-modified buffer))))

;;;     gtk_text_buffer_delete_selection
;;;     gtk_text_buffer_paste_clipboard
;;;     gtk_text_buffer_copy_clipboard
;;;     gtk_text_buffer_cut_clipboard
;;;     gtk_text_buffer_get_selection_bounds
;;;     gtk_text_buffer_begin_user_action
;;;     gtk_text_buffer_end_user_action
;;;     gtk_text_buffer_add_selection_clipboard
;;;     gtk_text_buffer_remove_selection_clipboard
;;;
;;;     GtkTextBufferTargetInfo
;;;
;;;     gtk_text_buffer_deserialize
;;;     gtk_text_buffer_deserialize_get_can_create_tags
;;;     gtk_text_buffer_deserialize_set_can_create_tags
;;;     gtk_text_buffer_get_copy_target_list
;;;     gtk_text_buffer_get_deserialize_formats
;;;     gtk_text_buffer_get_paste_target_list
;;;     gtk_text_buffer_get_serialize_formats
;;;     gtk_text_buffer_register_deserialize_format
;;;     gtk_text_buffer_register_deserialize_tagset
;;;     gtk_text_buffer_register_serialize_format
;;;     gtk_text_buffer_register_serialize_tagset
;;;     gtk_text_buffer_serialize
;;;     gtk_text_buffer_unregister_deserialize_format
;;;     gtk_text_buffer_unregister_serialize_format

;;; --- 2022-12-27 -------------------------------------------------------------
