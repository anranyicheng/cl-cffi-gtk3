;;; ----------------------------------------------------------------------------
;;; gtk-demo.lisp
;;;
;;; Copyright (C) 2013 - 2023 Dieter Kaiser
;;;
;;; This program is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU Lesser General Public License for Lisp
;;; as published by the Free Software Foundation, either version 3 of the
;;; License, or (at your option) any later version and with a preamble to
;;; the GNU Lesser General Public License that clarifies the terms for use
;;; with Lisp programs and is referred as the LLGPL.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU Lesser General Public License for more details.
;;;
;;; You should have received a copy of the GNU Lesser General Public
;;; License along with this program and the preamble to the Gnu Lesser
;;; General Public License.  If not, see <http://www.gnu.org/licenses/>
;;; and <http://opensource.franz.com/preamble.html>.
;;; ----------------------------------------------------------------------------

(in-package :gtk3-demo)

;;; ----------------------------------------------------------------------------

(defvar info-buffer (make-instance 'gtk:text-buffer))
(defvar source-buffer (make-instance 'gtk:text-buffer))
(defvar ui-buffer (make-instance 'gtk:text-buffer))
(defvar css-buffer (make-instance 'gtk:text-buffer))

;;; ----------------------------------------------------------------------------

;; Get the pathname for a file
(defun sys-path (filename &optional (system :cl-cffi-gtk3))
  (asdf:system-relative-pathname system filename))

(defun clear-buffer (buffer)
  (multiple-value-bind (start end)
      (gtk:text-buffer-bounds buffer)
    (gtk:text-buffer-delete buffer start end)))

(defun load-file (filename)
  (with-open-file (stream filename)
    ;; Read the info-header of the file
    (clear-buffer info-buffer)
    (do ((line (read-line stream nil)
               (read-line stream nil)))
        ((or (null line)
             (not (>= (length line) 4))
             (not (string= line ";;;;" :start1 0 :end1 4))))
      (gtk:text-buffer-insert info-buffer (string-left-trim ";" line))
      (gtk:text-buffer-insert info-buffer (format nil "~%")))
    ;; Read the source code of the file
    (clear-buffer source-buffer)
    (do ((line (read-line stream nil)
               (read-line stream nil)))
        ((null line))
      (gtk:text-buffer-insert source-buffer line)
      (gtk:text-buffer-insert source-buffer (format nil "~%")))))

(defun load-file-buffer (buffer filename)
  (with-open-file (stream filename)
    (clear-buffer buffer)
    (do ((line (read-line stream nil)
               (read-line stream nil)))
        ((null line))
      (gtk:text-buffer-insert buffer line)
      (gtk:text-buffer-insert buffer (format nil "~%")))))

(defun read-file (filename)
  (with-open-file (instream filename :direction :input :if-does-not-exist nil)
    (when instream
      (let ((string (make-string (file-length instream))))
        (read-sequence string instream)
        string))))

;;; ----------------------------------------------------------------------------

(defun create-text (buffer is-source)
  (let* ((scrolled (make-instance 'gtk:scrolled-window
                                  :hscrollbar-policy :automatic
                                  :vscrollbar-policy :automatic))
         (view (make-instance 'gtk:text-view
                              :buffer buffer
                              :editable nil
                              :cursor-visible nil)))
    (gtk:container-add scrolled view)
    (when is-source
      (gtk:widget-override-font view
                                (pango:font-description-from-string "monospace")))
    ;; return the scrolled window
    scrolled))

;;; ----------------------------------------------------------------------------

(defparameter id-title 0)
(defparameter id-package 1)
(defparameter id-file 2)
(defparameter id-func 3)
(defparameter id-app 4)
(defparameter id-ui 5)
(defparameter id-css 6)

(defparameter *tree-model*
   '(("gchararray"        ; Title
      "gchararray"        ; Package
      "gchararray"        ; Filename
      "gchararray"        ; Function name
      "gboolean"          ; Application as argument
      "gchararray"        ; UI Definition
      "gchararray")       ; CSS Definition

     "Theming in GTK"
     (("CSS Accordion"
       "gtk3-example"
       "css-accordion.lisp"
       "EXAMPLE-CSS-ACCORDION"
       t
       ""
       "css-accordion.css")
      ("CSS Basics"
       "gtk3-example"
       "css-basics.lisp"
       "EXAMPLE-CSS-BASICS"
       t
       ""
       "css-basics.css")
      ("CSS Blend Modes"
       "gtk3-example"
       "css-blendmodes.lisp"
       "EXAMPLE-CSS-BLENDMODES"
       t
       "css-blendmodes.ui"
       "css-blendmodes.css")
      ("CSS Multiple Backgrounds"
       "gtk3-example"
       "css-multiplebgs.lisp"
       "EXAMPLE-CSS-MULTIPLEBGS"
       t
       ""
       "css-multiplebgs.css")
      ("CSS Pixbufs"
       "gtk3-example"
       "css-pixbufs.lisp"
       "EXAMPLE-CSS-PIXBUFS"
       t
       ""
       "css-pixbufs.css")
      ("CSS Shadows"
       "gtk3-example"
       "css-shadows.lisp"
       "EXAMPLE-CSS-SHADOWS"
       t
       ""
       "css-shadows.css")
      ("Custom Drawing"
       "gtk3-example"
       "custom-drawing.lisp"
       "EXAMPLE-CUSTOM-DRAWING"
       t))

     "Windows"
     (("Simple Window"
       "gtk3-example"
       "window-simple-demo.lisp"
       "EXAMPLE-WINDOW-SIMPLE-DEMO"
       t)
      ("Message Dialog"
       "gtk3-example"
       "message-dialog-simple.lisp"
       "EXAMPLE-MESSAGE-DIALOG-SIMPLE"
       t)
      ("Dialog Windows"
       "gtk3-example"
       "dialog.lisp"
       "EXAMPLE-DIALOGS"
       t)
      ("Assistant"
       "gtk3-example"
       "assistant.lisp"
       "EXAMPLE-ASSISTANT"
       t))

     "Layout Containers"
     (("Simple Box"
       "gtk3-example"
       "box-simple.lisp"
       "EXAMPLE-BOX-SIMPLE"
       t)
      ("Box packing"
       "gtk3-example"
       "box-packing.lisp"
       "EXAMPLE-BOX-PACKING"
       t)
      ("Simple Grid"
       "gtk3-example"
       "grid-simple.lisp"
       "EXAMPLE-GRID-SIMPLE"
       t)
      ("Grid with spacing"
       "gtk3-example"
       "grid-spacing.lisp"
       "EXAMPLE-GRID-SPACING"
       t)
      ("Grid packing"
       "gtk3-example"
       "grid-packing.lisp"
       "EXAMPLE-GRID-PACKING"
       t)
      ("Revealer"
       "gtk3-example"
       "revealer.lisp"
       "EXAMPLE-REVEALER"
       t)
      ("Revealer Icon"
       "gtk3-example"
       "revealer-icon.lisp"
       "EXAMPLE-REVEALER-ICON"
       t
       "revealer-icon.ui")
      ("List Box"
       "gtk3-example"
       "list-box.lisp"
       "EXAMPLE-LIST-BOX"
       t
       "list-box.ui")
      ("Flow Box"
       "gtk3-example"
       "flow-box.lisp"
       "EXAMPLE-FLOW-BOX"
       t)
      ("Stack"
       "gtk3-example"
       "stack.lisp"
       "EXAMPLE-STACK"
       t)
      ("Stack Sidebar"
       "gtk3-example"
       "stack-sidebar.lisp"
       "EXAMPLE-STACK-SIDEBAR"
       t)
      ("Action Bar"
       "gtk3-example"
       "action-bar.lisp"
       "EXAMPLE-ACTION-BAR"
       t)
      ("Header Bar"
       "gtk3-example"
       "header-bar.lisp"
       "EXAMPLE-HEADER-BAR"
       t)
      ("Overlay Interactive"
       "gtk3-example"
       "overlay-interactive.lisp"
       "EXAMPLE-OVERLAY-INTERACTIVE"
       t)
      ("Overlay Decorative"
       "gtk3-example"
       "overlay-decorative.lisp"
       "EXAMPLE-OVERLAY-DECORATIVE"
       t)
      ("Button Boxes"
       "gtk3-example"
       "button-box.lisp"
       "EXAMPLE-BUTTON-BOX"
       t)
      ("Paned Window"
       "gtk3-example"
       "paned-window.lisp"
       "EXAMPLE-PANED-WINDOW"
       t)
      ("Notebook"
       "gtk3-example"
       "notebook.lisp"
       "EXAMPLE-NOTEBOOK"
       t)
      ("Expander"
       "gtk3-example"
       "expander.lisp"
       "CREATE-EXPANDER-DIALOG"
       nil)
      ("Aspect Frame"
       "gtk3-example"
       "aspect-frame.lisp"
       "EXAMPLE-ASPECT-FRAME"
       t)
      ("Fixed Container"
       "gtk3-example"
       "fixed.lisp"
       "EXAMPLE-FIXED"
       t))

     ;; Display Widgets
     "Display Widgets"
     (("Labels"
       "gtk3-example"
       "label.lisp"
       "EXAMPLE-LABEL"
       t)
      ("More Labels"
       "gtk3-example"
       "label-more.lisp"
       "EXAMPLE-LABEL-MORE"
       t)
      ("Images"
       "gtk3-example"
       "image.lisp"
       "EXAMPLE-IMAGE"
       t)
      ("Spinner"
       "gtk3-example"
       "spinner.lisp"
       "EXAMPLE-SPINNER"
       t)
      ("Info Bar"
       "gtk3-example"
       "info-bar.lisp"
       "EXAMPLE-INFO-BAR"
       t)
      ("Progress Bar"
       "gtk3-example"
       "progress-bar.lisp"
       "EXAMPLE-PROGRESS-BAR"
       t)
      ("Level Bar"
       "gtk3-example"
       "level-bar.lisp"
       "EXAMPLE-LEVEL-BAR"
       t)
      ("Statusbar"
       "gtk3-example"
       "statusbar.lisp"
       "EXAMPLE-STATUSBAR"
       t))

     "Button and Toggle Widgets"
     (("Simple Button"
       "gtk3-example"
       "button-image.lisp"
       "EXAMPLE-BUTTON-IMAGE")
      ("More Buttons"
       "gtk3-example"
       "button-more.lisp"
       "EXAMPLE-BUTTON-MORE")
      ("Toggle Buttons"
       "gtk3-example"
       "toggle-buttons.lisp"
       "EXAMPLE-TOGGLE-BUTTONS")
      ("Link Button"
       "gtk3-example"
       "link-button.lisp"
       "EXAMPLE-LINK-BUTTON")
      ("Switch"
       "gtk3-example"
       "switch.lisp"
       "EXAMPLE-SWITCH")
      ("Scale Button"
       "gtk3-example"
       "scale-button.lisp"
       "EXAMPLE-SCALE-BUTTON"))

     "Numeric/Text Data Entry"
     (("Text Entry"
       "gtk3-example"
       "text-entry.lisp"
       "EXAMPLE-TEXT-ENTRY")
      ("Text Entry Buffer"
       "gtk3-example"
       "text-entry-buffer.lisp"
       "EXAMPLE-TEXT-ENTRY-BUFFER")
      ("Text Entry Completion"
       "gtk3-example"
       "text-entry-completion.lisp"
       "EXAMPLE-TEXT-ENTRY-COMPLETION")
      ("Scale Widget"
       "gtk3-example"
       "scale-widget.lisp"
       "EXAMPLE-SCALE-WIDGET")
      ("Spin Button"
       "gtk3-example"
       "spin-button.lisp"
       "EXAMPLE-SPIN-BUTTON"))

     "Multiline Text Editor"
     (("Simple Text View"
       "gtk3-example"
       "text-view-simple.lisp"
       "EXAMPLE-TEXT-VIEW-SIMPLE")
      ("Text View Attributes"
       "gtk3-example"
       "text-view-attributes.lisp"
       "EXAMPLE-TEXT-VIEW-ATTRIBUTES")
      ("Text View Tags"
       "gtk3-example"
       "text-view-tags.lisp"
       "EXAMPLE-TEXT-VIEW-TAGS")
      ("Text View Search"
       "gtk3-example"
       "text-view-find-next.lisp"
       "EXAMPLE-TEXT-VIEW-FIND-NEXT")
      ("Text View Insert"
       "gtk3-example"
       "text-view-insert.lisp"
       "EXAMPLE-TEXT-VIEW-INSERT")
      ("Text View Insert Image"
       "gtk3-example"
       "text-view-insert-image.lisp"
       "EXAMPLE-TEXT-VIEW-INSERT-IMAGE")
      ("Text View Insert Widget"
       "gtk3-example"
       "text-view-insert-widget.lisp"
       "EXAMPLE-TEXT-VIEW-INSERT-WIDGET")
      ("Text View Tooltip"
       "gtk3-example"
       "text-view-tooltip.lisp"
       "EXAMPLE-TEXT-VIEW-TOOLTIP"))

     "Tree, List and Icon Grid Widgets"
     (("Simple Tree View"
       "gtk3-example"
       "tree-view-simple.lisp"
       "EXAMPLE-TREE-VIEW-SIMPLE")
      ("Tree View Path"
       "gtk3-example"
       "tree-view-path.lisp"
       "EXAMPLE-TREE-VIEW-PATH")
      ("Tree View Content Type"
       "gtk3-example"
       "tree-view-content-type.lisp"
       "EXAMPLE-TREE-VIEW-CONTENT-TYPE")
      ("Icon View"
       "gtk3-example"
       "icon-view.lisp"
       "EXAMPLE-ICON-VIEW"))

     "Menus, Combo Box, Toolbar"
     (("Combo Box"
       "gtk3-example"
       "combo-box.lisp"
       "EXAMPLE-COMBO-BOX")
      ("Combo Box Text"
       "gtk3-example"
       "combo-box-text.lisp"
       "EXAMPLE-COMBO-BOX-TEXT")
      ("Menu"
       "gtk3-example"
       "menu.lisp"
       "EXAMPLE-MENU"
       t)
      ("Menu Item with Image and Accel"
       "gtk3-example"
       "menu-item.lisp"
       "EXAMPLE-MENU-ITEM"
       t)
      ("Menu Popup"
       "gtk3-example"
       "menu-popup.lisp"
       "EXAMPLE-MENU-POPUP"
       t)
      ("Tool Palette"
       "gtk3-example"
       "tool-palette.lisp"
       "EXAMPLE-TOOL-PALETTE")
      ("Popover"
       "gtk3-example"
       "popover.lisp"
       "EXAMPLE-POPOVER"
       t
       "popover.ui"))

     "Selectors (Color/File/Font)"
     (("Color Button"
       "gtk3-example"
       "color-button.lisp"
       "EXAMPLE-COLOR-BUTTON")
      ("Color Button Label"
       "gtk3-example"
       "color-button-label.lisp"
       "EXAMPLE-COLOR-BUTTON-LABEL")
      ("Color Chooser Widget"
       "gtk3-example"
       "color-chooser-widget.lisp"
       "EXAMPLE-COLOR-CHOOSER-WIDGET"
       t)
      ("Color Chooser Dialog"
       "gtk3-example"
       "color-chooser-dialog.lisp"
       "EXAMPLE-COLOR-CHOOSER-DIALOG")
      ("Color Chooser Palette"
       "gtk3-example"
       "color-chooser-palette.lisp"
       "EXAMPLE-COLOR-CHOOSER-PALETTE"
      t)
      ("File Chooser Button"
       "gtk3-example"
       "file-chooser-button.lisp"
       "EXAMPLE-FILE-CHOOSER-BUTTON")
      ("File Chooser Dialog"
       "gtk3-example"
       "file-chooser-dialog.lisp"
       "CREATE-FILE-CHOOSER-DIALOG")
      ("File Chooser Preview"
       "gtk3-example"
       "file-chooser-preview.lisp"
       "CREATE-FILE-CHOOSER-PREVIEW")
      ("File Chooser Widget"
       "gtk3-example"
       "file-chooser-widget.lisp"
       "CREATE-FILE-CHOOSER-WIDGET")
      ("File Chooser Custom Filter"
       "gtk3-example"
       "file-chooser-custom-filter.lisp"
       "CREATE-FILE-CHOOSER-CUSTOM-FILTER")
      ("Font Button"
       "gtk3-example"
       "font-button.lisp"
       "EXAMPLE-FONT-BUTTON")
      ("Font Button Label"
       "gtk3-example"
       "font-button-label.lisp"
       "EXAMPLE-FONT-BUTTON-LABEL"
       t))

     ;; Ornaments
     "Ornaments"
     (("Frame Widget"
       "gtk3-example"
       "frame.lisp"
       "EXAMPLE-FRAME")
      ("Frame Properties"
       "gtk3-example"
       "frame-properties.lisp"
       "EXAMPLE-FRAME-PROPERTIES"
       t))

     ;; Scrolling
     "Scrolling"
     (("Scrolled Window"
       "gtk3-example"
       "scrolled-window.lisp"
       "EXAMPLE-SCROLLED-WINDOW"))

     ;; Printing
     "Printing"
     (("Page Setup Dialog"
       "gtk3-example"
       "page-setup-dialog.lisp"
       "CREATE-PAGE-SETUP-DIALOG")
      ("Print Dialog"
       "gtk3-example"
       "print-dialog.lisp"
       "CREATE-PRINT-DIALOG")
      ("Print Operation"
       "gtk3-example"
       "print-operation.lisp"
       "DO-PRINT-OPERATION"))

     ;; Drag and Drop, Clipboard
     "Drag and Drop, Clipboard"
     (("Drag and Drop Simple"
       "gtk3-example"
       "drag-and-drop-simple.lisp"
       "EXAMPLE-DRAG-AND-DROP-SIMPLE")
      ("Drag and Drop with Action"
       "gtk3-example"
       "drag-and-drop-action.lisp"
       "EXAMPLE-DRAG-AND-DROP-ACTION")
      ("Clipboard"
       "gtk3-example"
       "clipboard.lisp"
       "EXAMPLE-CLIPBOARD"
       t))

     ;; Cairo demos
     "Cairo"
     #+nil
     (("Cairo Stroke"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-STROKE")
      ("Cairo Fill"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-FILL")
      ("Cairo Text"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-TEXT")
      ("Cairo Paint"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-PAINT")
      ("Cairo Mask"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-MASK")
      ("Cairo Source RGBA"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-SET-SOURCE-RGBA")
      ("Cairo Source Gradient"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-SET-SOURCE-GRADIENT")
      ("Cairo Path"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-PATH")
      ("Cairo Dash"
       "cairo-demo"
       "cairo-demo.lisp"
       "DEMO-CAIRO-DASH")
      ("Cairo Clock"
       "cairo-demo"
       "cairo-clock.lisp"
       "DEMO-CAIRO-CLOCK"))

     "Miscellaneous"
     (("Drawing Area"
       "gtk3-example"
       "drawing-area.lisp"
       "EXAMPLE-DRAWING-AREA"
       t)
      ("Drawing in response to input"
       "gtk3-example"
       "drawing-area-input.lisp"
       "EXAMPLE-DRAWING-AREA-INPUT")
      ("Calendar"
       "gtk3-example"
       "calendar.lisp"
       "EXAMPLE-CALENDAR")
      ("Cursor"
       "gtk3-example"
       "cursor.lisp"
       "EXAMPLE-CURSOR"
       t)
      ("Event Box"
       "gtk3-example"
       "event-box.lisp"
       "EXAMPLE-EVENT-BOX")
      ("Example Pixbufs"
       "gtk3-example"
       "pixbufs.lisp"
       "EXAMPLE-PIXBUFS"
       t)
      ("Emblemed Icons"
       "gio-example"
       "emblemed-icon.lisp"
       "EXAMPLE-EMBLEMED-ICON")
      ("Align Widget"
       "gtk3-example"
       "widget-align.lisp"
       "EXAMPLE-WIDGET-ALIGN"))

     ;; Examples from the tutorial
     "GTK 3 Tutorial for Lisp"
      ;; Chapter: Getting started
      ("Chapter: Getting started"
       (("Simple Window"
         "gtk3-example"
         "window-simple.lisp"
         "EXAMPLE-WINDOW-SIMPLE")
        ("Getting started"
         "gtk3-example"
         "getting-started.lisp"
         "EXAMPLE-GETTING-STARTED")
        ("Hello World"
         "gtk3-example"
         "hello-world.lisp"
         "EXAMPLE-HELLO-WORLD")
        ("Hello World Upgraded"
         "gtk3-example"
         "hello-world-upgraded.lisp"
         "EXAMPLE-HELLO-WORLD-UPGRADED")
        ("Hello World Upgraded (more Lisp like)"
         "gtk3-example"
         "hello-world-upgraded-2.lisp"
         "EXAMPLE-HELLO-WORLD-UPGRADED-2")
        ("Drawing in response to input"
         "gtk3-example"
         "drawing-area-input.lisp"
         "EXAMPLE-DRAWING-AREA-INPUT")))

      ;; Chapter: Packing Widgets
      ("Chapter: Packing Widgets"
       (("Simple Box"
         "gtk3-example"
         "box-simple.lisp"
         "EXAMPLE-BOX-SIMPLE"
         t)
        ("Box Packing"
         "gtk3-example"
         "box-packing.lisp"
         "EXAMPLE-BOX-PACKING")
        ("Simple Grid"
         "gtk3-example"
         "grid-simple.lisp"
         "EXAMPLE-GRID-SIMPLE")
        ("Simple Grid more Spacing"
         "gtk3-example"
         "grid-spacing.lisp"
         "EXAMPLE-GRID-SPACING")
        ("Packing using GtkGrid"
         "gtk3-example"
         "grid-packing.lisp"
         "EXAMPLE-GRID-PACKING")))

      ;; Chapter: Button Widgets
      ("Chapter: Button Widgets"
       (("Simple Button"
         "gtk3-example"
         "button-image.lisp"
         "EXAMPLE-BUTTON-IMAGE")
        ("More Buttons"
         "gtk3-example"
         "button-more.lisp"
         "EXAMPLE-BUTTON-MORE")
        ("Radio Button"
         "gtk3-example"
         "radio-button.lisp"
         "EXAMPLE-RADIO-BUTTON")
        ("Toggle Buttons"
         "gtk3-example"
         "toggle-buttons.lisp"
         "EXAMPLE-TOGGLE-BUTTONS")
        ("Link Button"
         "gtk3-example"
         "link-button.lisp"
         "EXAMPLE-LINK-BUTTON")
        ("Switch"
         "gtk3-example"
         "switch.lisp"
         "EXAMPLE-SWITCH")
        ("Scale Button"
         "gtk3-example"
         "scale-button.lisp"
         "EXAMPLE-SCALE-BUTTON")))

      ;; Chapter: Display Widgets
      ("Chapter: Display Widgets"
       (("Labels"
         "gtk3-example"
         "label.lisp"
         "EXAMPLE-LABEL")
        ("More Labels"
         "gtk3-example"
         "label-more.lisp"
         "EXAMPLE-LABEL-MORE")
        ("Images"
         "gtk3-example"
         "image.lisp"
         "EXAMPLE-IMAGE")
        ("Info Bar"
         "gtk3-example"
         "info-bar.lisp"
         "EXAMPLE-INFO-BAR")
        ("Progress Bar"
         "gtk3-example"
         "progress-bar.lisp"
         "EXAMPLE-PROGRESS-BAR")
        ("Statusbar"
         "gtk3-example"
         "statusbar.lisp"
         "EXAMPLE-STATUSBAR")))

      ;; Chapter: Layout Widgets
      ("Chapter: Layout Widgets"
       (("Button Boxes"
         "gtk3-example"
         "button-box.lisp"
         "EXAMPLE-BUTTON-BOX")
        ("Paned Window"
         "gtk3-example"
         "paned-window.lisp"
         "EXAMPLE-PANED-WINDOW")
        ("Layout Widget"
         "gtk3-example"
         "layout.lisp"
         "EXAMPLE-LAYOUT")
        ("Notebook"
         "gtk3-example"
         "notebook.lisp"
         "EXAMPLE-NOTEBOOK")
        ("Frame Widget"
         "gtk3-example"
         "frame.lisp"
         "EXAMPLE-FRAME"
         t)
        ("Aspect Frame"
         "gtk3-example"
         "aspect-frame.lisp"
         "EXAMPLE-ASPECT-FRAME")
        ("Fixed Container"
         "gtk3-example"
         "fixed.lisp"
         "EXAMPLE-FIXED")))

     "Deprecated"
     (("Table Packing"
         "gtk3-example"
       "table-packing.lisp"
       "EXAMPLE-TABLE-PACKING")
      ("Table Packing more spacing"
       "gtk3-example"
       "table-packing-2.lisp"
       "EXAMPLE-TABLE-PACKING-2")
      ("Numerable Icons"
       "gtk3-example"
       "numerable-icon.lisp"
       "EXAMPLE-NUMERABLE-ICON")
      ("Arrow Button"
       "gtk3-example"
       "arrow-button.lisp"
       "EXAMPLE-ARROW-BUTTON")
      ("Alignment"
       "gtk3-example"
       "alignment.lisp"
       "EXAMPLE-ALIGNMENT")
      ("Alignment Interactive"
       "gtk3-example"
       "alignment-interactive.lisp"
       "EXAMPLE-ALIGNMENT-INTERACTIVE"))
))

(defun mklist (obj)
  (if (listp obj)
      obj
      (list obj)))

(defun create-and-fill-tree-store (data &optional (model nil) (iter nil))
  (unless model
    (setf model (apply #'gtk:tree-store-new (mklist (first data))))
    (setf data (rest data)))
  (let ((parent iter))
    (dolist (entry (mklist data))
      (cond ((or (atom entry) (every #'atom entry)) ; entry is never an atom?
             (setf parent
                   (apply #'gtk:tree-store-set model
                                               (gtk:tree-store-append model
                                                                      iter)
                                               (mklist entry))))
            ((some #'listp entry)
             (create-and-fill-tree-store entry
                                         model
                                         parent)))))
  model)

;;; ----------------------------------------------------------------------------

(defun create-view-and-model (&optional application)
  (let* ((model (create-and-fill-tree-store *tree-model*))
         (view (make-instance 'gtk:tree-view
                              :model model))
         (selection (gtk:tree-view-selection view)))
    ;; Create renderers for the cells
    (let* ((renderer (gtk:cell-renderer-text-new))
           (column (gtk:tree-view-column-new-with-attributes "Example"
                                                             renderer
                                                             "text" 0)))
      (gtk:tree-view-append-column view column))
    (g:signal-connect view "row-activated"
       (lambda (tree-view path column)
         (declare (ignore column))
         (let* ((model (gtk:tree-view-model tree-view))
                (iter (gtk:tree-model-iter model path))
                (func-name (string-upcase
                               (gtk:tree-model-value model iter id-func)))
                (package (string-upcase
                             (gtk:tree-model-value model iter id-package)))
                (func (find-symbol func-name (find-package package)))
;                          (find-symbol func-name :cairo-demo)
;                          (find-symbol func-name :cairo-clock)
                          )
           (format t "func-name : ~a~%" func-name)
           (format t "func      : ~a~%" func)
           (if func
               (if (gtk:tree-model-value model iter id-app)
                   (funcall func application)
                   (funcall func))
               (format t "~%No function.~%")))))
    (setf (gtk:tree-selection-mode selection) :browse)
    ;; The selection has changed.
    (g:signal-connect selection "changed"
       (lambda (tree-selection)
         (let* ((iter (gtk:tree-selection-selected tree-selection))
                (package (gtk:tree-model-value model iter id-package))
                (filename (gtk:tree-model-value model iter id-file))
                (ui-file (gtk:tree-model-value model iter id-ui))
                (css-file (gtk:tree-model-value model iter id-css)))
           ;; TODO: Improve this peace of code. Use pathname functions.
           (when package
             (format t "package: ~a, filename : ~a~%" package filename)
             (format t "path : ~a~%" (sys-path filename package))
             (when filename (setf filename
                                  (namestring (sys-path filename package))))
             (when (> (length ui-file) 0)
               (setf ui-file (namestring (sys-path ui-file package))))
             (when (> (length css-file) 0)
               (setf css-file (namestring (sys-path css-file package)))))
           (if (> (length filename) 0)
               (load-file filename))
           (if (> (length ui-file) 0)
               (load-file-buffer ui-buffer ui-file)
               (clear-buffer ui-buffer))
           (if (> (length css-file) 0)
               (load-file-buffer css-buffer css-file)
               (clear-buffer css-buffer)))))
      view))

(defun gtk-demo-activate (application)
  (let ((window (make-instance 'gtk:application-window
                               :application application
                               :type :toplevel
                               :title "GTK Lisp Code Demos"
                               :default-width 1000
                               :default-height 800))
        ;; A horizontal pane
        (content (make-instance 'gtk:paned
                                :orientation :horizontal))
        ;; A scrollable
        (scroller (make-instance 'gtk:scrolled-window
                                 :hscrollbar-policy :never
                                 :vscrollbar-policy :automatic
                                 :hexpand t
                                 :vexpand t))
        ;; A notebook
        (notebook (make-instance 'gtk:notebook
                                 :scrollable t))
        (view (create-view-and-model application)))

    (g:signal-connect window "destroy"
        (lambda (widget)
          (declare (ignore widget))
          (let ((action (g:action-map-lookup-action application "quit")))
            (g:action-activate action))))

    ;; Set an icon for the application
    (let* ((path (sys-path "demo/gtk-demo/gtk-logo-rgb.png"))
           (pixbuf (gdk:pixbuf-new-from-file path)))
      (setq pixbuf (gdk:pixbuf-add-alpha pixbuf t 255 255 255))
      (setf (gtk:window-default-icon-list) (list pixbuf)))
    ;; Add the widgets to the content of the window
    (gtk:container-add scroller view)
    (gtk:paned-add1 content scroller)
    (gtk:paned-add2 content notebook)
    ;; Add the notebook pages to the notebook
    (gtk:notebook-append-page notebook
                              (create-text info-buffer nil)
                              (gtk:label-new-with-mnemonic "_Info"))
    (gtk:notebook-append-page notebook
                              (create-text source-buffer t)
                              (gtk:label-new-with-mnemonic "_Source"))
    (gtk:notebook-append-page notebook
                              (create-text ui-buffer t)
                              (gtk:label-new-with-mnemonic "_UI Definition"))
    (gtk:notebook-append-page notebook
                              (create-text css-buffer t)
                              (gtk:label-new-with-mnemonic "_CSS Definition"))
    ;; Add the content to the window
    (gtk:container-add window content)
    (gtk:widget-show-all window)))

(defun activate-about-dialog ()
  (let (;; Create an about dialog
        (dialog (make-instance 'gtk:about-dialog
                               :program-name "GTK Lisp Demo"
                               :version "0.9"
                               :copyright "(c) Dieter Kaiser"
                               :website
                               "github.com/crategus/cl-cffi-gtk"
                               :website-label "Project web site"
                               :license "LLGPL"
                               :authors '("Dieter Kaiser")
                               :documenters '("Dieter Kaiser")
                               :artists '("None")
                               :logo-icon-name
                               "applications-development"
                               :wrap-license t)))
    ;; Run the about dialog
    (gtk:dialog-run dialog)
    ;; Destroy the about dialog
    (gtk:widget-destroy dialog)))

(defvar *appmenu*
"<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<interface>
  <!-- interface-requires gtk+ 3.10 -->
  <menu id=\"appmenu\">
    <section>
      <item>
        <attribute name=\"label\" translatable=\"yes\">Inspector</attribute>
        <attribute name=\"action\">app.inspector</attribute>
      </item>
    </section>
    <section>
      <item>
        <attribute name=\"label\" translatable=\"yes\">About</attribute>
        <attribute name=\"action\">app.about</attribute>
      </item>
    </section>
    <section>
      <item>
        <attribute name=\"label\" translatable=\"yes\">_Quit</attribute>
        <attribute name=\"action\">app.quit</attribute>
        <attribute name=\"accel\">&lt;Primary&gt;q</attribute>
      </item>
    </section>
  </menu>
</interface>")

(defun gtk-demo-startup (application)
  ;; Load the application menu
  (let ((builder (make-instance 'gtk:builder)))
    (gtk:builder-add-from-string builder *appmenu*)
    ;; TODO: Improve the implemenation of the menubar.
    (setf (gtk:application-menubar application)
          (gtk:builder-object builder "appmenu")))
  ;; Add action "inspector" to the application
  (let ((action (g:simple-action-new "inspector" nil)))
    ;; Connect a handler to the signal "activate"
    (g:signal-connect action "activate"
       (lambda (action parameter)
         (declare (ignore action parameter))
         (gtk:window-interactive-debugging t)))
    ;; Add the action to the action map of the application
    (g:action-map-add-action application action))
  ;; Add action "about" to the application
  (let ((action (g:simple-action-new "about" nil)))
    ;; Connect a handler to the signal "activate"
    (g:signal-connect action "activate"
       (lambda (action parameter)
         (declare (ignore action parameter))
         (activate-about-dialog)))
    ;; Add the action to the action map of the application
    (g:action-map-add-action application action))
  ;; Add action "quit" to the application
  (let ((action (g:simple-action-new "quit" nil)))
    ;; Connect a handler to the signal activate
    (g:signal-connect action "activate"
       (lambda (action parameter)
         (declare (ignore action parameter))
         ;; Destroy all windows of the application
         (dolist (window (gtk:application-windows application))
           (gtk:widget-destroy window))))
    ;; Add the action to action map of the application
    (g:action-map-add-action application action)))

(defun gtk3-demo (&rest argv)
  (unless (string= "GTK Lisp Demo" (g:application-name))
    (setf (g:application-name) "GTK Lisp Demo"))
  (let ((gtk-demo (make-instance 'gtk:application
                                 :application-id "com.crategus.gtk-demo"
                                 :register-session t)))
    ;; Connect signal handlers to the application
    (g:signal-connect gtk-demo "activate" #'gtk-demo-activate)
    (g:signal-connect gtk-demo "startup" #'gtk-demo-startup)
    ;; Start the application
    (g:application-run gtk-demo argv)))

;;; --- End of file gtk-demo.lisp ----------------------------------------------
