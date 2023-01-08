;;; ----------------------------------------------------------------------------
;;; gtk.size-group.lisp
;;;
;;; The documentation of this file is taken from the GTK+ 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2019 Dieter Kaiser
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
;;; GtkSizeGroup
;;;
;;;     Grouping widgets so they request the same size
;;;
;;; Types and Values
;;;
;;;     GtkSizeGroup
;;;     GtkSizeGroupMode
;;;
;;; Functions
;;;
;;;     gtk_size_group_new
;;;     gtk_size_group_set_mode
;;;     gtk_size_group_get_mode
;;;     gtk_size_group_set_ignore_hidden
;;;     gtk_size_group_get_ignore_hidden
;;;     gtk_size_group_add_widget
;;;     gtk_size_group_remove_widget
;;;     gtk_size_group_get_widgets
;;;
;;; Properties
;;;
;;;             gboolean    ignore-hidden    Read / Write
;;;     GtkSizeGroupMode    mode             Read / Write
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GtkSizeGroup
;;;
;;; Implemented Interfaces
;;;
;;;     GtkSizeGroup implements GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkSizeGroupMode
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkSizeGroupMode" size-group-mode
  (:export t
   :type-initializer "gtk_size_group_mode_get_type")
  (:none 0)
  (:horizontal 1)
  (:vertical 2)
  (:both 3))

#+liber-documentation
(setf (liber:alias-for-symbol 'size-group-mode)
      "GEnum"
      (liber:symbol-documentation 'size-group-mode)
 "@version{#2020-6-3}
  @begin{short}
    The mode of the size group determines the directions in which the size
    group affects the requested sizes of its component widgets.
  @end{short}
  @begin{pre}
(define-g-enum \"GtkSizeGroupMode\" size-group-mode
  (:export t
   :type-initializer \"gtk_size_group_mode_get_type\")
  (:none 0)
  (:horizontal 1)
  (:vertical 2)
  (:both 3))
  @end{pre}
  @begin[code]{table}
    @entry[:none]{Group has no effect.}
    @entry[:horizontal]{Group affects horizontal requisition.}
    @entry[:vertical]{Group affects vertical requisition.}
    @entry[:both]{Group affects both horizontal and vertical requisition.}
  @end{table}
  @see-class{gtk:size-group}")

;;; ----------------------------------------------------------------------------
;;; struct GtkSizeGroup
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkSizeGroup" size-group
  (:superclass g:object
    :export t
    :interfaces ("GtkBuildable")
    :type-initializer "gtk_size_group_get_type")
  ((ignore-hidden
    size-group-ignore-hidden
    "ignore-hidden" "gboolean" t t)
   (mode
    size-group-mode
    "mode" "GtkSizeGroupMode" t t)))

#+liber-documentation
(setf (documentation 'size-group 'type)
 "@version{#2020-6-3}
  @begin{short}
    @sym{gtk:size-group} provides a mechanism for grouping a number of widgets
    together so they all request the same amount of space. This is typically
    useful when you want a column of widgets to have the same size, but you
    cannot use a @class{gtk:grid} widget.
  @end{short}

  In detail, the size requested for each widget in a @sym{gtk:size-group} is
  the maximum of the sizes that would have been requested for each widget in
  the size group if they were not in the size group. The mode of the size
  group, see the function @fun{gtk:size-group-mode}, determines whether this
  applies to the horizontal size, the vertical size, or both sizes.

  Note that size groups only affect the amount of space requested, not the
  size that the widgets finally receive. If you want the widgets in a
  @sym{gtk:size-group} to actually be the same size, you need to pack them in
  such a way that they get the size they request and not more. For example, if
  you are packing your widgets into a table, you would not include the
  @code{:fill} flag.

  @sym{gtk:size-group} objects are referenced by each widget in the size group,
  so once you have added all widgets to a @sym{gtk:size-group}, you can drop the
  initial reference to the size group with the function @fun{g:object-unref}. If
  the widgets in the size group are subsequently destroyed, then they will be
  removed from the size group and drop their references on the size group. When
  all widgets have been removed, the size group will be freed.

  Widgets can be part of multiple size groups. GTK+ will compute the
  horizontal size of a widget from the horizontal requisition of all widgets
  that can be reached from the widget by a chain of size groups of type
  @code{:horizontal} or @code{:both}, and the vertical size from the vertical
  requisition of all widgets that can be reached from the widget by a chain of
  size groups of type @code{:vertical} or @code{:both}.

  Note that only non-contextual sizes of every widget are ever consulted by
  size groups, since size groups have no knowledge of what size a widget will
  be allocated in one dimension, it cannot derive how much height a widget
  will receive for a given width. When grouping widgets that trade height for
  width in mode @code{:vertical} or @code{:both}: the height for the minimum
  width will be the requested height for all widgets in the group. The same is
  of course true when horizontally grouping width for height widgets.

  Widgets that trade height-for-width should set a reasonably large minimum
  width by way of \"width-chars\" for instance. Widgets with static sizes as
  well as widgets that grow (such as ellipsizing text) need no such
  considerations.
  @begin[GtkSizeGroup as GtkBuildable]{dictionary}
    Size groups can be specified in a UI definition by placing an
    @code{<object>} element with class \"GtkSizeGroup\" somewhere in the UI
    definition. The widgets that belong to the size group are specified by a
    @code{<widgets>} element that may contain multiple @code{<widget>} elements,
    one for each member of the size group. The name attribute gives the ID of
    the widget.

    @b{Example:} A UI definition fragment with @sym{gtk:size-group}
    @begin{pre}
   <object class=\"GtkSizeGroup\">
     <property name=\"mode\">GTK_SIZE_GROUP_HORIZONTAL</property>
     <widgets>
       <widget name=\"radio1\"/>
       <widget name=\"radio2\"/>
     </widgets>
   </object>
    @end{pre}
  @end{dictionary}
  @see-slot{gtk:size-group-ignore-hidden}
  @see-slot{gtk:size-group-mode}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- size-group-ignore-hidden -------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "ignore-hidden" 'size-group) t)
 "The @code{ignore-hidden} property of type @code{:boolean} (Read / Write) @br{}
  If @em{true}, unmapped widgets are ignored when determining the size of the
  group. @br{}
  @em{Warning:} The @code{ignore-hidden} property has been deprecated since
  version 3.22 and should not be used in newly written code. Measuring the size
  of hidden widgets has not worked reliably for a long time. In most cases, they
  will report a size of 0 nowadays, and thus, their size will not affect the
  other size group members. In effect, size groups will always operate as if
  this property was @em{true}. Use a @class{gtk:stack} widget instead to hide
  widgets while still having their size taken into account. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'size-group-ignore-hidden)
      "Accessor"
      (documentation 'size-group-ignore-hidden 'function)
 "@version{#2020-6-3}
  @syntax[]{(gtk:size-group-ignore-hidden object) => ignore-hidden}
  @syntax[]{(setf (gtk:size-group-ignore-hidden object) ignore-hidden)}
  @argument[size-group]{a @class{gtk:size-group} object}
  @argument[ignore-hidden]{a boolean whether unmapped widgets should be ignored
    when calculating the size}
  @begin{short}
    Accessor of the @slot[gtk:size-group]{ignore-hidden} slot of the
    @class{gtk:size-group} class.
  @end{short}

  The slot access function @sym{gtk:size-group-ignore-hidden} returns if
  invisible widgets are ignored when calculating the size. The slot access
  function @sym{(setf gtk:size-group-ignore-hidden)} sets whether unmapped
  widgets should be ignored when calculating the size.
  @begin[Warning]{dictionary}
    The @sym{gtk:size-group-ignore-hidden} function has been deprecated since
    version 3.22 and should not be used in newly written code. Measuring the
    size of hidden widgets has not worked reliably for a long time. In most
    cases, they will report a size of 0 nowadays, and thus, their size will not
    affect the other size group members. In effect, size groups will always
    operate as if this property was @em{true}. Use a @class{gtk:stack} widget
    instead to hide widgets while still having their size taken into account.
  @end{dictionary}
  @see-class{gtk:size-group}")

;;; --- size-group-mode ----------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "mode" 'size-group) t)
 "The @code{mode} property of type @symbol{gtk:size-group-mode} (Read / Write)
  @br{}
  The directions in which the size group affects the requested sizes of its
  component widgets. @br{}
  Default value: @code{:horizontal}")

#+liber-documentation
(setf (liber:alias-for-function 'size-group-mode)
      "Accessor"
      (documentation 'size-group-mode 'function)
 "@version{#2020-6-3}
  @syntax[]{(gtk:size-group-mode object) => mode}
  @syntax[]{(setf (gtk:size-group-mode object) mode)}
  @argument[size-group]{a @class{gtk:size-group} object}
  @argument[mode]{a @symbol{gtk:size-group-mode} value to set for the size
    group}
  @begin{short}
    Accessor of the @slot[gtk:size-group]{mode} slot of the
    @class{gtk:size-group} class.
  @end{short}

  The slot access function @sym{gtk:size-group-mode} gets the current mode of
  the size group. The slot access function @sym{(setf gtk:size-group-mode)} sets
  the mode of the size group.

  The mode of the size group determines whether the widgets in the size group
  should all have the same horizontal requisition, @code{:horizontal}, all have
  the same vertical requisition, @code{:vertical}, or should all have the same
  requisition in both directions, @code{:both}.
  @see-class{gtk:size-group}")

;;; ----------------------------------------------------------------------------
;;; gtk_size_group_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline size-group-new))

(defun size-group-new (mode)
 #+liber-documentation
 "@version{#2020-6-3}
  @argument[mode]{the @symbol{gtk:size-group-mode} value for the new size group}
  @return{A newly created @class{gtk:size-group} object.}
  @begin{short}
    Create a new size group.
  @end{short}
  @see-class{gtk:size-group}
  @see-symbol{gtk:size-group-mode}"
  (make-instance 'size-group
                 :mode mode))

(export 'size-group-new)

;;; ----------------------------------------------------------------------------
;;; gtk_size_group_add_widget ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_size_group_add_widget" size-group-add-widget) :void
 #+liber-documentation
 "@version{#2020-6-3}
  @argument[size-group]{a @class{gtk:size-group} object}
  @argument[widget]{the @class{gtk:widget} to add}
  @begin{short}
    Adds a widget to a @class{gtk:size-group} object.
  @end{short}
  In the future, the requisition of the widget will be determined as the maximum
  of its requisition and the requisition of the other widgets in the size group.
  Whether this applies horizontally, vertically, or in both directions depends
  on the mode of the size group. See the function @fun{gtk:size-group-mode}.

  When the widget is destroyed or no longer referenced elsewhere, it will be
  removed from the size group.
  @see-class{gtk:size-group}
  @see-function{gtk:size-group-mode}"
  (size-group (g:object size-group))
  (widget (g:object widget)))

(export 'size-group-add-widget)

;;; ----------------------------------------------------------------------------
;;; gtk_size_group_remove_widget ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_size_group_remove_widget" size-group-remove-widget) :void
 #+liber-documentation
 "@version{#2020-6-3}
  @argument[size-group]{a @class{gtk:size-group} object}
  @argument[widget]{the @class{gtk:widget} to remove}
  @begin{short}
    Removes a widget from a size group.
  @end{short}
  @see-class{gtk:size-group}"
  (size-group (g:object size-group))
  (widget (g:object widget)))

(export 'size-group-remove-widget)

;;; ----------------------------------------------------------------------------
;;; gtk_size_group_get_widgets () -> size-group-widgets
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_size_group_get_widgets" size-group-widgets)
    (g:slist-t g:object :free-from-foreign nil)
 #+liber-documentation
 "@version{#2020-6-3}
  @argument[size-group]{a @class{gtk:size-group} object}
  @begin{return}
    A list of widgets.
  @end{return}
  @begin{short}
    Returns the list of widgets associated with the size group.
  @end{short}
  @see-class{gtk:size-group}"
  (size-group (g:object size-group)))

(export 'size-group-widgets)

;;; --- End of file gtk.size-group.lisp ---------------------------------------
