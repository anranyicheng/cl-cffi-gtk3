;;; ----------------------------------------------------------------------------
;;; gtk3.cell-renderer-accel.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk3/>.
;;;
;;; Copyright (C) 2011 - 2023 Dieter Kaiser
;;;
;;; Permission is hereby granted, free of charge, to any person obtaining a
;;; copy of this software and associated documentation files (the "Software"),
;;; to deal in the Software without restriction, including without limitation
;;; the rights to use, copy, modify, merge, publish, distribute, sublicense,
;;; and/or sell copies of the Software, and to permit persons to whom the
;;; Software is furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be included in
;;; all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
;;; THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;; DEALINGS IN THE SOFTWARE.
;;; ----------------------------------------------------------------------------
;;;
;;; GtkCellRendererAccel
;;;
;;;     Renders a keyboard accelerator in a cell
;;;
;;; Types and Values
;;;
;;;     GtkCellRendererAccel
;;;     GtkCellRendererAccelMode
;;;
;;; Functions
;;;
;;;     gtk_cell_renderer_accel_new
;;;
;;; Properties
;;;
;;;     accel-key
;;;     accel-mode
;;;     accel-mods
;;;     keycode
;;;
;;; Signals
;;;
;;;     accel-cleared
;;;     accel-edited
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkCellRenderer
;;;             ╰── GtkCellRendererText
;;;                 ╰── GtkCellRendererAccel
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkCellRendererAccelMode
;;; ----------------------------------------------------------------------------

(gobject:define-g-enum "GtkCellRendererAccelMode" cell-renderer-accel-mode
  (:export t
   :type-initializer "gtk_cell_renderer_accel_mode_get_type")
  (:gtk 0)
  (:other 1))

#+liber-documentation
(setf (liber:alias-for-symbol 'cell-renderer-accel-mode)
      "GEnum"
      (liber:symbol-documentation 'cell-renderer-accel-mode)
 "@version{2023-2-20}
  @begin{short}
    Determines if the edited accelerators are GTK accelerators.
  @end{short}
  If they are, consumed modifiers are suppressed, only accelerators accepted by
  GTK are allowed, and the accelerators are rendered in the same way as they
  are in menus.
  @begin{pre}
(gobject:define-g-enum \"GtkCellRendererAccelMode\" cell-renderer-accel-mode
  (:export t
   :type-initializer \"gtk_cell_renderer_accel_mode_get_type\")
  (:gtk 0)
  (:other 1))
  @end{pre}
  @begin[code]{table}
    @entry[:gtk]{GTK accelerators mode.}
    @entry[:other]{Other accelerator mode.}
  @end{table}
  @see-class{gtk:cell-renderer-accel}")

;;; ----------------------------------------------------------------------------
;;; struct GtkCellRendererAccel
;;; ----------------------------------------------------------------------------

(gobject:define-g-object-class "GtkCellRendererAccel" cell-renderer-accel
  (:superclass cell-renderer-text
   :export t
   :interfaces nil
   :type-initializer "gtk_cell_renderer_accel_get_type")
  ((accel-key
    cell-renderer-accel-accel-key
    "accel-key" "guint" t t)
   (accel-mode
    cell-renderer-accel-accel-mode
    "accel-mode" "GtkCellRendererAccelMode" t t)
   (accel-mods
    cell-renderer-accel-accel-mods
    "accel-mods" "GdkModifierType" t t)
   (keycode
    cell-renderer-accel-keycode
    "keycode" "guint" t t)))

#+liber-documentation
(setf (documentation 'cell-renderer-accel 'type)
 "@version{2023-2-20}
  @begin{short}
    The @sym{gtk:cell-renderer-accel} object displays a keyboard accelerator,
    i.e. a key combination like the @code{Control+a} key.
  @end{short}
  If the cell renderer is editable, the accelerator can be changed by simply
  typing the new combination.
  @begin[Signal Details]{dictionary}
    @subheading{The \"accel-cleared\" signal}
      @begin{pre}
lambda (accel path)    :run-last
      @end{pre}
      Gets emitted when the user has removed the accelerator.
      @begin[code]{table}
        @entry[accel]{The @sym{gtk:cell-renderer-accel} object reveiving the
          signal.}
        @entry[path]{A string with the path identifying the row of the edited
          cell.}
      @end{table}
    @subheading{The \"accel-edited\" signal}
      @begin{pre}
lambda (accel path keyval mods keycode)    :run-last
      @end{pre}
      Gets emitted when the user has selected a new accelerator.
      @begin[code]{table}
        @entry[accel]{The @sym{gtk:cell-renderer-accel} object reveiving the
          signal.}
        @entry[path]{A string with the path identifying the row of the edited
          cell.}
        @entry[keyval]{An unsigned integer with the new accelerator keyval.}
        @entry[mods]{A @class{gdk:modifier-type} value with the new acclerator
          modifier mask.}
        @entry[keycode]{An unsigned integer with the keycode of the new
          accelerator.}
      @end{table}
  @end{dictionary}
  @see-constructor{gtk:cell-renderer-accel-new}
  @see-slot{gtk:cell-renderer-accel-accel-key}
  @see-slot{gtk:cell-renderer-accel-accel-mode}
  @see-slot{gtk:cell-renderer-accel-accel-mods}
  @see-slot{gtk:cell-renderer-accel-keycode}
  @see-class{gtk:cell-renderer}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- cell-renderer-accel-accel-key ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "accel-key"
                                               'cell-renderer-accel) t)
 "The @code{accel-key} property of type @code{:uint} (Read / Write) @br{}
  The keyval of the accelerator. @br{}
  Allowed values: <= @code{G_MAXINT} @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-accel-accel-key)
      "Accessor"
      (documentation 'cell-renderer-accel-accel-key 'function)
 "@version{#2023-2-20}
  @syntax[]{(gtk:cell-renderer-accel-accel-key object) => keyval}
  @syntax[]{(setf (gtk:cell-renderer-accel-accel-key object) keyval)}
  @argument[object]{a @class{gtk:cell-renderer-accel} object}
  @argument[keyval]{an unsigned integer with the keyval of the accelerator}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer]{accel-key} slot of the
    @class{gtk:cell-renderer-accel} class.
  @end{short}
  The keyval of the accelerator.
  @see-class{gtk:cell-renderer-accel}")

;;; --- cell-renderer-accel-accel-mode -----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "accel-mode"
                                               'cell-renderer-accel) t)
 "The @code{accel-mode} property of type @symbol{gtk:cell-renderer-accel-mode}
  (Read / Write) @br{}
  Determines if the edited accelerators are GTK accelerators. If they are,
  consumed modifiers are suppressed, only accelerators accepted by GTK are
  allowed, and the accelerators are rendered in the same way as they are in
  menus. @br{}
  Default value: @code{:gtk}")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-accel-accel-mode)
      "Accessor"
      (documentation 'cell-renderer-accel-accel-mode 'function)
 "@version{#2023-2-20}
  @syntax[]{(gtk:cell-renderer-accel-accel-mode object) => mode}
  @syntax[]{(setf (gtk:cell-renderer-accel-accel-mode object) mode)}
  @argument[object]{a @class{gtk:cell-renderer-accel} object}
  @argument[mode]{a value of the @symbol{gtk:cell-renderer-accel-mode}
    enumeration}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-accel]{accel-mode} slot of the
    @class{gtk:cell-renderer-accel} class.
  @end{short}
  Determines if the edited accelerators are GTK accelerators. If they are,
  consumed modifiers are suppressed, only accelerators accepted by GTK are
  allowed, and the accelerators are rendered in the same way as they are in
  menus.
  @see-class{gtk:cell-renderer-accel}
  @see-symbol{gtk:cell-renderer-accel-mode}")

;;; --- cell-renderer-accel-accel-mods -----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "accel-mods"
                                               'cell-renderer-accel) t)
 "The @code{accel-mods} property of type @symbol{gdk:modifier-type}
  (Read / Write) @br{}
  The modifier mask of the accelerator.")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-accel-accel-mods)
      "Accessor"
      (documentation 'cell-renderer-accel-accel-mods 'function)
 "@version{#2023-2-20}
  @syntax[]{(gtk:cell-renderer-accel-accel-mods object) => mods}
  @syntax[]{(setf (gtk:cell-renderer-accel-accel-mods object) mods)}
  @argument[object]{a @class{gtk:cell-renderer-accel} object}
  @argument[mods]{a @symbol{gdk:modifier-type} value}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-accel]{accel-mods} slot of the
    @class{gtk:cell-renderer-accel} class.
  @end{short}
  The modifier mask of the accelerator.
  @see-class{gtk:cell-renderer-accel}
  @see-symbol{gdk:modifier-type}")

;;; --- cell-renderer-accel-keycode --------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "keycode"
                                               'cell-renderer-accel) t)
 "The @code{keycode} property of type @code{:uint} (Read / Write) @br{}
  The hardware keycode of the accelerator. Note that the hardware keycode is
  only relevant if the key does not have a keyval. Normally, the keyboard
  configuration should assign keyvals to all keys. @br{}
  Allowed values: <= @code{G_MAXINT} @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-accel-keycode)
      "Accessor"
      (documentation 'cell-renderer-accel-keycode 'function)
 "@version{#2023-2-20}
  @syntax[]{(gtk:cell-renderer-accel-keycode object) => keycode}
  @syntax[]{(setf (gtk:cell-renderer-accel-keycode object) keycode)}
  @argument[object]{a @class{gtk:cell-renderer-accel} object}
  @argument[keycode]{an unsigned integer with the hardware keycode of the
    accelerator}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-accel]{keycode} slot of the
    @class{gtk:cell-renderer-accel} class.
  @end{short}
  The hardware keycode of the accelerator. Note that the hardware keycode is
  only relevant if the key does not have a keyval. Normally, the keyboard
  configuration should assign keyvals to all keys.
  @see-class{gtk:cell-renderer-accel}")

;;; ----------------------------------------------------------------------------
;;; gtk_cell_renderer_accel_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline cell-renderer-accel-new))

(defun cell-renderer-accel-new ()
 #+liber-documentation
 "@version{#2023-2-20}
  @returns{The new @class{gtk:cell-renderer-accel} object.}
  @short{Creates a new cell renderer accel object.}
  @see-class{gtk:cell-renderer-accel}"
  (make-instance 'cell-renderer-accel))

(export 'cell-renderer-accel-new)

;;; --- End of file gtk3.cell-renderer-accel.lisp ------------------------------
