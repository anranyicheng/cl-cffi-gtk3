;;; ----------------------------------------------------------------------------
;;; gtk3.cell-renderer-combo.lisp
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
;;; GtkCellRendererCombo
;;;
;;;     Renders a combobox in a cell
;;;
;;; Synopsis
;;;
;;;     GtkCellRendererCombo
;;;
;;; Functions
;;;
;;;     gtk_cell_renderer_combo_new
;;;
;;; Properties
;;;
;;;     has-entry
;;;     model
;;;     text-column
;;;
;;; Signals
;;;
;;;     changed
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkCellRenderer
;;;             ╰── GtkCellRendererText
;;;                 ╰── GtkCellRendererCombo
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkCellRendererCombo
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkCellRendererCombo" cell-renderer-combo
  (:superclass cell-renderer-text
    :export t
    :interfaces nil
    :type-initializer "gtk_cell_renderer_combo_get_type")
  ((has-entry
    cell-renderer-combo-has-entry
    "has-entry" "gboolean" t t)
   (model
    cell-renderer-combo-model
    "model" "GtkTreeModel" t t)
   (text-column
    cell-renderer-combo-text-column
    "text-column" "gint" t t)))

#+liber-documentation
(setf (documentation 'cell-renderer-combo 'type)
 "@version{#2023-2-14}
  @begin{short}
    The @sym{gtk:cell-renderer-combo} object renders text in a cell like the
    @class{gtk:cell-renderer-text} object from which it is derived.
  @end{short}
  But while the @class{gtk:cell-renderer-text} object offers a simple entry to 
  edit the text, the @sym{gtk:cell-renderer-combo} object offers a the 
  @class{gtk:combo-box} widget to edit the text. The values to display in the 
  combo box are taken from the tree model specified in the @code{model} 
  property.

  The combo cell renderer takes care of adding a text cell renderer to the
  combo box and sets it to display the column specified by its
  @code{text-column} property. Further properties of the combo box can be
  set in a handler for the \"editing-started\" signal.
  @begin[Signal Details]{dictionary}
    @subheading{The \"changed\" signal}
      @begin{pre}
lambda (combo path iter)    :run-last
      @end{pre}
      The signal is emitted each time after the user selected an item in the
      combo box, either by using the mouse or the arrow keys. Contrary to the
      @class{gtk:combo-box} widget, the \"changed\" signal is not emitted for
      changes made to a selected item in the entry. The @arg{iter} argument
      corresponds to the newly selected item in the combo box and it is relative
      to the @class{gtk:tree-model} object set via the model property on the
      @sym{gtk:cell-renderer-combo} object. Note that as soon as you change the
      model displayed in the tree view, the tree view will immediately cease 
      the editing operating. This means that you most probably want to refrain 
      from changing the model until the combo cell renderer emits the edited or
      \"editing-canceled\" signal.
      @begin[code]{table}
        @entry[combo]{The @sym{gtk:cell-renderer-combo} object on which the
          signal is emitted.}
        @entry[path]{A string of the path identifying the edited cell, relative
          to the tree view model.}
        @entry[iter]{The @class{gtk:tree-iter} iterator selected in the combo
           box, relative to the combo box model.}
       @end{table}
  @end{dictionary}
  @see-constructor{gtk:cell-renderer-combo-new}
  @see-slot{gtk:cell-renderer-combo-has-entry}
  @see-slot{gtk:cell-renderer-combo-model}
  @see-slot{gtk:cell-renderer-combo-text-column}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- cell-renderer-combo-has-entry ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "has-entry" 
                                               'cell-renderer-combo) t)
 "The @code{has-entry} property of type @code{:boolean} (Read / Write) @br{}
  If @em{true}, the cell renderer will include an entry and allow to enter
  values other than the ones in the popup list. @br{}
  Default value: @em{true}")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-combo-has-entry)
      "Accessor"
      (documentation 'cell-renderer-combo-has-entry 'function)
 "@version{#2023-2-14}
  @syntax[]{(gtk:cell-renderer-combo-has-entry object) => setting}
  @syntax[]{(setf (gtk:cell-renderer-combo-has-entry object) setting)}
  @argument[object]{a @class{gtk:cell-renderer-combo} object}
  @argument[setting]{a boolean whether the cell renderer will include an entry}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-combo]{has-entry} slot of the
    @class{gtk:cell-renderer-combo} class.
  @end{short}
  If @em{true}, the cell renderer will include an entry and allow to enter
  values other than the ones in the popup list.
  @see-class{gtk:cell-renderer-combo}")

;;; --- cell-renderer-combo-model ----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "model" 'cell-renderer-combo) t)
 "The @code{model} property of type @class{gtk:tree-model} (Read / Write) @r{}
  Holds a tree model containing the possible values for the combo box. Use the
  @code{text-column} property to specify the column holding the values.")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-combo-model)
      "Accessor"
      (documentation 'cell-renderer-combo-model 'function)
 "@version{#2023-2-14}
  @syntax[]{(gtk:cell-renderer-combo-model object) => model}
  @syntax[]{(setf (gtk:cell-renderer-combo-model object) model)}
  @argument[object]{a @class{gtk:cell-renderer-combo} object}
  @argument[model]{a @class{gtk:tree-model} object}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-combo]{model} slot of the
    @class{gtk:cell-renderer-combo} class.
  @end{short}
  Holds a tree model containing the possible values for the combo box. Use the
  @code{text-column} property to specify the column holding the values.
  @see-class{gtk:cell-renderer-combo}
  @see-class{gtk:tree-model}")

;;; --- cell-renderer-combo-text-column ----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "text-column"
                                               'cell-renderer-combo) t)
 "The @code{text-column} property of type @code{:int} (Read / Write) @br{}
  Specifies the model column which holds the possible values for the combo
  box. Note that this refers to the model specified in the model property, not
  the model backing the tree view to which this cell renderer is attached. The
  @sym{gtk:cell-renderer-combo} object automatically adds a text cell renderer 
  for this column to its combo box. @br{}
  Allowed values: >= -1 @br{}
  Default value: -1")

#+liber-documentation
(setf (liber:alias-for-function 'cell-renderer-combo-text-column)
      "Accessor"
      (documentation 'cell-renderer-combo-text-column 'function)
 "@version{#2023-2-14}
  @syntax[]{(gtk:cell-renderer-combo-text-column object) => column}
  @syntax[]{(setf (gtk:cell-renderer-combo-text-column object) column)}
  @argument[object]{a @class{gtk:cell-renderer-combo} object}
  @argument[column]{an integer which specifies the model colum which holds the
    possible values for the combo box}
  @begin{short}
    Accessor of the @slot[gtk:cell-renderer-combo]{text-column} slot of the
    @class{gtk:cell-renderer-combo} class.
  @end{short}
  Specifies the model column which holds the possible values for the combo
  box. Note that this refers to the model specified in the model property, not
  the model backing the tree view to which this cell renderer is attached. The 
  @sym{gtk:cell-renderer-combo} object automatically adds a text cell renderer 
  for this column to its combo box.
  @see-class{gtk:cell-renderer-combo}")

;;; ----------------------------------------------------------------------------
;;; gtk_cell_renderer_combo_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline cell-renderer-combo-new))

(defun cell-renderer-combo-new ()
 #+liber-documentation
 "@version{#2023-2-14}
  @return{The new @class{gtk:cell-renderer-combo} object.}
  @begin{short}
    Creates a new cell renderer combo.
  @end{short}
  Adjust how text is drawn using object properties. Object properties can be
  set globally, with the @fun{g:object-property} function. Also, with the
  @class{gtk:tree-view-column} object, you can bind a property to a value in a
  @class{gtk:tree-model} object. For example, you can bind the \"text\" property 
  on the cell renderer to a string value in the model, thus rendering a 
  different string in each row of the @class{gtk:tree-view} widget.
  @see-class{gtk:cell-renderer-combo}
  @see-class{gtk:tree-view}
  @see-class{gtk:tree-view-column}
  @see-class{gtk:tree-model}
  @see-function{g:object-property}"
  (make-instance 'cell-renderer-combo))

(export 'cell-renderer-combo-new)

;;; --- End of file gtk3.cell-renderer-combo.lisp ------------------------------
