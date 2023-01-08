;;; ----------------------------------------------------------------------------
;;; gtk.table.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2022 Dieter Kaiser
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
;;; GtkTable
;;;
;;;     Pack widgets in regular patterns
;;;
;;; Types and Values
;;;
;;;     GtkTable
;;;     GtkAttachOptions
;;;
;;; Functions
;;;
;;;     gtk_table_new
;;;     gtk_table_resize
;;;     gtk_table_get_size
;;;     gtk_table_attach
;;;     gtk_table_attach_defaults
;;;     gtk_table_set_row_spacing
;;;     gtk_table_set_col_spacing
;;;     gtk_table_set_row_spacings
;;;     gtk_table_set_col_spacings
;;;     gtk_table_set_homogeneous
;;;     gtk_table_get_default_row_spacing
;;;     gtk_table_get_homogeneous
;;;     gtk_table_get_row_spacing
;;;     gtk_table_get_col_spacing
;;;     gtk_table_get_default_col_spacing
;;;
;;; Properties
;;;
;;;     column-spacing
;;;     homogeneous
;;;     n-columns
;;;     n-rows
;;;     row-spacing
;;;
;;; Child Properties
;;;
;;;     bottom-attach
;;;     left-attach
;;;     right-attach
;;;     top-attach
;;;     x-options
;;;     x-padding
;;;     y-options
;;;     y-padding
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkTable
;;;
;;; Implemented Interfaces
;;;
;;;     GtkTable implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkAttachOptions
;;; ----------------------------------------------------------------------------

(define-g-flags "GtkAttachOptions" attach-options
  (:export t
   :type-initializer "gtk_attach_options_get_type")
  (:expand 1)
  (:shrink 2)
  (:fill 4))

#+liber-documentation
(setf (liber:alias-for-symbol 'attach-options)
      "GFlags"
      (liber:symbol-documentation 'attach-options)
 "@version{#2021-5-26}
  @begin{short}
    Denotes the expansion properties that a widget will have in a
    @class{gtk:table} widget when it or its parent is resized.
  @end{short}
  @begin{pre}
(define-g-flags \"GtkAttachOptions\" attach-options
  (:export t
   :type-initializer \"gtk_attach_options_get_type\")
  (:expand 1)
  (:shrink 2)
  (:fill 4))
  @end{pre}
  @begin[code]{table}
    @entry[:expand]{The widget should expand to take up any extra space in its
      container that has been allocated.}
    @entry[:shrink]{The widget should shrink as and when possible.}
    @entry[:fill]{The widget should fill the space allocated to it.}
  @end{table}
  @see-class{gtk:table}")

;;; ----------------------------------------------------------------------------
;;; struct GtkTable
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkTable" table
  (:superclass container
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable")
   :type-initializer "gtk_table_get_type")
  ((column-spacing
    table-column-spacing
    "column-spacing" "guint" t t)
   (homogeneous
    table-homogeneous
    "homogeneous" "gboolean" t t)
   (n-columns
    table-n-columns
    "n-columns" "guint" t t)
   (n-rows
    table-n-rows
    "n-rows" "guint" t t)
   (row-spacing
    table-row-spacing
    "row-spacing" "guint" t t)))

#+liber-documentation
(setf (documentation 'table 'type)
 "@version{#2021-7-20}
  @begin{short}
    The @sym{gtk:table} widget allows the programmer to arrange widgets in
    rows and columns, making it easy to align many widgets next to each other,
    horizontally and vertically.
  @end{short}

  Tables are created with a call to the function @fun{gtk:table-new}, the size
  of which can later be changed with the function @fun{gtk:table-resize}.
  Widgets can be added to a table using the function @fun{gtk:table-attach}.

  To alter the space next to a specific row, use the function
  @fun{gtk:table-set-row-spacing}, and for a column the function
  @fun{gtk:table-set-col-spacing}. The gaps between all rows or columns can be
  changed by calling the functions @fun{gtk:table-row-spacing} or
  @fun{gtk:table-column-spacing} respectively. Note that spacing is added
  between the children, while padding added by the function
  @fun{gtk:table-attach} is added on either side of the widget it belongs to.

  The function @fun{gtk:table-homogeneous} can be used to set whether all
  cells in the table will resize themselves to the size of the largest widget
  in the table.
  @begin[Warning]{dictionary}
    The @sym{gtk:table} widget has been deprecated since GTK 3.4. Use the
    @class{gtk:grid} widget instead. It provides the same capabilities as the
    @sym{gtk:table} widget for arranging widgets in a rectangular grid, but
    does support height-for-width geometry management.
  @end{dictionary}
  @begin[Child Property Details]{dictionary}
    @begin[code]{table}
      @begin[bottom-attach]{entry}
        The @code{bottom-attach} child property of type @code{:uint}
        (Read / Write) @br{}
        The row number to attach the bottom of the child widget to. @br{}
        Allowed values: [1,65535] @br{}
        Default value: 1
      @end{entry}
      @begin[left-attach]{entry}
        The @code{left-attach} child property of type @code{:uint}
        (Read / Write) @br{}
        The column number to attach the left side of the child widget to. @br{}
        Allowed values: <= 65535 @br{}
        Default value: 0
      @end{entry}
      @begin[right-attach]{entry}
        The @code{right-attach} child property of type @code{:uint}
        (Read / Write) @br{}
        The column number to attach the right side of a child widget to. @br{}
        Allowed values: [1,65535] @br{}
        Default value: 1
      @end{entry}
      @begin[top-attach]{entry}
        The @code{top-attach} child property of type @code{:uint}
        (Read / Write) @br{}
        The row number to attach the top of a child widget to. @br{}
        Allowed values: <= 65535 @br{}
        Default value: 0
      @end{entry}
      @begin[x-options]{entry}
        The @code{x-options} child property of type @symbol{gtk:attach-options}
        (Read / Write) @br{}
        Options specifying the horizontal behaviour of the child widget. @br{}
        Default value: @code{'(:expand :fill)}
      @end{entry}
      @begin[x-padding]{entry}
        The @code{x-padding} child property of type @code{:uint}
        (Read / Write) @br{}
        Extra space to put between the child widget and its left and right
        neighbors, in pixels. @br{}
        Allowed values: <= 65535 @br{}
        Default value: 0
      @end{entry}
      @begin[y-options]{entry}
        The @code{y-options} child property of type @symbol{gtk:attach-options}
        (Read / Write) @br{}
        Options specifying the vertical behaviour of the child widget. @br{}
        Default value: @code{'(:expand :fill)}
      @end{entry}
      @begin[y-padding]{entry}
        The @code{y-padding} child property of type @code{:uint}
        (Read / Write) @br{}
        Extra space to put between the child widget and its upper and lower
        neighbors, in pixels. @br{}
        Allowed values: <= 65535 @br{}
        Default value: 0
      @end{entry}
    @end{table}
  @end{dictionary}
  @see-slot{gtk:table-column-spacing}
  @see-slot{gtk:table-homogeneous}
  @see-slot{gtk:table-n-columns}
  @see-slot{gtk:table-n-rows}
  @see-slot{gtk:table-row-spacing}
  @see-class{gtk:grid}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- table-column-spacing -----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "column-spacing" 'table) t)
 "The @code{column-spacing} property of type @code{:uint}
  (Read / Write) @br{}
  The amount of space between two consecutive columns. @br{}
  Allowed values: <= 65535 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'table-column-spacing)
      "Accessor"
      (documentation 'table-column-spacing 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-column-spacing object) => spacing}
  @syntax[]{(setf (gtk:table-column-spacing object) spacing)}
  @argument[table]{a @class{gtk:table} widget}
  @argument[spacing]{an unsigned integer with the number of pixels of space to
    place between every column in the table}
  @begin{short}
    Accessor of the @slot[gtk:table]{column-spacing} property of the
    @class{gtk:table} class.
  @end{short}

  The slot access function @sym{gtk:table-column-spacing} gets the default
  column spacing for the table. The slot access function
  @sym{(setf gtk:table-column-spacing)} sets the column spacing. This is the
  spacing that will be used for newly added columns.
  @begin[Lisp implementation]{dictionary}
    The C library has the functions @code{gtk_table_get_default_col_spacing ()}
    and @code{gtk_table_set_col_spacings ()}, which correspond to the
    slot access function @sym{gtk:table-column-spacing}. These C functions are
    not implemented in the Lisp library.
  @end{dictionary}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-column-spacing} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the
    @class{gtk:grid} widget with the function @fun{gtk:grid-column-spacing}.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}
  @see-function{gtk:grid-column-spacing}")

;;; --- table-homogeneous -------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "homogeneous" 'table) t)
 "The @code{homogeneous} property of type @code{:boolean}
  (Read / Write) @br{}
  If @em{true}, the table cells are all the same width/height. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'table-homogeneous)
      "Accessor"
      (documentation 'table-homogeneous 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-homogeneous object) => homogeneous}
  @syntax[]{(setf (gtk:table-homogeneous object) homogeneous)}
  @argument[object]{a @class{gtk:table} widget}
  @argument[homogeneous]{set to @em{true} to ensure all table cells are the
    same size, set to @em{false} if this is not the desired behaviour}
  @begin{short}
    Accessor of the @slot[gtk:table]{homogeneous} slot of the
    @class{gtk:table} class.
  @end{short}

  The slot access function @sym{gtk:table-homogeneous} returns whether the
  table cells are all constrained to the same width and height. The slot access
  function @sym{(setf gtk:table-homogeneous)} changes the
  @slot[gtk:table]{homogeneous} property.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-homogeneous} has been deprecated since version
    3.4 and should not be used in newly written code. Use the @class{gtk:grid}
    widget with the functions @fun{gtk:grid-row-homogeneous} and
    @fun{gtk:grid-column-homogeneous}.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}
  @see-function{gtk:grid-column-homogeneous}
  @see-function{gtk:grid-row-homogeneous}")

;;; --- table-n-columns ----------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "n-columns" 'table) t)
 "The @code{n-columns} property of type @code{:uint} (Read / Write) @br{}
  The number of columns in the table. @br{}
  Allowed values: [1,65535] @br{}
  Default value: 1")

#+liber-documentation
(setf (liber:alias-for-function 'table-n-columns)
      "Accessor"
      (documentation 'table-n-columns 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-n-columns object) => n-columns}
  @syntax[]{(setf (gtk:table-n-columns object) n-columns)}
  @argument[object]{a @class{gtk:table} widget}
  @argument[n-columns]{an unsigned integer with the number of columns}
  @begin{short}
    Accessor of the @slot[gtk:table]{n-columns} slot of the @class{gtk:table}
    class.
  @end{short}

  The number of columns in the table.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-n-columns} has been deprecated since version
    3.4 and should not be used in newly written code. Use the @class{gtk:grid}
    widget which does not expose the number of columns and rows.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}")

;;; --- table-n-rows -------------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "n-rows" 'table) t)
 "The @code{n-rows} property of type @code{:uint} (Read / Write) @br{}
  The number of rows in the table. @br{}
  Allowed values: [1,65535] @br{}
  Default value: 1")

#+liber-documentation
(setf (liber:alias-for-function 'table-n-rows)
      "Accessor"
      (documentation 'table-n-rows 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-n-rows object) => n-rows}
  @syntax[]{(setf (gtk:table-n-rows object) n-rows)}
  @argument[object]{a @class{gtk:table} widget}
  @argument[n-rows]{an unsigned integer with the number of rows}
  @begin{short}
    Accessor of the @slot[gtk:table]{n-rows} slot of the @class{gtk:table}
    class.
  @end{short}

  The number of rows in the table.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-n-rows} has been deprecated since version 3.4
    and should not be used in newly written code. Use the @class{gtk:grid}
    widget which does not expose the number of columns and rows.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}")

;;; --- table-row-spacing --------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "row-spacing" 'table) t)
 "The @code{row-spacing} property of type @code{:uint}  (Read / Write) @br{}
  The amount of space between two consecutive rows. @br{}
  Allowed values: <= 65535 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'table-row-spacing)
      "Accessor"
      (documentation 'table-row-spacing 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-row-spacing object) => spacing}
  @syntax[]{(setf (gtk:table-row-spacing object) spacing)}
  @argument[table]{a @class{gtk:table} widget}
  @argument[spacing]{an unsigned integer with the number of pixels of space to
    place between every row in the table}
  @begin{short}
    Accessor of the @slot[gtk:table]{row-spacing} slot of the
    @class{gtk:table} class.
  @end{short}

  The slot access function @sym{gtk:table-row-spacing} gets the default row
  spacing for the table. The slot access function @sym{gtk:table-row-spacing}
  sets the row spacing. This is the spacing that will be used for newly added
  rows.
  @begin[Lisp implementation]{dictionary}
    The C library has the functions @code{gtk_table_get_default_row_spacing ()}
    and @code{gtk_table_set_row_spacings ()}, which correspond to the
    slot access function @sym{gtk:table-row-spacing}. These C functions are not
    implemented in the Lisp library.
  @end{dictionary}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-row-spacing} has been deprecated since version
    3.4 and should not be used in newly written code. Use the @class{gtk:grid}
    widget with the function @fun{gtk:grid-row-spacing}.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}
  @see-function{gtk:grid-row-spacing}")

;;; ----------------------------------------------------------------------------
;;; Accessors of Child Properties
;;; ----------------------------------------------------------------------------

;;; --- table-child-bottom-attach ----------------------------------------------

(define-child-property table-child-bottom-attach "bottom-attach" "guint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'table-child-bottom-attach)
      "Accessor"
      (documentation 'table-child-bottom-attach 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-child-bottom-attach container child) => attach}
  @syntax[]{(setf (gtk:table-child-bottom-attach container child) attach)}
  @argument[container]{a @class{gtk:table} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[attach]{an unsigned integer with the row number to attach the
    bottom of the child widget to}
  @begin{short}
    Accessor of the @code{bottom-attach} child property of the
    @class{gtk:table} class.
  @end{short}

  The row number to attach the bottom of the child widget to.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-child-bottom-attach} has been deprecated since
    version 3.4. and should not be used in newly written code. Use the
    @class{gtk:grid} widget instead.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:widget}
  @see-class{gtk:grid}")

;;; --- table-child-left-attach ------------------------------------------------

(define-child-property table-child-left-attach "left-attach" "guint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'table-child-left-attach)
      "Accessor"
      (documentation 'table-child-left-attach 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-child-left-attach container child) => attach}
  @syntax[]{(setf (gtk:table-child-left-attach container child) attach)}
  @argument[container]{a @class{gtk:table} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[attach]{an unsigned integer with the column number to attach the
    left side of the child widget to}
  @begin{short}
    Accessor of the @code{left-attach} child property of the @class{gtk:table}
    class.
  @end{short}

  The column number to attach the left side of the child widget to.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-child-left-attach} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the
    @class{gtk:grid} widget instead.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:widget}
  @see-class{gtk:grid}")

;;; --- table-child-right-attach -----------------------------------------------

(define-child-property table-child-right-attach "right-attach" "guint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'table-child-right-attach)
      "Accessor"
      (documentation 'table-child-right-attach 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-child-right-attach container child) => attach}
  @syntax[]{(setf (gtk:table-child-right-attach container child) attach)}
  @argument[container]{a @class{gtk:table} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[attach]{an unsigned integer with the column number to attach the
    right side of the child widget to}
  @begin{short}
    Accessor of the @code{right-attach} child property of the @class{gtk:table}
    class.
  @end{short}

  The column number to attach the right side of the child widget to.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-child-right-attach} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the
    @class{gtk:grid} widget instead.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:widget}
  @see-class{gtk:grid}")

;;; --- table-child-top-attach -------------------------------------------------

(define-child-property table-child-top-attach "top-attach" "guint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'table-child-top-attach)
      "Accessor"
      (documentation 'table-child-top-attach 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-child-top-attach container child) => attach}
  @syntax[]{(setf (gtk:table-child-top-attach container child) attach)}
  @argument[container]{a @class{gtk:table} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[attach]{an unsigned integer with the row number to attach the top
    of the child widget to}
  @begin{short}
    Accessor of the @code{top-attach} child property of the @class{gtk:table}
    class.
  @end{short}

  The row number to attach the top of the child widget to.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-child-top-attach} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the
    @class{gtk:grid} widget instead.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:widget}
  @see-class{gtk:grid}")

;;; --- table-child-x-options --------------------------------------------------

(define-child-property table-child-x-options
                       "x-options" "GtkAttachOptions" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'table-child-x-options)
      "Accessor"
      (documentation 'table-child-x-options 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-child-x-options container child) => options}
  @syntax[]{(setf (gtk:table-child-x-options container child) options)}
  @argument[container]{a @class{gtk:table} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[options]{the @symbol{gtk:attach-options} flags}
  @begin{short}
    Accessor of the @code{x-options} child property of the @class{gtk:table}
    class.
  @end{short}

  Options specifying the horizontal behaviour of the child widget.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-child-x-options} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the
    @class{gtk:grid} widget instead.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:widget}
  @see-class{gtk:grid}
  @see-symbol{gtk:attach-options}")

;;; --- table-child-y-options --------------------------------------------------

(define-child-property table-child-y-options
                       "y-options" "GtkAttachOptions" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'table-child-y-options)
      "Accessor"
      (documentation 'table-child-y-options 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-child-y-options container child) => options}
  @syntax[]{(setf (gtk:table-child-y-options container child) options)}
  @argument[container]{a @class{gtk:table} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[options]{the @symbol{gtk:attach-options} flags}
  @begin{short}
    Accessor of the @code{y-options} child property of the @class{gtk:table}
    class.
  @end{short}

  Options specifying the vertical behaviour of the child widget.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-child-y-options} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the
    @class{gtk:grid} widget instead.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:widget}
  @see-class{gtk:grid}
  @see-symbol{gtk:attach-options}")

;;; --- table-child-x-padding --------------------------------------------------

(define-child-property table-child-x-padding "x-padding" "guint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'table-child-x-padding)
      "Accessor"
      (documentation 'table-child-x-padding 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-child-x-padding container child) => padding}
  @syntax[]{(setf (gtk:table-child-x-padding container child) padding)}
  @argument[container]{a @class{gtk:table} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[padding]{an unsigned integer with the space to put between the
    child widget and its neighbors}
  @begin{short}
    Accessor of the @code{x-padding} child property of the @class{gtk:table}
    class.
  @end{short}

  Extra space to put between the child widget and its left and right neighbors,
  in pixels.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-child-x-padding} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the
    @class{gtk:grid} widget instead.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:widget}
  @see-class{gtk:grid}")

;;; --- table-child-y-padding --------------------------------------------------

(define-child-property table-child-y-padding "y-padding" "guint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'table-child-y-padding)
      "Accessor"
      (documentation 'table-child-y-padding 'function)
 "@version{#2021-7-20}
  @syntax[]{(gtk:table-child-y-padding container child) => padding}
  @syntax[]{(setf (gtk:table-child-y-padding container child) padding)}
  @argument[container]{a @class{gtk:table} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[padding]{an unsigned integer with the space to put between the
    child widget and its neighbors}
  @begin{short}
    Accessor of the @code{y-padding} child property of the @class{gtk:table}
    class.
  @end{short}

  Extra space to put between the child widget and its upper and lower
  neighbors, in pixels.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-child-y-padding} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the
    @class{gtk:grid} widget instead.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:widget}
  @see-class{gtk:grid}")

;;; ----------------------------------------------------------------------------
;;; gtk_table_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline table-new))

(defun table-new (rows columns homogeneous)
 #+liber-documentation
 "@version{#2021-7-20}
  @argument[rows]{an unsigned integer with the number of rows the new table
    should have}
  @argument[columns]{an unsigned integer with the number of columns the new
    table should have}
  @argument[homogeneous]{if set to @em{true}, all table cells are resized to
    the size of the cell containing the largest widget}
  @return{The the newly created @class{gtk:table} widget.}
  @begin{short}
    Used to create a new table.
  @end{short}
  An initial size must be given by specifying how many rows and columns the
  table should have, although this can be changed later with the function
  @fun{gtk:table-resize}. The arguments @arg{rows} and @arg{columns} must both
  be in the range 1 ... 65535. For historical reasons, 0 is accepted as well
  and is silently interpreted as 1.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-new} has been deprecated since version 3.4 and
    should not be used in newly written code. Use the @class{gtk:grid} widget
    with the function @fun{gtk:grid-new}.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}
  @see-function{gtk:table-resize}
  @see-function{gtk:grid-new}"
  (make-instance 'table
                 :rows rows
                 :columns columns
                 :homogeneous homogeneous))

(export 'table-new)

;;; ----------------------------------------------------------------------------
;;; gtk_table_resize ()
;;; ----------------------------------------------------------------------------

(declaim (inline table-resize))

(defun table-resize (table rows columns)
 #+liber-documentation
 "@version{#2021-7-20}
  @argument[table]{the @class{gtk:table} widget you wish to change the size of}
  @argument[rows]{an unsigned integer with the new number of rows}
  @argument[columns]{an unsigned integer with the new number of columns}
  @begin{short}
    If you need to change the size of the table after it has been created, this
    function allows you to do so.
  @end{short}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-resize} has been deprecated since version 3.4
    and should not be used in newly written code. Use the @class{gtk:grid}
    widget which resizes automatically.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}"
  (setf (table-n-rows table) rows
        (table-n-columns table) columns))

(export 'table-resize)

;;; ----------------------------------------------------------------------------
;;; gtk_table_get_size () -> table-size
;;; ----------------------------------------------------------------------------

(defun table-size (table)
 #+liber-documentation
 "@version{#2021-7-20}
  @argument[table]{a @class{gtk:table} widget}
  @begin{return}
    @code{n-rows}    -- an unsigned integer with the number of rows @br{}
    @code{n-columns} -- an unsigned integer with the number of columns
  @end{return}
  @short{Gets the number of rows and columns in the table.}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-size} has been deprecated since version 3.4
    and should not be used in newly written code. Use the @class{gtk:grid}
    widget which does not expose the number of columns and rows.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}"
  (values (table-n-rows table)
          (table-n-columns table)))

(export 'table-size)

;;; ----------------------------------------------------------------------------
;;; gtk_table_attach ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_table_attach" %table-attach) :void
  (table (g:object table))
  (child (g:object widget))
  (left :uint)
  (right :uint)
  (top :uint)
  (bottom :uint)
  (x-options attach-options)
  (y-options attach-options)
  (x-padding :uint)
  (y-padding :uint))

(defun table-attach (table child left right top bottom
                                     &key (x-options '(:expand :fill))
                                          (y-options '(:expand :fill))
                                          (x-padding 0)
                                          (y-padding 0))
 #+liber-documentation
 "@version{#2021-7-20}
  @argument[table]{the @class{gtk:table} widget to add a new widget to}
  @argument[child]{the @class{gtk:widget} child widget to add}
  @argument[left]{an unsigned integer with the column number to attach the left
    side of a child widget to}
  @argument[right]{an unsigned integer with the column number to attach the
    right side of a child widget to}
  @argument[top]{an unsigned ineger with the row number to attach the top of a
    child widget to}
  @argument[bottom]{an unsigned integer with the row number to attach the bottom
    of a child widget to}
  @argument[x-options]{the @symbol{gtk:attach-options} flags used to specify the
    properties of the child widget when the table is resized}
  @argument[y-options]{the same as @arg{x-options}, except this field
    determines behaviour of vertical resizing}
  @argument[x-padding]{an unsigned integer specifying the padding on the left
    and right of the child widget being added to the table}
  @argument[y-padding]{an unsigned integer with the amount of padding above and
    below the child widget}
  @begin{short}
    Adds a child widget to a table.
  @end{short}
  The number of cells that a child widget will occupy is specified by the
  arguments @arg{left}, @arg{right}, @arg{top} and @arg{bottom}. These each
  represent the leftmost, rightmost, uppermost and lowest column and row
  numbers of the table. Columns and rows are indexed from zero.

  The keyword arguments @code{x-options} and @code{y-options} have the default
  value @code{'(:expand :fill)}. The keyword arguments @code{x-padding} and
  @code{y-padding} have the default value 0.
  @begin[Example]{dictionary}
    To make a button occupy the lower right cell of a 2 x 2 table, use
    @begin{pre}
 (gtk:table-attach table button 1 2 1 2)
    @end{pre}
    If you want to make the button span the entire bottom row, use
    @begin{pre}
 (gtk:table-attach table button 0 2 1 2)
    @end{pre}
  @end{dictionary}
  @begin[Lisp implementation]{dictionary}
    The C library has the function @code{gtk_table_attach_default ()}. This
    function is included in the Lisp library via keyword arguments with default
    values for the function @sym{gtk:table-attach}.
  @end{dictionary}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-attach} has been deprecated since version 3.4
    and should not be used in newly written code. Use the @class{gtk:grid}
    widget with the function @fun{gtk:grid-attach}. Note that the attach
   arguments differ between those two functions.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}
  @see-symbol{gtk:attach-options}
  @see-function{gtk:grid-attach}"
  (%table-attach table child
                     left right top bottom
                     x-options y-options
                     x-padding y-padding))

(export 'table-attach)

;;; ----------------------------------------------------------------------------
;;; gtk_table_attach_defaults ()                           not exported
;;; ----------------------------------------------------------------------------

(defun table-attach-defaults (table child left right top bottom)
 #+liber-documentation
 "@version{#2020-1-20}
  @argument[table]{the table to add a new child widget to}
  @argument[widget]{the child widget to add}
  @argument[left-attach]{the column number to attach the left side of the child
    widget to}
  @argument[right-attach]{the column number to attach the right side of the
    child widget to}
  @argument[top-attach]{the row number to attach the top of the child widget
    to}
  @argument[bottom-attach]{the row number to attach the bottom of the child
    widget to}
  @begin{short}
    As there are many options associated with the function
    @fun{gtk:table-attach}, this convenience function provides the programmer
    with a means to add children to a table with identical padding and
    expansion options.
  @end{short}
  The values used for the @symbol{gtk:attach-options} are
  @code{'(:expand :fill)}, and the padding is set to 0.
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-attach-defaults} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the function
    @fun{gtk:grid-attach} with @class{gtk:grid}. Note that the attach arguments
    differ between those two functions.
  @end{dictionary}
  @see-class{gtk:table}"
  (table-attach table child left right top bottom))

;;; ----------------------------------------------------------------------------
;;; gtk_table_set_row_spacing ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_table_set_row_spacing" table-set-row-spacing) :void
 #+liber-documentation
 "@version{#2021-7-20}
  @argument[table]{a @class{gtk:table} widget containing the row whose
    properties you wish to change}
  @argument[row]{an unsigned integer with the row number whose spacing will be
    changed}
  @argument[spacing]{an unsigned integer with the number of pixels that the
    spacing should take up}
  @begin{short}
    Changes the space between a given table row and the subsequent row.
  @end{short}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-set-row-spacing} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the functions
    @fun{gtk:widget-margin-top} and @fun{gtk:widget-margin-bottom} on the
    widgets contained in the row if you need this functionality.
    The @class{gtk:grid} widget does not support per-row spacing.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}
  @see-function{gtk:widget-margin-top}
  @see-function{gtk:widget-margin-bottom}"
  (table (g:object table))
  (row :uint)
  (spacing :uint))

(export 'table-set-row-spacing)

;;; ----------------------------------------------------------------------------
;;; gtk_table_set_col_spacing ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_table_set_col_spacing" table-set-col-spacing) :void
 #+liber-documentation
 "@version{#2021-7-20}
  @argument[table]{a @class{gtk:table} widget}
  @argument[column]{an unsigned integer with the column whose spacing should be
    changed}
  @argument[spacing]{an unsigned integer with the number of pixels that the
    spacing should take up}
  @begin{short}
    Alters the amount of space between a given table column and the following
    column.
  @end{short}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-set-col-spacing} has been deprecated since
    version 3.4 and should not be used in newly written code. Use the functions
    @fun{gtk:widget-margin-start} and @fun{gtk:widget-margin-end} on
    the widgets contained in the row if you need this functionality.
    The @class{gtk:grid} widget does not support per-column spacing.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}
  @see-function{gtk:widget-margin-start}
  @see-function{gtk:widget-margin-end}"
  (table (g:object table))
  (column :uint)
  (spacing :uint))

(export 'table-set-col-spacing)

;;; ----------------------------------------------------------------------------
;;; gtk_table_get_row_spacing ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_table_get_row_spacing" table-get-row-spacing) :uint
 #+liber-documentation
 "@version{#2021-7-20}
  @argument[table]{a @class{gtk:table} widget}
  @argument[row]{an unsigned integer with a row in the table, 0 indicates the
    first row}
  @return{An unsigned integer with the row spacing.}
  @begin{short}
    Gets the amount of space between @arg{row}, and @arg{row + 1}.
  @end{short}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-get-row-spacing} has been deprecated since
    version 3.4 and should not be used in newly written code. The
    @class{gtk:grid} widget does not offer a replacement for this functionality.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}"
  (table (g:object table))
  (row :uint))

(export 'table-get-row-spacing)

;;; ----------------------------------------------------------------------------
;;; gtk_table_get_col_spacing ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_table_get_col_spacing" table-get-col-spacing) :uint
 #+liber-documentation
 "@version{#2021-7-20}
  @argument[table]{a @class{gtk:table} widget}
  @argument[column]{an unsigned integer with a column in the table, 0 indicates
    the first column}
  @return{An unsigned integer with the column spacing.}
  @begin{short}
    Gets the amount of space between @arg{column}, and @arg{column + 1}.
  @end{short}
  @begin[Warning]{dictionary}
    The function @sym{gtk:table-get-col-spacing} has been deprecated since
    version 3.4 and should not be used in newly written code. The
    @class{gtk:grid} widget does not offer a replacement for this functionality.
  @end{dictionary}
  @see-class{gtk:table}
  @see-class{gtk:grid}"
  (table (g:object table))
  (column :uint))

(export 'table-get-col-spacing)

;;; --- End of file gtk.table.lisp ---------------------------------------------
