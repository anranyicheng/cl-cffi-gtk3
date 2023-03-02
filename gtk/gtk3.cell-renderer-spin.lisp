;;; ----------------------------------------------------------------------------
;;; gtk3.cell-renderer-spin.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2023 Dieter Kaiser
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
;;;
;;; GtkCellRendererSpin
;;;
;;;     Renders a spin button in a cell
;;;
;;; Types and Values
;;;
;;;     GtkCellRendererSpin
;;;
;;; Functions
;;;
;;;     gtk_cell_renderer_spin_new
;;;
;;; Properties
;;;
;;;     adjustment
;;;     climb-rate
;;;     digits
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkCellRenderer
;;;             ╰── GtkCellRendererText
;;;                 ╰── GtkCellRendererSpin
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkCellRendererSpin
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkCellRendererSpin" cell-renderer-spin
  (:superclass cell-renderer-text
    :export t
    :interfaces nil
    :type-initializer "gtk_cell_renderer_spin_get_type")
  ((adjustment
    cell-renderer-spin-adjustment
    "adjustment" "GtkAdjustment" t t)
   (climb-rate
    cell-renderer-spin-climb-rate
    "climb-rate" "gdouble" t t)
   (digits
    cell-renderer-spin-digits
    "digits" "guint" t t)))

#+liber-documentation
(setf (documentation 'cell-renderer-spin 'type)
 "@version{2023-2-21}
  @begin{short}
    The @sym{gtk:cell-renderer-spin} object renders text in a cell like
    the @class{gtk:cell-renderer-text} object from which it is derived.
  @end{short}
  But while the @class{gtk:cell-renderer-text} object offers a simple entry to
  edit the text, the @sym{gtk:cell-renderer-spin} object offers a
  @class{gtk:spin-button} widget. Of course, that means that the text has to be
  parseable as a floating point number.

  The range of the spin button is taken from the adjustment property of the
  cell renderer, which can be set explicitly or mapped to a column in the tree
  model, like all properties of cell renders. The @sym{gtk:cell-renderer-spin}
  object also has properties for the \"climb-rate\" and the number of \"digits\"
  to display. Other @class{gtk:spin-button} properties can be set in a handler
  for the \"editing-started\" signal.
  @see-constructor{gtk:cell-renderer-spin-new}
  @see-slot{gtk:cell-renderer-spin-adjustment}
  @see-slot{gtk:cell-renderer-spin-climb-rate}
  @see-slot{gtk:cell-renderer-spin-digits}
  @see-class{gtk:cell-renderer-text}
  @see-class{gtk:spin-button}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- cell-renderer-spin-adjustment ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "adjustment"
                                               'cell-renderer-spin) t)
 "The @code{adjustment} property of type @class{gtk:adjustment} (Read / Write)
  @br{}
  The adjustment that holds the value of the spin button. This must be
  non-@code{nil} for the cell renderer to be editable.")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-spin-adjustment)
      "Accessor"
      (documentation 'cell-renderer-spin-adjustment 'function)
 "@version{2023-2-21}
  @syntax[]{(gtk:cell-renderer-spin-adjustment object) => adjustment}
  @syntax[]{(setf (gtk:cell-renderer-spin-adjustment object) adjustment)}
  @argument[object]{a @class{gtk:cell-renderer-spin} object}
  @argument[adjustment]{a @class{gtk:adjustment} object}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-spin]{adjustment} slot of the
    @class{gtk:cell-renderer-spin} class.
  @end{short}
  The adjustment that holds the value of the spin button. This must be
  non-@code{nil} for the cell renderer to be editable.
  @see-class{gtk:cell-renderer-spin}
  @see-class{gtk:adjustment}")

;;; --- cell-renderer-spin-climb-rate ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "climb-rate"
                                               'cell-renderer-spin) t)
 "The @code{climb-rate} property of type @code{:double} (Read / Write) @br{}
  The acceleration rate when you hold down a button. @br{}
  Allowed values: >= 0 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-spin-climb-rate)
      "Accessor"
      (documentation 'cell-renderer-spin-climb-rate 'function)
 "@version{2023-2-21}
  @syntax[]{(gtk:cell-renderer-spin-climb-rate object) => climb-rate}
  @syntax[]{(setf (gtk:cell-renderer-spin-climb-rate object) climb-rate)}
  @argument[object]{a @class{gtk:cell-renderer-spin} object}
  @argument[climb-rate]{a double float with the acceleration rate}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-spin]{climb-rate} slot of the
    @class{gtk:cell-renderer-spin} class.
  @end{short}
  The acceleration rate when you hold down a button.
  @see-class{gtk:cell-renderer-spin}")

;;; --- cell-renderer-spin-digits ----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "digits" 'cell-renderer-spin) t)
 "The @code{digits} property of type @code{:uint} (Read / Write) @br{}
  The number of decimal places to display. @br{}
  Allowed values: <= 20 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-spin-digits)
      "Accessor"
      (documentation 'cell-renderer-spin-digits 'function)
 "@version{2023-2-21}
  @syntax[]{(gtk:cell-renderer-spin-digits object) => digits}
  @syntax[]{(setf (gtk:cell-renderer-spin-digits object) digits)}
  @argument[object]{a @class{gtk:cell-renderer-spin} object}
  @argument[digits]{an unsigned integer with the number of decimal places to
    display}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-spin]{digits} slot of the
    @class{gtk:cell-renderer-spin} class.
  @end{short}
  The number of decimal places to display.
  @see-class{gtk:cell-renderer-spin}")

;;; ----------------------------------------------------------------------------
;;; gtk_cell_renderer_spin_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline cell-renderer-spin-new))

(defun cell-renderer-spin-new ()
 #+liber-documentation
 "@version{2023-2-21}
  @return{A new @class{gtk:cell-renderer-spin} object.}
  @short{Creates a new cell renderer spin object.}
  @see-class{gtk:cell-renderer-spin}"
  (make-instance 'cell-renderer-spin))

(export 'cell-renderer-spin-new)

;;; --- End of file gtk3.cell-renderer-spin.lisp -------------------------------
