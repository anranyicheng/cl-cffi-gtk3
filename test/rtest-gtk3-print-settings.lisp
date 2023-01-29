(in-package :gtk-test)

(def-suite gtk-print-settings :in gtk-suite)
(in-suite gtk-print-settings)

;;; --- Types and Values -------------------------------------------------------

;;;     GtkPrintSettings

(test print-settings-class
  ;; Type check
  (is (g:type-is-object "GtkPrintSettings"))
  ;; Check the registered name
  (is (eq 'gtk:print-settings
          (gobject:symbol-for-gtype "GtkPrintSettings")))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkPrintSettings")
          (g:gtype (cffi:foreign-funcall "gtk_print_settings_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GObject") (g:type-parent "GtkPrintSettings")))
  ;; Check the children
  (is (equal '()
             (list-children "GtkPrintSettings")))
  ;; Check the interfaces
  (is (equal '()
             (list-interfaces "GtkPrintSettings")))
  ;; Check the class properties
  (is (equal '()
             (list-properties "GtkPrintSettings")))
  ;; Check the signals
  (is (equal '()
             (list-signals "GtkPrintSettings")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GtkPrintSettings" GTK-PRINT-SETTINGS
                       (:SUPERCLASS G-OBJECT :EXPORT T :INTERFACES NIL
                        :TYPE-INITIALIZER "gtk_print_settings_get_type")
                       NIL)
             (gobject:get-g-type-definition "GtkPrintSettings"))))

;;;     GtkPageOrientation

(test page-orientation
  ;; Check the type
  (is-true (g:type-is-enum "GtkPageOrientation"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkPageOrientation")
          (g:gtype (cffi:foreign-funcall "gtk_page_orientation_get_type" :size))))
  ;; Check the registered name
  (is (eq 'gtk:page-orientation
          (gobject:symbol-for-gtype "GtkPageOrientation")))
  ;; Check the names
  (is (equal '("GTK_PAGE_ORIENTATION_PORTRAIT" "GTK_PAGE_ORIENTATION_LANDSCAPE"
               "GTK_PAGE_ORIENTATION_REVERSE_PORTRAIT"
               "GTK_PAGE_ORIENTATION_REVERSE_LANDSCAPE")
             (list-enum-item-name "GtkPageOrientation")))
  ;; Check the values
  (is (equal '(0 1 2 3)
             (list-enum-item-value "GtkPageOrientation")))
  ;; Check the nick names
  (is (equal '("portrait" "landscape" "reverse-portrait" "reverse-landscape")
             (list-enum-item-nick "GtkPageOrientation")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkPageOrientation"
                              GTK-PAGE-ORIENTATION
                              (:EXPORT T
                               :TYPE-INITIALIZER "gtk_page_orientation_get_type")
                              (:PORTRAIT 0)
                              (:LANDSCAPE 1)
                              (:REVERSE-PORTRAIT 2)
                              (:REVERSE-LANDSCAPE 3))
             (gobject:get-g-type-definition "GtkPageOrientation"))))

;;;     GtkPrintDuplex

(test print-duplex
  ;; Check the type
  (is-true (g:type-is-enum "GtkPrintDuplex"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkPrintDuplex")
          (g:gtype (cffi:foreign-funcall "gtk_print_duplex_get_type" :size))))
  ;; Check the registered name
  (is (eq 'gtk:print-duplex
          (gobject:symbol-for-gtype "GtkPrintDuplex")))
  ;; Check the names
  (is (equal '("GTK_PRINT_DUPLEX_SIMPLEX" "GTK_PRINT_DUPLEX_HORIZONTAL"
               "GTK_PRINT_DUPLEX_VERTICAL")
             (list-enum-item-name "GtkPrintDuplex")))
  ;; Check the values
  (is (equal '(0 1 2)
             (list-enum-item-value "GtkPrintDuplex")))
  ;; Check the nick names
  (is (equal '("simplex" "horizontal" "vertical")
             (list-enum-item-nick "GtkPrintDuplex")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkPrintDuplex"
                             GTK-PRINT-DUPLEX
                             (:EXPORT T
                              :TYPE-INITIALIZER "gtk_print_duplex_get_type")
                             (:SIMPLEX 0)
                             (:HORIZONTAL 1)
                             (:VERTICAL 2))
             (gobject:get-g-type-definition "GtkPrintDuplex"))))

;;;     GtkPrintQuality

(test gtk-print-quality
  ;; Check the type
  (is-true (g:type-is-enum "GtkPrintQuality"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkPrintQuality")
          (g:gtype (cffi:foreign-funcall "gtk_print_quality_get_type" :size))))
  ;; Check the registered name
  (is (eq 'gtk:print-quality
          (gobject:symbol-for-gtype "GtkPrintQuality")))
  ;; Check the names
  (is (equal '("GTK_PRINT_QUALITY_LOW" "GTK_PRINT_QUALITY_NORMAL"
               "GTK_PRINT_QUALITY_HIGH" "GTK_PRINT_QUALITY_DRAFT")
             (list-enum-item-name "GtkPrintQuality")))
  ;; Check the values
  (is (equal '(0 1 2 3)
             (list-enum-item-value "GtkPrintQuality")))
  ;; Check the nick names
  (is (equal '("low" "normal" "high" "draft")
             (list-enum-item-nick "GtkPrintQuality")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkPrintQuality"
                             GTK-PRINT-QUALITY
                             (:EXPORT T
                              :TYPE-INITIALIZER "gtk_print_quality_get_type")
                             (:LOW 0)
                             (:NORMAL 1)
                             (:HIGH 2)
                             (:DRAFT 3))
             (gobject:get-g-type-definition "GtkPrintQuality"))))

;;;     GtkNumberUpLayout

(test gtk-print-number-up-layout
  ;; Check the type
  (is-true (g:type-is-enum "GtkNumberUpLayout"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkNumberUpLayout")
          (g:gtype (cffi:foreign-funcall "gtk_number_up_layout_get_type" :size))))
  ;; Check the registered name
  (is (eq 'gtk:number-up-layout
          (gobject:symbol-for-gtype "GtkNumberUpLayout")))
  ;; Check the names
  (is (equal '("GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_TOP_TO_BOTTOM"
               "GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_BOTTOM_TO_TOP"
               "GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_TOP_TO_BOTTOM"
               "GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_BOTTOM_TO_TOP"
               "GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_LEFT_TO_RIGHT"
               "GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_RIGHT_TO_LEFT"
               "GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_LEFT_TO_RIGHT"
               "GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_RIGHT_TO_LEFT")
             (list-enum-item-name "GtkNumberUpLayout")))
  ;; Check the values
  (is (equal '(0 1 2 3 4 5 6 7)
             (list-enum-item-value "GtkNumberUpLayout")))
  ;; Check the nick names
  (is (equal '("lrtb" "lrbt" "rltb" "rlbt" "tblr" "tbrl" "btlr" "btrl")
             (list-enum-item-nick "GtkNumberUpLayout")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkNumberUpLayout"
                             GTK-NUMBER-UP-LAYOUT
                             (:EXPORT T
                              :TYPE-INITIALIZER "gtk_number_up_layout_get_type")
                             (:LRTB 0)
                             (:LRBT 1)
                             (:RLTB 2)
                             (:RLBT 3)
                             (:TBLR 4)
                             (:TBRL 5)
                             (:BTLR 6)
                             (:BTRL 7))
             (gobject:get-g-type-definition "GtkNumberUpLayout"))))

;;;     GtkPrintPages

(test print-pages
  ;; Check the type
  (is-true (g:type-is-enum "GtkPrintPages"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkPrintPages")
          (g:gtype (cffi:foreign-funcall "gtk_print_pages_get_type" :size))))
  ;; Check the registered name
  (is (eq 'gtk:print-pages
          (gobject:symbol-for-gtype "GtkPrintPages")))
  ;; Check the names
  (is (equal '("GTK_PRINT_PAGES_ALL" "GTK_PRINT_PAGES_CURRENT"
               "GTK_PRINT_PAGES_RANGES" "GTK_PRINT_PAGES_SELECTION")
             (list-enum-item-name "GtkPrintPages")))
  ;; Check the values
  (is (equal '(0 1 2 3)
             (list-enum-item-value "GtkPrintPages")))
  ;; Check the nick names
  (is (equal '("all" "current" "ranges" "selection")
             (list-enum-item-nick "GtkPrintPages")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkPrintPages"
                             GTK-PRINT-PAGES
                             (:EXPORT T
                              :TYPE-INITIALIZER "gtk_print_pages_get_type")
                             (:ALL 0)
                             (:CURRENT 1)
                             (:RANGES 2)
                             (:SELECTION 3))
             (gobject:get-g-type-definition "GtkPrintPages"))))

;;;     GtkPageRange (not implemented)

;;;     GtkPageSet

(test gtk-page-set
  ;; Check the type
  (is-true (g:type-is-enum "GtkPageSet"))
  ;; Check the type initializer
  (is (eq (g:gtype "GtkPageSet")
          (g:gtype (cffi:foreign-funcall "gtk_page_set_get_type" :size))))
  ;; Check the registered name
  (is (eq 'gtk:page-set
          (gobject:symbol-for-gtype "GtkPageSet")))
  ;; Check the names
  (is (equal '("GTK_PAGE_SET_ALL" "GTK_PAGE_SET_EVEN" "GTK_PAGE_SET_ODD")
             (list-enum-item-name "GtkPageSet")))
  ;; Check the values
  (is (equal '(0 1 2)
             (list-enum-item-value "GtkPageSet")))
  ;; Check the nick names
  (is (equal '("all" "even" "odd")
             (list-enum-item-nick "GtkPageSet")))
  ;; Check the enum definition
  (is (equal '(DEFINE-G-ENUM "GtkPageSet"
                             GTK-PAGE-SET
                             (:EXPORT T
                              :TYPE-INITIALIZER "gtk_page_set_get_type")
                             (:ALL 0)
                             (:EVEN 1)
                             (:ODD 2))
             (gobject:get-g-type-definition "GtkPageSet"))))

;;; --- Functions --------------------------------------------------------------

;;;     gtk_print_settings_new

(test print-settings-new
  (is (eql 'gtk:print-settings (type-of (gtk:print-settings-new)))))

;;;     gtk_print_settings_copy

(test print-settings-copy
  (let ((settings (gtk:print-settings-new)))
    (is (eq 'gtk:print-settings
            (type-of (gtk:print-settings-copy settings))))))

;;;     gtk_print_settings_has_key

(test print-settings-has-key
  (let ((settings (gtk:print-settings-new)))
    (is-false (gtk:print-settings-has-key settings "orientation"))
    (setf (gtk:print-settings-orientation settings) :landscape)
    (is-true (gtk:print-settings-has-key settings "orientation"))))

;;;     gtk_print_settings_get

(test print-settings-get
  (let ((settings (gtk:print-settings-new)))
    (is-false (gtk:print-settings-has-key settings "orientation"))
    (setf (gtk:print-settings-orientation settings) :landscape)
    (is-true (gtk:print-settings-has-key settings "orientation"))
    (is (string= "landscape" (gtk:print-settings-get settings "orientation")))))

;;;     gtk_print_settings_set

(test print-settings-set
  (let ((settings (gtk:print-settings-new)))
    (gtk:print-settings-set settings "orientation" "landscape")
    (is (string= "landscape" (gtk:print-settings-get settings "orientation")))
    (is (eq :landscape (gtk:print-settings-orientation settings)))
    ;; Unset the key "orientation"
    (is-false (gtk:print-settings-set settings "orientation" nil))
    (is-false (gtk:print-settings-has-key settings "orientation"))
    (is-false (gtk:print-settings-get settings "orientation"))))

;;;     gtk_print_settings_unset

(test print-settings-unset
  (let ((settings (gtk:print-settings-new)))
    (gtk:print-settings-set settings "orientation" "landscape")
    (is (equal "landscape" (gtk:print-settings-get settings "orientation")))
    (is (eql :landscape (gtk:print-settings-orientation settings)))
    (gtk:print-settings-unset settings "orientation")
    (is-false (gtk:print-settings-has-key settings "orientation"))))

;;;    gtk_print_settings_foreach

(defvar *settings* nil)

(defun do-print-settings-foreach (key value)
  (setf *settings*
        (concatenate 'string *settings* (format nil "~A : ~A~%" key value))))

(test print-settings-foreach
  (let* ((variant (g:variant-parse "a{sv}"
                                   "{'scale': <'100'>,
                                     'number-up': <'1'>,
                                     'n-copies': <'1'>,
                                     'page-ranges': <'0-11'>,
                                     'page-set': <'all'>,
                                     'output-uri': <'file:///home/dieter/Dokumente/Ausgabe.pdf'>,
                                     'printer': <'In Datei drucken'>,
                                     'print-pages': <'ranges'>,
                                     'reverse': <'false'>,
                                     'collate': <'false'>,
                                     'output-file-format': <'pdf'>}"))
         (settings (gtk:print-settings-new-from-gvariant variant)))
    (setf *settings* nil)
    (is-false (gtk:print-settings-foreach settings #'do-print-settings-foreach))
    (is (string= *settings*
"scale : 100
number-up : 1
n-copies : 1
page-ranges : 0-11
page-set : all
output-uri : file:///home/dieter/Dokumente/Ausgabe.pdf
printer : In Datei drucken
print-pages : ranges
reverse : false
collate : false
output-file-format : pdf
"))))

;;;    gtk_print_settings_get_bool
;;;    gtk_print_settings_set_bool

(test print-settings-bool
  (let ((settings (gtk:print-settings-new)))
    (is-true (setf (gtk:print-settings-bool settings "use-color") t))
    (is-true (gtk:print-settings-bool settings "use-color"))
    (is-false (setf (gtk:print-settings-bool settings "use-color") nil))
    (is-false (gtk:print-settings-bool settings "use-color"))))

;;;     gtk_print_settings_get_double
;;;     gtk_print_settings_get_double_with_default
;;;     gtk_print_settings_set_double

(test print-settings-double
  (let ((settings (gtk:print-settings-new)))
    (is (= 100 (setf (gtk:print-settings-double settings "paper-width")
                     100.0d0)))
    (is (= 100 (gtk:print-settings-double settings "paper-width")))
    (is (= 100
           (gtk:print-settings-double-with-default settings "paper-width" 90.0d0)))
    (is (=  90 (gtk:print-settings-double-with-default settings "xxx" 90.0d0)))))

;;;     gtk_print_settings_get_length
;;;     gtk_print_settings_set_length

(test print-settings-length
  (let ((settings (gtk:print-settings-new)))
    (is (=   0 (gtk:print-settings-length settings "paper-width" :mm)))
    (is (= 100 (setf (gtk:print-settings-length settings "paper-width" :mm)
                     100.0d0)))
    (is (= 100 (gtk:print-settings-length settings "paper-width" :mm)))
    (is (= 320 (setf (gtk:print-settings-length settings "paper-width" :points)
                     320.0d0)))
    (is (= 320 (gtk:print-settings-length settings "paper-width" :points)))
    (is (= 100 (setf (gtk:print-settings-length settings "paper-width" :inch)
                     100.0d0)))
    (is (= 100 (gtk:print-settings-length settings "paper-width" :inch)))))

;;;     gtk_print_settings_get_int
;;;     gtk_print_settings_get_int_with_default
;;;     gtk_print_settings_set_int

(test print-settings-int
  (let ((settings (gtk:print-settings-new)))
    (is (= 100 (setf (gtk:print-settings-int settings "paper-width") 100)))
    (is (= 100 (gtk:print-settings-int settings "paper-width")))
    (is (= 100 (gtk:print-settings-int-with-default settings "paper-width" 90)))
    (is (=  90 (gtk:print-settings-int-with-default settings "xxx" 90)))))

;;;     gtk_print_settings_get_printer
;;;     gtk_print_settings_set_printer

(test print-settings-printer
  (let ((settings (gtk:print-settings-new)))
    (setf (gtk:print-settings-printer settings) "printer")
    (is (string= "printer" (gtk:print-settings-printer settings)))))

;;;     gtk_print_settings_get_orientation
;;;     gtk_print_settings_set_orientation

(test print-settings-orientation
  (let ((settings (gtk:print-settings-new)))
    (setf (gtk:print-settings-orientation settings) :landscape)
    (is (eql :landscape (gtk:print-settings-orientation settings))
    (is (string= "landscape" (gtk:print-settings-get settings "orientation"))))))

;;;     gtk_print_settings_get_paper_size
;;;     gtk_print_settings_set_paper_size

(test print-settings-paper-size
  (let ((settings (gtk:print-settings-new)))
    (setf (gtk:print-settings-paper-size settings) (gtk:paper-size-new "iso_a4"))
    (is (eq 'gtk:paper-size (type-of (gtk:print-settings-paper-size settings))))))

;;;     gtk_print_settings_get_paper_width
;;;     gtk_print_settings_set_paper_width

(test print-settings-paper-width
  (let ((settings (gtk:print-settings-new)))
    (is (= 100 (setf (gtk:print-settings-paper-width settings :mm) 100.0d0)))
    (is (= 100 (gtk:print-settings-paper-width settings :mm)))
    (is (string= "100" (gtk:print-settings-get settings "paper-width")))))

;;;     gtk_print_settings_get_paper_height
;;;     gtk_print_settings_set_paper_height

(test print-settings-paper-height
  (let ((settings (gtk:print-settings-new)))
    (is (= 100 (setf (gtk:print-settings-paper-height settings :mm) 100.0d0)))
    (is (= 100 (gtk:print-settings-paper-height settings :mm)))
    (is (string= "100" (gtk:print-settings-get settings "paper-height")))))

;;;     gtk_print_settings_get_use_color
;;;     gtk_print_settings_set_use_color

(test print-settings-use-color.1
  (let ((settings (gtk:print-settings-new)))
    (is-true (setf (gtk:print-settings-use-color settings) t))
    (is-true (gtk:print-settings-use-color settings))
    (is (string= "true" (gtk:print-settings-get settings "use-color")))))

(test print-settings-use-color.2
  (let ((settings (gtk:print-settings-new)))
    (is-false (setf (gtk:print-settings-use-color settings) nil))
    (is-false (gtk:print-settings-use-color settings))
    (is (string= "false" (gtk:print-settings-get settings "use-color")))))

;;;     gtk_print_settings_get_collate
;;;     gtk_print_settings_set_collate

(test print-settings-collate
  (let ((settings (gtk:print-settings-new)))
    (is-true (gtk:print-settings-collate settings))
    (is-false (setf (gtk:print-settings-collate settings) nil))
    (is-false (gtk:print-settings-collate settings))
    (is (string= "false" (gtk:print-settings-get settings "collate")))
    (is-false (gtk:print-settings-set settings "collate" "true"))
    (is-true (gtk:print-settings-collate settings))))

;;;     gtk_print_settings_get_reverse
;;;     gtk_print_settings_set_reverse

(test print-settings-reverse
  (let ((settings (gtk:print-settings-new)))
    (is-false (gtk:print-settings-reverse settings))
    (is-true (setf (gtk:print-settings-reverse settings) t))
    (is-true (gtk:print-settings-reverse settings))
    (is (string= "true" (gtk:print-settings-get settings "reverse")))
    (is-false (gtk:print-settings-set settings "reverse" "false"))
    (is-false (gtk:print-settings-reverse settings))))

;;;     gtk_print_settings_get_duplex
;;;     gtk_print_settings_set_duplex

(test print-settings-duplex
  (let ((settings (gtk:print-settings-new)))
    (is (eq :simplex (gtk:print-settings-duplex settings)))
    (is (eq :horizontal (setf (gtk:print-settings-duplex settings) :horizontal)))
    (is (eq :horizontal (gtk:print-settings-duplex settings)))
    (is (string= "horizontal" (gtk:print-settings-get settings "duplex")))
    (is-false (gtk:print-settings-set settings "duplex" "vertical"))
    (is (eq :vertical (gtk:print-settings-duplex settings)))))

;;;     gtk_print_settings_get_quality
;;;     gtk_print_settings_set_quality

(test print-settings-quality
  (let ((settings (gtk:print-settings-new)))
    (is (eq :normal (gtk:print-settings-quality settings)))
    (is (eq :low (setf (gtk:print-settings-quality settings) :low)))
    (is (eq :low (gtk:print-settings-quality settings)))
    (is (string= "low" (gtk:print-settings-get settings "quality")))
    (is-false (gtk:print-settings-set settings "quality" "high"))
    (is (eq :high (gtk:print-settings-quality settings)))))

;;;     gtk_print_settings_get_n_copies
;;;     gtk_print_settings_set_n_copies

(test print-settings-n-copies
  (let ((settings (gtk:print-settings-new)))
    (is (= 1 (gtk:print-settings-n-copies settings)))
    (is (= 200 (setf (gtk:print-settings-n-copies settings) 200)))
    (is (= 200 (gtk:print-settings-n-copies settings)))
    (is (string= "200" (gtk:print-settings-get settings "n-copies")))
    (is-false (gtk:print-settings-set settings "n-copies" "300"))
    (is (= 300 (gtk:print-settings-n-copies settings)))))

;;;     gtk_print_settings_get_number_up
;;;     gtk_print_settings_set_number_up

(test print-settings-number-up
  (let ((settings (gtk:print-settings-new)))
    (is (= 1 (gtk:print-settings-number-up settings)))
    (is (= 200 (setf (gtk:print-settings-number-up settings) 200)))
    (is (= 200 (gtk:print-settings-number-up settings)))
    (is (string= "200" (gtk:print-settings-get settings "number-up")))
    (is-false (gtk:print-settings-set settings "number-up" "300"))
    (is (= 300 (gtk:print-settings-number-up settings)))))

;;;     gtk_print_settings_get_number_up_layout
;;;     gtk_print_settings_set_number_up_layout

(test print-settings-number-up-layout
  (let ((settings (gtk:print-settings-new)))
    (is (eq :LEFT-TO-RIGHT-TOP-TO-BOTTOM
            (gtk:print-settings-number-up-layout settings)))
    (is (eq :bottom-to-top-right-to-left
            (setf (gtk:print-settings-number-up-layout settings)
                  :bottom-to-top-right-to-left)))
    (is (eq :bottom-to-top-right-to-left
            (gtk:print-settings-number-up-layout settings)))
    (is (string= "btrl" (gtk:print-settings-get settings "number-up-layout")))
    (is-false (gtk:print-settings-set settings "number-up-layout" "lrtp"))
    (is (eq :LEFT-TO-RIGHT-TOP-TO-BOTTOM
            (gtk:print-settings-number-up-layout settings)))))

;;;     gtk_print_settings_get_resolution
;;;     gtk_print_settings_set_resolution

(test print-settings-resolution
  (let ((settings (gtk:print-settings-new)))
    (is (= 300 (gtk:print-settings-resolution settings)))
    (is (= 200 (setf (gtk:print-settings-resolution settings) 200)))
    (is (= 200 (gtk:print-settings-resolution settings)))
    (is (string= "200" (gtk:print-settings-get settings "resolution")))
    (is-false (gtk:print-settings-set settings "resolution" "300"))
    (is (= 300 (gtk:print-settings-resolution settings)))))

;;;     gtk_print_settings_set_resolution_xy
;;;     gtk_print_settings_get_resolution_x
;;;     gtk_print_settings_get_resolution_y

(test print-settings-resolution-xy
  (let ((settings (gtk:print-settings-new)))
    (is (= 300 (gtk:print-settings-resolution-x settings)))
    (is (= 300 (gtk:print-settings-resolution-y settings)))))

;;;     gtk_print_settings_get_printer_lpi
;;;     gtk_print_settings_set_printer_lpi

(test print-settings-printer-lpi
  (let ((settings (gtk:print-settings-new)))
    (is (= 150.0d0 (gtk:print-settings-printer-lpi settings)))
    (is (= 200 (setf (gtk:print-settings-printer-lpi settings) 200.0)))
    (is (= 200 (gtk:print-settings-printer-lpi settings)))
    (is (string= "200" (gtk:print-settings-get settings "printer-lpi")))
    (is-false (gtk:print-settings-set settings "printer-lpi" "300"))
    (is (= 300 (gtk:print-settings-printer-lpi settings)))))

;;;     gtk_print_settings_get_scale
;;;     gtk_print_settings_set_scale

(test print-settings-scale
  (let ((settings (gtk:print-settings-new)))
    (is (= 100.0d0 (gtk:print-settings-scale settings)))
    (is (= 10 (setf (gtk:print-settings-scale settings) 10.0)))
    (is (= 10 (gtk:print-settings-scale settings)))
    (is (string= "10" (gtk:print-settings-get settings "scale")))
    (is-false (gtk:print-settings-set settings "scale" "20"))
    (is (= 20 (gtk:print-settings-scale settings)))))

;;;     gtk_print_settings_get_print_pages
;;;     gtk_print_settings_set_print_pages

(test print-settings-print-pages
  (let ((settings (gtk:print-settings-new)))
    (is (eq :all (gtk:print-settings-print-pages settings)))
    (is (eq :current (setf (gtk:print-settings-print-pages settings) :current)))
    (is (eq :current (gtk:print-settings-print-pages settings)))
    (is (string= "current" (gtk:print-settings-get settings "print-pages")))
    (is-false (gtk:print-settings-set settings "print-pages" "current"))
    (is (eq :current (gtk:print-settings-print-pages settings)))))

;;;     gtk_print_settings_get_page_ranges
;;;     gtk_print_settings_set_page_ranges

(test print-settings-page-ranges
  (let ((settings (gtk:print-settings-new)))
    (is (equal '((1) (15 20) (25))
               (setf (gtk:print-settings-page-ranges settings)
                     '((1) (15 20) (25)))))
    (is (string= "1,15-20,25" (gtk:print-settings-get settings "page-ranges")))
    (is (equal '((1) (15 20) (25)) (gtk:print-settings-page-ranges settings)))))

;;;     gtk_print_settings_get_page_set
;;;     gtk_print_settings_set_page_set

(test print-settings-page-set
  (let ((settings (gtk:print-settings-new)))
    (is (eq :all (gtk:print-settings-page-set settings)))
    (is (eq :even (setf (gtk:print-settings-page-set settings) :even)))
    (is (eq :even (gtk:print-settings-page-set settings)))
    (is (string= "even" (gtk:print-settings-get settings "page-set")))
    (is-false (gtk:print-settings-set settings "page-set" "odd"))
    (is (eq :odd (gtk:print-settings-page-set settings)))))

;;;     gtk_print_settings_get_default_source
;;;     gtk_print_settings_set_default_source

(test print-settings-default-source
  (let ((settings (gtk:print-settings-new)))
    (is-false (gtk:print-settings-default-source settings))
    (is (string= "test"
                 (setf (gtk:print-settings-default-source settings) "test")))
    (is (string= "test" (gtk:print-settings-default-source settings)))
    (is (string= "test" (gtk:print-settings-get settings "default-source")))
    (is-false (gtk:print-settings-set settings "default-source" "test2"))
    (is (string= "test2" (gtk:print-settings-default-source settings)))))

;;;     gtk_print_settings_get_media_type
;;;     gtk_print_settings_set_media_type

(test print-settings-media-type
  (let ((settings (gtk:print-settings-new)))
    (is-false (gtk:print-settings-media-type settings))
    (is (string= "test" (setf (gtk:print-settings-media-type settings) "test")))
    (is (string= "test" (gtk:print-settings-media-type settings)))
    (is (string= "test" (gtk:print-settings-get settings "media-type")))))

;;;     gtk_print_settings_get_dither
;;;     gtk_print_settings_set_dither

(test print-settings-dither
  (let ((settings (gtk:print-settings-new)))
    (is-false (gtk:print-settings-dither settings))
    (is (string= "test" (setf (gtk:print-settings-dither settings) "test")))
    (is (string= "test" (gtk:print-settings-dither settings)))
    (is (string= "test" (gtk:print-settings-get settings "dither")))))

;;;     gtk_print_settings_get_finishings
;;;     gtk_print_settings_set_finishings

(test print-settings-finishings
  (let ((settings (gtk:print-settings-new)))
    (is-false (gtk:print-settings-finishings settings))
    (is (string= "test" (setf (gtk:print-settings-finishings settings) "test")))
    (is (string= "test" (gtk:print-settings-finishings settings)))
    (is (string= "test" (gtk:print-settings-get settings "finishings")))))

;;;     gtk_print_settings_get_output_bin
;;;     gtk_print_settings_set_output_bin

(test print-settings-output-bin
  (let ((settings (gtk:print-settings-new)))
    (is-false (gtk:print-settings-output-bin settings))
    (is (string= "test" (setf (gtk:print-settings-output-bin settings) "test")))
    (is (string= "test" (gtk:print-settings-output-bin settings)))
    (is (string= "test" (gtk:print-settings-get settings "output-bin")))))

;;;     gtk_print_settings_new_from_file
;;;     gtk_print_settings_load_file
;;;     gtk_print_settings_to_file

(test print-settings-file
  (let* ((path (sys-path "resource/rtest-gtk3-print-settings.ini"))
         (settings (gtk:print-settings-new-from-file path)))
    (is-true (gtk:print-settings-to-file settings path))
    (is-true (gtk:print-settings-load-file settings path))
    (is (typep (gtk:print-settings-new-from-file path) 'gtk:print-settings))))

;;;     gtk_print_settings_new_from_key_file
;;;     gtk_print_settings_load_key_file
;;;     gtk_print_settings_to_key_file

(test print-settings-key-file
  (let* ((path (sys-path "resource/rtest-gtk3-print-settings.ini"))
         (settings (gtk:print-settings-new-from-file path))
         (keyfile (g:key-file-new)))
    (is-false (gtk:print-settings-to-key-file settings
                                              keyfile
                                              "Print Settings"))
    (is-true (gtk:print-settings-load-key-file settings keyfile "Print Settings"))
    (is (typep (gtk:print-settings-new-from-key-file keyfile "Print Settings")
                'gtk:print-settings))))

;;;     gtk_print_settings_new_from_gvariant
;;;     gtk_print_settings_to_gvariant

(test print-settings-gvariant
  (let* ((path (sys-path "resource/rtest-gtk3-print-settings.ini"))
        (settings (gtk:print-settings-new-from-file path)))
    (is (string= (g:variant-print (gtk:print-settings-to-gvariant settings) nil)
"{'scale': <'100'>, 'number-up': <'1'>, 'n-copies': <'1'>, 'page-ranges': <'0-11'>, 'page-set': <'all'>, 'output-uri': <'file:///home/dieter/Dokumente/Ausgabe.pdf'>, 'printer': <'In Datei drucken'>, 'print-pages': <'ranges'>, 'reverse': <'false'>, 'collate': <'false'>, 'output-file-format': <'pdf'>}"
))
    (let ((variant (g:variant-parse "a{sv}"
"{'scale': <'100'>, 'number-up': <'1'>, 'n-copies': <'1'>, 'page-ranges': <'0-11'>, 'page-set': <'all'>, 'output-uri': <'file:///home/dieter/Dokumente/Ausgabe.pdf'>, 'printer': <'In Datei drucken'>, 'print-pages': <'ranges'>, 'reverse': <'false'>, 'collate': <'false'>, 'output-file-format': <'pdf'>}"
)))
      (is (eq 'gtk:print-settings (type-of (gtk:print-settings-new-from-gvariant variant)))))))

;;; --- 2023-1-29 --------------------------------------------------------------
