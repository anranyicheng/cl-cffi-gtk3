;;; ----------------------------------------------------------------------------
;;; gtk.grid.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2012 - 2021 Dieter Kaiser
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
;;; GtkGrid
;;;
;;;     Pack widgets in a rows and columns
;;;
;;; Types and Values
;;;
;;;     GtkGrid
;;;
;;; Functions
;;;
;;;     gtk_grid_new
;;;     gtk_grid_attach
;;;     gtk_grid_attach_next_to
;;;     gtk_grid_get_child_at
;;;     gtk_grid_insert_row
;;;     gtk_grid_insert_column
;;;     gtk_grid_remove_row
;;;     gtk_grid_remove_column
;;;     gtk_grid_insert_next_to
;;;     gtk_grid_set_row_homogeneous                       Accessor
;;;     gtk_grid_get_row_homogeneous                       Accessor
;;;     gtk_grid_set_row_spacing                           Accessor
;;;     gtk_grid_get_row_spacing                           Accessor
;;;     gtk_grid_set_column_homogeneous                    Accessor
;;;     gtk_grid_get_column_homogeneous                    Accessor
;;;     gtk_grid_set_column_spacing                        Accessor
;;;     gtk_grid_get_column_spacing                        Accessor
;;;     gtk_grid_get_baseline_row                          Accessor
;;;     gtk_grid_set_baseline_row                          Accessor
;;;     gtk_grid_get_row_baseline_position
;;;     gtk_grid_set_row_baseline_position
;;;
;;; Properties
;;;
;;;         gint  baseline-row        Read / Write
;;;     gboolean  column-homogeneous  Read / Write
;;;         gint  column-spacing      Read / Write
;;;     gboolean  row-homogeneous     Read / Write
;;;         gint  row-spacing         Read / Write
;;;
;;; Child Properties
;;;
;;;         gint  height              Read / Write
;;;         gint  left-attach         Read / Write
;;;         gint  top-attach          Read / Write
;;;         gint  width               Read / Write
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkGrid
;;;
;;; Implemented Interfaces
;;;
;;;     GtkGrid implements AtkImplementorIface, GtkBuildable and GtkOrientable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkGrid
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkGrid" grid
  (:superclass container
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkOrientable")
   :type-initializer "gtk_grid_get_type")
  ((baseline-row
    grid-baseline-row
    "baseline-row" "gint" t t)
   (column-homogeneous
    grid-column-homogeneous
    "column-homogeneous" "gboolean" t t)
   (column-spacing
    grid-column-spacing
    "column-spacing" "gint" t t)
   (row-homogeneous
    grid-row-homogeneous
    "row-homogeneous" "gboolean" t t)
   (row-spacing
    grid-row-spacing
    "row-spacing" "gint" t t)))

#+liber-documentation
(setf (documentation 'grid 'type)
 "@version{#2021-10-30}
  @begin{short}
    The @sym{gtk:grid} widget is a container which arranges its child widgets
    in rows and columns, with arbitrary positions and horizontal/vertical spans.
  @end{short}

  Children are added using the @fun{gtk:grid-attach} function. They can span
  multiple rows or columns. It is also possible to add a child next to an
  existing child, using the @fun{gtk:grid-attach-next-to} function. The
  behaviour of the @sym{gtk:grid} widget when several children occupy the same
  grid cell is undefined.

  The @sym{gtk:grid} widget can be used like a @class{gtk:box} widget by just
  using the @fun{gtk:container-add} function, which will place children next to
  each other in the direction determined by the
  @slot[gtk:orientable]{orientation} property. However, if all you want is a
  single row or column, then the @class{gtk:box} widget is the preferred widget.
  @begin[CSS nodes]{dictionary}
    The @sym{gtk:grid} implementation uses a single CSS node with name
    @code{grid}.
  @end{dictionary}
  @begin[Child Property Details]{dictionary}
    @begin[code]{table}
      @begin[height]{entry}
        The code @code{height} child property of type @code{:int} (Read / Write)
        @br{}
        The number of rows that a child spans. @br{}
        Allowed values: >= 1 @br{}
        Default value: 1
      @end{entry}
      @begin[left-attach]{entry}
        The @code{left-attach} child property of type @code{:int} (Read / Write)
        @br{}
        The column number to attach the left side of the child to. @br{}
        Default value: 0
      @end{entry}
      @begin[top-attach]{entry}
        The @code{top-attach} child property of type @code{:int} (Read / Write)
        @br{}
        The row number to attach the top side of a child widget to. @br{}
        Default value: 0
      @end{entry}
      @begin[width]{entry}
        The @code{width} child property of type @code{:int} (Read / Write) @br{}
        The number of columns that a child spans. @br{}
        Allowed values: >= 1 @br{}
        Default value: 1
      @end{entry}
    @end{table}
  @end{dictionary}
  @see-slot{gtk:grid-baseline-row}
  @see-slot{gtk:grid-column-homogeneous}
  @see-slot{gtk:grid-column-spacing}
  @see-slot{gtk:grid-row-homogeneous}
  @see-slot{gtk:grid-row-spacing}
  @see-class{gtk:box}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "baseline-row" 'grid) t)
 "The @code{baseline-row} property of type @code{:int} (Read / Write) @br{}
  The row to align to the baseline when @slot[gtk:widget]{valign} has the
  @code{:center} value of the @symbol{gtk:align} enumeration. @br{}
  Allowed values: >= 0 @br{}
  Default value: 0 @br{}")

#+liber-documentation
(setf (liber:alias-for-function 'grid-baseline-row)
      "Accessor"
      (documentation 'grid-baseline-row 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-baseline-row object) => row}
  @syntax[]{(setf (gtk:grid-baseline-row object) row)}
  @argument[object]{a @class{gtk:grid} widget}
  @argument[row]{an integer with the row index}
  @begin{short}
    Accessor of the @slot[gtk:grid]{baseline-row} slot of the @class{gtk:grid}
    class.
  @end{short}

  The @sym{gtk:grid-baseline-row} slot access function returns which row
  defines the global baseline of the grid. The
  @sym{(setf gtk:grid-baseline-row)} slot access function sets which row
  defines the global baseline for the entire grid. Each row in the grid can
  have its own local baseline, but only one of those is global, meaning it will
  be the baseline in the parent of the grid.
  @see-class{gtk:grid}")

;;; --- grid-column-homogeneous --------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "column-homogeneous" 'grid) t)
 "The @code{column-homogeneous} property of type @code{:boolean}
  (Read / Write) @br{}
  If @em{true}, the columns are all the same width. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'grid-column-homogeneous)
      "Accessor"
      (documentation 'grid-column-homogeneous 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-column-homogeneous object) => homogenous}
  @syntax[]{(setf (gtk:grid-column-homogeneous object) homogenous)}
  @argument[object]{a @class{gtk:grid} widget}
  @argument[homogeneous]{@em{true} to make columns homogeneous}
  @begin{short}
    Accessor of the @slot[gtk:grid]{column-homogeneous} slot of the
    @class{gtk:grid} class.
  @end{short}

  The @sym{gtk:grid-column-homogeneous} slot access function returns whether
  all columns of the grid have the same width. The
  @sym{(setf gtk:grid-column-homogeneous)} slot access function sets whether
  all columns of the grid will have the same width.
  @see-class{gtk:grid}
  @see-function{gtk:grid-row-homogeneous}")

;;; --- grid-column-spacing ------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "column-spacing" 'grid) t)
 "The @code{column-spacing} property of type @code{:int} (Read / Write) @br{}
  The amount of space between two consecutive columns. @br{}
  Allowed values: [0, 32767] @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'grid-column-spacing)
      "Accessor"
      (documentation 'grid-column-spacing 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-column-spacing object) => spacing}
  @syntax[]{(setf (gtk:grid-column-spacing object) spacing)}
  @argument[object]{a @class{gtk:grid} widget}
  @argument[spacing]{an integer with the amount of space to insert between
    columns}
  @begin{short}
    Accessor of the @slot[gtk:grid]{column-spacing} slot of the
    @class{gtk:grid} class.
  @end{short}

  The @sym{gtk:grid-column-spacing} slot access function returns the amount of
  space between the columns of the grid. The
  @sym{(setf gtk:grid-column-spacing)} slot access function sets the amount of
  space.
  @see-class{gtk:grid}
  @see-function{gtk:grid-row-spacing}")

;;; --- grid-row-homogeneous -----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "row-homogeneous" 'grid) t)
 "The @code{row-homogeneous} property of type @code{:boolean}
  (Read / Write) @br{}
  If @em{true}, the rows are all the same height. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'grid-row-homogeneous)
      "Accessor"
      (documentation 'grid-row-homogeneous 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-row-homogeneous object) => homogeneous}
  @syntax[]{(setf (gtk:grid-row-homogeneous object) homogeneous)}
  @argument[object]{a @class{gtk:grid} widget}
  @argument[homogeneous]{@em{true} to make rows homogeneous}
  @begin{short}
    Accessor of the @slot[gtk:grid]{row-homogeneous} slot of the
    @class{gtk:grid} class.
  @end{short}

  The @sym{gtk:grid-row-homogeneous} slot access function returns whether all
  rows of the grid have the same height. The
  @sym{(setf gtk:grid-row-homogeneous)} slot access function sets whether all
  rows of the grid will have the same height.
  @see-class{gtk:grid}
  @see-function{gtk:grid-column-homogeneous}")

;;; --- grid-row-spacing ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "row-spacing" 'grid) t)
 "The @code{row-spacing} property of type @code{:int} (Read / Write) @br{}
  The amount of space between two consecutive rows. @br{}
  Allowed values: [0, 32767] @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'grid-row-spacing)
      "Accessor"
      (documentation 'grid-row-spacing 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-row-spacing object) => spacing}
  @syntax[]{(setf (gtk:grid-row-spacing object) spacing)}
  @argument[object]{a @class{gtk:grid} widget}
  @argument[spacing]{an integer with the amount of space to insert between rows}
  @begin{short}
    Accessor of the @slot[gtk:grid]{row-spacing} slot of the @class{gtk:grid}
    class.
  @end{short}

  The @sym{gtk:grid-row-spacing} slot access function returns the amount of
  space between the rows of the grid. The @sym{(setf gtk:grid-row-spacing)}
  slot access function sets the amount of space.
  @see-class{gtk:grid}
  @see-function{gtk:grid-column-spacing}")

;;; ----------------------------------------------------------------------------
;;; Child Property and Child Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- grid-child-height ------------------------------------------------------

(define-child-property grid-child-height "height" "gint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'grid-child-height)
      "Accessor"
      (documentation 'grid-child-height 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-child-height container child) => height}
  @syntax[]{(setf (gtk:grid-child-height container child) height)}
  @argument[container]{a @class{gtk:grid} widget}
  @argument[child]{a @class{gtk:widget} object}
  @argument[height]{an integer with the height}
  @begin{short}
    Accessor of the @code{height} child property of the @class{gtk:grid} class.
  @end{short}

  The number of rows that a child spans.
  @see-class{gtk:grid}
  @see-class{gtk:widget}
  @see-function{gtk:grid-child-width}")

;;; --- grid-child-left-attach -------------------------------------------------

(define-child-property grid-child-left-attach "left-attach" "gint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'grid-child-left-attach)
      "Accessor"
      (documentation 'grid-child-left-attach 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-child-left-attach container child) => left-attach}
  @syntax[]{(setf (gtk:grid-child-left-attach container child) left-attach)}
  @argument[container]{a @class{gtk:grid} widget}
  @argument[child]{a @class{gtk:widget} object}
  @argument[left-attach]{an integer with the left attach}
  @begin{short}
    Accessor of the @code{left-attach} child property of the @class{gtk:grid}
    class.
  @end{short}

  The column number to attach the left side of the child to.
  @see-class{gtk:grid}
  @see-class{gtk:widget}
  @see-function{gtk:grid-child-top-attach}")

;;; --- grid-child-top-attach --------------------------------------------------

(define-child-property grid-child-top-attach "top-attach" "gint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'grid-child-top-attach)
      "Accessor"
      (documentation 'grid-child-top-attach 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-child-top-attach container child) => top-attach}
  @syntax[]{(setf (gtk:grid-child-top-attach container child) top-attach)}
  @argument[container]{a @class{gtk:grid} widget}
  @argument[child]{a @class{gtk:widget} object}
  @argument[top-attach]{an integer with the top attach}
  @begin{short}
    Accessor of the @code{top-attach} child property of the @class{gtk:grid}
    class.
  @end{short}

  The row number to attach the top side of a child widget to.
  @see-class{gtk:grid}
  @see-class{gtk:widget}
  @see-function{gtk:grid-child-left-attach}")

;;; --- grid-child-width -------------------------------------------------------

(define-child-property grid-child-width "width" "gint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'grid-child-width)
      "Accessor"
      (documentation 'grid-child-width 'function)
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-child-width container child) => width}
  @syntax[]{(setf (gtk:grid-child-width container child) width)}
  @argument[container]{a @class{gtk:grid} widget}
  @argument[child]{a @class{gtk:widget} object}
  @argument[width]{an integer with the width}
  @begin{short}
    Accessor of the @code{width} child property of the @class{gtk:grid} class.
  @end{short}

  The number of columns that a child spans.
  @see-class{gtk:grid}
  @see-class{gtk:widget}
  @see-function{gtk:grid-child-height}")

;;; ----------------------------------------------------------------------------
;;; gtk_grid_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline grid-new))

(defun grid-new ()
 #+liber-documentation
 "@version{#2021-10-30}
  @return{The new @class{gtk:grid} widget.}
  @begin{short}
    Creates a new grid container.
  @end{short}
  @see-class{gtk:grid}"
  (make-instance 'grid))

(export 'grid-new)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_attach ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_grid_attach" grid-attach) :void
 #+liber-documentation
 "@version{#2021-12-17}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[child]{a @class{gtk:widget} object to add}
  @argument[left]{an integer with the column number to attach the left side of
    @arg{child} to}
  @argument[top]{an integer with the row number to attach the top side of
    @arg{child} to}
  @argument[width]{an integer with the number of columns that @arg{child} will
    span}
  @argument[height]{an integer with the number of rows that @arg{child} will
    span}
  @begin{short}
    Adds a child widget to the grid.
  @end{short}
  The position of the child widget is determined by the @arg{left} and
  @arg{top} arguments. The number of \"cells\" that the child widget will occupy
  is determined by the @arg{width} and @arg{height} arguments.
  @see-class{gtk:grid}
  @see-class{gtk:widget}
  @see-function{gtk:grid-attach-next-to}"
  (grid (g:object grid))
  (child (g:object widget))
  (left :int)
  (top :int)
  (width :int)
  (height :int))

(export 'grid-attach)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_attach_next_to ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_grid_attach_next_to" grid-attach-next-to) :void
 #+liber-documentation
 "@version{#2021-10-30}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[child]{the @class{gtk:widget} to add}
  @argument[sibling]{the @class{gtk:widget} child of grid that @arg{child} will
    be placed next to, or @code{nil} to place @arg{child} at the beginning or
    end}
  @argument[side]{the side of @arg{sibling} of type @symbol{gtk:position-type}
    that @arg{child} is positioned next to}
  @argument[width]{an integer with the number of columns that @arg{child} will
    span}
  @argument[height]{an integer with the number of rows that @arg{child} will
    span}
  @begin{short}
    Adds a child widget to the grid.
  @end{short}
  The child widget is placed next to @arg{sibling}, on the side determined
  by @arg{side}. When @arg{sibling} is @code{nil}, the child widget is
  placed in row, for left or right placement, or column 0, for top or bottom
  placement, at the end indicated by @arg{side}.
  @see-class{gtk:grid}
  @see-class{gtk:widget}
  @see-symbol{gtk:position-type}
  @see-function{gtk:grid-attach}"
  (grid (g:object grid))
  (child (g:object widget))
  (sibling (g:object widget))
  (side position-type)
  (width :int)
  (height :int))

(export 'grid-attach-next-to)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_get_child_at ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_grid_get_child_at" grid-child-at) (g:object widget)
 #+liber-documentation
 "@version{#2021-10-30}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[left]{an integer with the left edge of the cell}
  @argument[top]{an integer with the top edge of the cell}
  @return{The @class{gtk:widget} child at the given position, or @code{nil}.}
  @begin{short}
    Gets the child of the grid whose area covers the grid cell whose upper
    left corner is at @arg{left}, @arg{top}.
  @end{short}
  @see-class{gtk:grid}
  @see-class{gtk:widget}"
  (grid (g:object grid))
  (left :int)
  (top :int))

(export 'grid-child-at)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_insert_row ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_grid_insert_row" grid-insert-row) :void
 #+liber-documentation
 "@version{#2021-10-30}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[position]{an integer with the position to insert the row at}
  @begin{short}
    Inserts a row at the specified position.
  @end{short}
  Children which are attached at or below this position are moved one row down.
  Children which span across this position are grown to span the new row.
  @see-class{gtk:grid}
  @see-function{gtk:grid-insert-column}
  @see-function{gtk:grid-insert-next-to}"
  (grid (g:object grid))
  (position :int))

(export 'grid-insert-row)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_insert_column ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_grid_insert_column" grid-insert-column) :void
 #+liber-documentation
 "@version{#2021-10-30}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[position]{an integer with the position to insert the column at}
  @begin{short}
    Inserts a column at the specified position.
  @end{short}
  Children which are attached at or to the right of this position are
  moved one column to the right. Children which span across this position
  are grown to span the new column.
  @see-class{gtk:grid}
  @see-function{gtk:grid-insert-row}
  @see-function{gtk:grid-insert-next-to}"
  (grid (g:object grid))
  (position :int))

(export 'grid-insert-column)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_remove_row ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_grid_remove_row" grid-remove-row) :void
 #+liber-documentation
 "@version{#2021-10-30}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[position]{an integer with the position of the row to remove}
  @begin{short}
    Removes a row from the grid.
  @end{short}
  Children that are placed in this row are removed, spanning children that
  overlap this row have their height reduced by one, and children below the
  row are moved up.
  @see-class{gtk:grid}
  @see-function{gtk:grid-remove-column}
  @see-function{gtk:grid-insert-row}"
  (grid (g:object grid))
  (position :int))

(export 'grid-remove-row)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_remove_column ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_grid_remove_column" grid-remove-column) :void
 #+liber-documentation
 "@version{#2021-10-30}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[position]{an integer with the position of the column to remove}
  @begin{short}
    Removes a column from the grid.
  @end{short}
  Children that are placed in this column are removed, spanning children that
  overlap this column have their width reduced by one, and children after the
  column are moved to the left.
  @see-class{gtk:grid}
  @see-function{gtk:grid-remove-row}
  @see-function{gtk:grid-insert-column}"
  (grid (g:object grid))
  (position :int))

(export 'grid-remove-column)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_insert_next_to ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_grid_insert_next_to" grid-insert-next-to) :void
 #+liber-documentation
 "@version{#2021-10-30}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[sibling]{the @class{gtk:widget} child of @arg{grid} that the new
    row or column will be placed next to}
  @argument[side]{the side of type @symbol{gtk:position-type} of @arg{sibling}
    that @arg{child} is positioned next to}
  @begin{short}
    Inserts a row or column at the specified position.
  @end{short}
  The new row or column is placed next to @arg{sibling}, on the side determined
  by @arg{side}. If side is @code{:top} or @code{:bottom}, a row is inserted.
  If @arg{side} is @code{:left} of @code{:right}, a column is inserted.
  @see-class{gtk:grid}
  @see-class{gtk:widget}
  @see-symbol{gtk:position-type}
  @see-function{gtk:grid-insert-column}
  @see-function{gtk:grid-insert-row}"
  (grid (g:object grid))
  (sibling (g:object widget))
  (side position-type))

(export 'grid-insert-next-to)

;;; ----------------------------------------------------------------------------
;;; gtk_grid_get_row_baseline_position ()
;;; gtk_grid_set_row_baseline_position () -> grid-row-baseline-position
;;; ----------------------------------------------------------------------------

(defun (setf grid-row-baseline-position) (position grid row)
  (cffi:foreign-funcall "gtk_grid_set_row_baseline_position"
                   (g:object grid) grid
                   :int row
                   position-type position
                   :void)
  position)

(defcfun ("gtk_grid_get_row_baseline_position"
           grid-row-baseline-position) position-type
 #+liber-documentation
 "@version{#2021-10-30}
  @syntax[]{(gtk:grid-row-baseline-position grid row) => position}
  @syntax[]{(setf (gtk:grid-row-baseline-position grid row) position)}
  @argument[grid]{a @class{gtk:grid} widget}
  @argument[row]{an integer with a row index}
  @argument[position]{a value of the @symbol{gtk:positon-type} enumeration}
  @begin{short}
    Accessor of the baseline position of the @class{gtk:grid} widget.
  @end{short}

  The @sym{gtk:grid-row-baseline-position} function returns the baseline
  position of @arg{row} as set by the
  @sym{(setf gtk:grid-row-baseline-position)} function or the @code{:center}
  default value.
  @see-class{gtk:grid}
  @see-symbol{gtk:position-type}"
  (grid (g:object grid))
  (row :int))

(export 'grid-row-baseline-position)

;;; --- End of file gtk.grid.lisp ----------------------------------------------
