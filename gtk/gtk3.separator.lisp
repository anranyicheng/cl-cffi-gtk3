;;; ----------------------------------------------------------------------------
;;; gtk.separator.lisp
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
;;; GtkSeparator
;;;
;;;     A separator widget
;;;
;;; Types and Values
;;;
;;;     GtkSeparator
;;;
;;; Functions
;;;
;;;     gtk_separator_new
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkSeparator
;;;                 ├── GtkHSeparator
;;;                 ╰── GtkVSeparator
;;;
;;; Implemented Interfaces
;;;
;;;     GtkSeparator implements AtkImplementorIface, GtkBuildable and
;;;     GtkOrientable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkSeparator
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkSeparator" separator
  (:superclass widget
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkOrientable")
   :type-initializer "gtk_separator_get_type")
  nil)

#+liber-documentation
(setf (documentation 'separator 'type)
 "@version{#2021-12-16}
  @begin{short}
    The @sym{gtk:separator} widget is a horizontal or vertical separator widget,
    depending on the value of the @slot[gtk:orientable]{orientation} property of
    the @class{gtk:orientable} interface, used to group the widgets within a
    window.
  @end{short}
  It displays a line with a shadow to make it appear sunken into the
  interface.
  @begin[CSS nodes]{dictionary}
    The @sym{gtk:separator} implementation has a single CSS node with name
    @code{separator}. The node gets one of the @code{.horizontal} or
    @code{.vertical} style classes.
  @end{dictionary}
  @see-class{gtk:orientable}")

;;; ----------------------------------------------------------------------------
;;; gtk_separator_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline separator-new))

(defun separator-new (orientation)
 #+liber-documentation
 "@version{#2020-9-5}
  @argument[orientation]{the separator's orientation of type
  @symbol{gtk:orientation}}
  @return{A new @class{gtk:separator} widget.}
  @begin{short}
    Creates a new separator widget with the given @arg{orientation}.
  @end{short}
  See also the @class{gtk:orientable} interface.
  @see-class{gtk:separator}
  @see-class{gtk:orientable}
  @see-symbol{gtk:orientation}"
  (make-instance 'separator
                 :orientation orientation))

(export 'separator-new)

;;; ----------------------------------------------------------------------------
;;; GtkHSeparator
;;;
;;; A horizontal separator
;;;
;;; Synopsis
;;;
;;;     GtkHSeparator
;;;
;;;     gtk_hseparator_new
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; struct GtkHSeparator
;;; ----------------------------------------------------------------------------

(glib-init:at-init ()
  (eval-when (:compile-toplevel :load-toplevel :execute)
    (setf (gobject:get-lisp-name-exception "GtkHSeparator") 'hseparator)))

(define-g-object-class "GtkHSeparator" hseparator
  (:superclass separator
   :export nil
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkOrientable")
   :type-initializer "gtk_hseparator_get_type")
  nil)

#+liber-documentation
(setf (documentation 'hseparator 'type)
 "@version{#2013-1-29}
  @begin{short}
    The @sym{gtk:hseparator} widget is a horizontal separator, used to group
    the widgets within a window. It displays a horizontal line with a shadow to
    make it appear sunken into the interface.
  @end{short}

  @subheading{Note}
  The @sym{gtk:hseparator} widget is not used as a separator within menus. To
  create a separator in a menu create an empty @class{gtk:separator-menu-item}
  widget using @fun{gtk:separator-menu-item-new} and add it to the menu with
  @fun{gtk:menu-shell-append}.
  @begin[Warning]{dictionary}
    The @sym{gtk:hseparator} class has been deprecated, use the
    @class{gtk:separator} class with an orientation @code{:horizontal} instead.
  @end{dictionary}")

;;; ----------------------------------------------------------------------------
;;; gtk_hseparator_new ()
;;; ----------------------------------------------------------------------------

(defun hseparator-new ()
 #+liber-documentation
 "@version{#2013-1-29}
  @return{A new @class{gtk:hseparator} widget.}
  @begin{short}
    Creates a new @class{gtk:hseparator} widget.
  @end{short}
  @begin[Warning]{dictionary}
    The @sym{gtk:hseparator-new} function has been deprecated since version 3.2
    and should not be used in newly written code. Use the
    @fun{gtk:separator-new} function with an orientation @code{:horizontal}
    instead.
  @end{dictionary}
  @see-function{gtk:separator-new}"
  (make-instance 'hseparator))

;;; ----------------------------------------------------------------------------
;;; GtkVSeparator
;;;
;;; A vertical separator
;;;
;;; Synopsis
;;;
;;;     GtkVSeparator
;;;
;;;     gtk_vseparator_new
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; struct GtkVSeparator
;;; ----------------------------------------------------------------------------

(glib-init:at-init ()
  (eval-when (:compile-toplevel :load-toplevel :execute)
    (setf (gobject:get-lisp-name-exception "GtkVSeparator") 'vseparator)))

(define-g-object-class "GtkVSeparator" vseparator
  (:superclass separator
   :export nil
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkOrientable")
   :type-initializer "gtk_vseparator_get_type")
  nil)

#+liber-documentation
(setf (documentation 'vseparator 'type)
 "@version{#2013-1-29}
  @begin{short}
    The @sym{gtk:vseparator} widget is a vertical separator, used to group the
    widgets within a window. It displays a vertical line with a shadow to make
    it appear sunken into the interface.
  @end{short}
  @begin[Warning]{dictionary}
    The @sym{gtk:vseparator} class has been deprecated, use the
    @class{gtk:separator} class with orientation @code{:vertical} instead.
  @end{dictionary}
  @see-class{gtk:separator}")

;;; ----------------------------------------------------------------------------
;;; gtk_vseparator_new ()
;;; ----------------------------------------------------------------------------

(defun vseparator-new ()
 #+liber-documentation
 "@version{#2013-1-29}
  @return{A new @class{gtk:vseparator} widget.}
  @begin{short}
    Creates a new @class{gtk:vseparator} widget.
  @end{short}
  @begin[Warning]{dictionary}
    The @sym{gtk:vseparator-new} function has been deprecated since version 3.2
    and should not be used in newly written code. Use the
    @fun{gtk:separator-new} function with the orientation @code{:vertical}
    instead.
  @end{dictionary}
  @see-function{gtk:separator-new}"
  (make-instance 'vseparator))

;;; --- End of file gtk.separator.lisp -----------------------------------------
