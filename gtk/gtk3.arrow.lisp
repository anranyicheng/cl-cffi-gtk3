;;; ----------------------------------------------------------------------------
;;; gtk.arrow.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2021 Dieter Kaiser
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
;;; GtkArrow
;;;
;;;     Displays an arrow
;;;
;;; Types and Values
;;;
;;;     GtkArrow
;;;
;;; Functions
;;;
;;;     gtk_arrow_new
;;;     gtk_arrow_set
;;;
;;; Properties
;;;
;;;      GtkArrowType    arrow-type       Read / Write
;;;     GtkShadowType    shadow-type      Read / Write
;;;
;;; Style Properties
;;;
;;;            gfloat    arrow-scaling    Read
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkMisc
;;;                 ╰── GtkArrow
;;;
;;; Implemented Interfaces
;;;
;;;     GtkArrow implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkArrow
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkArrow" arrow
  (:superclass misc
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable")
   :type-initializer "gtk_arrow_get_type")
  ((arrow-type
    arrow-arrow-type
    "arrow-type" "GtkArrowType" t t)
   (shadow-type
    arrow-shadow-type
    "shadow-type" "GtkShadowType" t t)))

#+liber-documentation
(setf (documentation 'arrow 'type)
 "@version{#2021-7-25}
  @begin{short}
    The @sym{gtk:arrow} widget should be used to draw simple arrows that need
    to point in one of the four cardinal directions: up, down, left, or right.
  @end{short}
  The style of the arrow can be one of shadow in, shadow out, etched in, or
  etched out. Note that these directions and style types may be ammended in
  versions of GTK to come.

  The @sym{gtk:arrow} widget will fill any space alloted to it, but since it is
  inherited from the @class{gtk:misc} class, it can be padded and/or aligned,
  to fill exactly the space the programmer desires.

  Arrows are created with a call to the function @fun{gtk:arrow-new}. The
  direction or style of an arrow can be changed after creation by using the
  function @fun{gtk:arrow-set}.
  @begin[Warning]{dictionary}
    The @sym{gtk:arrow} widget has been deprecated. You can simply use a
    @class{gtk:image} widget with a suitable icon name, such as
    \"pan-down-symbolic\". When replacing the @sym{gtk:arrow} widget by an
    image, pay attention to the fact that the @sym{gtk:arrow} widget is doing
    automatic flipping between @code{:left} and @code{:right}, depending on the
    text direction. To get the same effect with an image, use the icon names
    \"pan-start-symbolic\" and \"pan-end-symbolic\", which react to the text
    direction.
  @end{dictionary}
  @begin[Style Property Details]{dictionary}
    @begin[code]{table}
      @begin[arrow-scaling]{entry}
        The @code{arrow-scaling} style property of type @code{:float}
        (Read) @br{}
        Amount of space used up by the arrow. @br{}
        Allowed values: [0,1] @br{}
        Default value: 0.7
      @end{entry}
    @end{table}
  @end{dictionary}
  @see-slot{gtk:arrow-arrow-type}
  @see-slot{gtk:arrow-shadow-type}
  @see-class{gtk:misc}
  @see-class{gtk:image}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- arrow-arrow-type ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "arrow-type" 'arrow) t)
 "The @code{arrow-type} property of type @symbol{gtk:arrow-type}
  (Read / Write) @br{}
  The direction the arrow should point. @br{}
  Default value: @code{:right}")

#+liber-documentation
(setf (liber:alias-for-function 'arrow-arrow-type)
      "Accessor"
      (documentation 'arrow-arrow-type 'function)
 "@version{#2021-7-22}
  @syntax[]{(gtk:arrow-arrow-type object) => arrow-type}
  @syntax[]{(setf (gtk:arrow-arrow-type object) arrow-type)}
  @argument[object]{a @class{gtk:arrow} widget}
  @argument[arrow-type]{a value of the @symbol{gtk:arrow-type} enumeration}
  @begin{short}
    Accessor of the @slot[gtk:arrow]{arrow-type} slot of the @class{gtk:arrow}
    class.
  @end{short}

  The direction the arrow should point.
  @begin[Warning]{dictionary}
    The function @sym{gtk:arrow-arrow-type} has been deprecated since version
    3.14 and should not be used in newly written code. Use a @class{gtk:image}
    widget with a suitable icon.
  @end{dictionary}
  @see-class{gtk:arrow}
  @see-class{gtk:image}
  @see-symbol{gtk:arrow-type}")

;;; --- arrow-shadow-type --------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "shadow-type" 'arrow) t)
 "The @code{shadow-type} property of type @symbol{gtk:shadow-type}
  (Read / Write) @br{}
  Appearance of the shadow surrounding the arrow. @br{}
  Default value: @code{:out}")

#+liber-documentation
(setf (liber:alias-for-function 'arrow-shadow-type)
      "Accessor"
      (documentation 'arrow-shadow-type 'function)
 "@version{#2021-7-22}
  @syntax[]{(gtk:arrow-shadow-type object) => shadow-type}
  @syntax[]{(setf (gtk:arrow-shadow-type object) shadow-type)}
  @argument[object]{a @class{gtk:arrow} widget}
  @argument[shadow-type]{a value of the @symbol{gtk:shadow-type} enumeration}
  @begin{short}
    Accessor of the @slot[gtk:arrow]{shadow-type} slot of the @class{gtk:arrow}
    class.
  @end{short}

  Appearance of the shadow surrounding the arrow.
  @begin[Warning]{dictionary}
    The function @sym{gtk:arrow-shadow-type} has been deprecated since version
    3.14 and should not be used in newly written code. Use a @class{gtk:image}
    widget with a suitable icon.
  @end{dictionary}
  @see-class{gtk:arrow}
  @see-class{gtk:image}
  @see-symbol{gtk:shadow-type}")

;;; ----------------------------------------------------------------------------
;;; gtk_arrow_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline arrow-new))

(defun arrow-new (arrow-type shadow-type)
 #+liber-documentation
 "@version{#2021-7-22}
  @argument[arrow-type]{a value of the @symbol{gtk:arrow-type} enumeration}
  @argument[shadow-type]{a value of the @symbol{gtk:shadow-type} enumeration}
  @return{The new @class{gtk:arrow} widget.}
  @short{Creates a new arrow.}
  @begin[Warning]{dictionary}
    The function @sym{gtk:arrow-new} has been deprecated since version 3.14 and
    should not be used in newly written code. Use a @class{gtk:image} widget
    with a suitable icon.
  @end{dictionary}
  @see-class{gtk:arrow}
  @see-class{gtk:image}
  @see-symbol{gtk:arrow-type}
  @see-symbol{gtk:shadow-type}"
  (make-instance 'arrow
                 :arrow-type arrow-type
                 :shadow-type shadow-type))

(export 'arrow-new)

;;; ----------------------------------------------------------------------------
;;; gtk_arrow_set ()
;;; ----------------------------------------------------------------------------

(declaim (inline arrow-set))

(defun arrow-set (arrow arrow-type shadow-type)
 #+liber-documentation
 "@version{#2021-7-22}
  @argument[arrow]{a @class{gtk:arrow} widget}
  @argument[arrow-type]{a value of the @symbol{gtk:arrow-type} enumeration}
  @argument[shadow-type]{a value of the @symbol{gtk:shadow-type} enumeration}
  @short{Sets the direction and style of the arrow.}
  @begin[Warning]{dictionary}
    The function @sym{gtk:arrow-set} has been deprecated since version 3.14 and
    should not be used in newly written code. Use a @class{gtk:image} widget
    with a suitable icon.
  @end{dictionary}
  @see-class{gtk:arrow}
  @see-class{gtk:image}
  @see-symbol{gtk:arrow-type}
  @see-symbol{gtk:shadow-type}"
  (setf (arrow-arrow-type arrow) arrow-type
        (arrow-shadow-type arrow) shadow-type))

(export 'arrow-set)

;;; --- End of file gtk.arrow.lisp ---------------------------------------------
