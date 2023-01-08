;;; ----------------------------------------------------------------------------
;;; gtk.menu-bar.lisp
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
;;; GtkMenuBar
;;;
;;;     A subclass of GtkMenuShell which holds GtkMenuItem widgets
;;;
;;; Types and Values
;;;
;;;     GtkMenuBar
;;;     GtkPackDirection
;;;
;;; Functions
;;;
;;;     gtk_menu_bar_new
;;;     gtk_menu_bar_new_from_model
;;;     gtk_menu_bar_set_pack_direction
;;;     gtk_menu_bar_get_pack_direction
;;;     gtk_menu_bar_set_child_pack_direction
;;;     gtk_menu_bar_get_child_pack_direction
;;;
;;; Properties
;;;
;;;     GtkPackDirection    child-pack-direction    Read / Write
;;;     GtkPackDirection    pack-direction          Read / Write
;;;
;;; Style Properties
;;;
;;;                 gint    internal-padding        Read
;;;        GtkShadowType    shadow-type             Read
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkMenuShell
;;;                     ╰── GtkMenuBar
;;;
;;; Implemented Interfaces
;;;
;;;     GtkMenuBar implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkPackDirection
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkPackDirection" pack-direction
  (:export t
   :type-initializer "gtk_pack_direction_get_type")
  (:ltr 0)
  (:rtl 1)
  (:ttb 2)
  (:btt 3))

#+liber-documentation
(setf (liber:alias-for-symbol 'pack-direction)
      "GEnum"
      (liber:symbol-documentation 'pack-direction)
 "@version{#2021-11-13}
  @begin{short}
    Determines how widgets should be packed insided menubars and menuitems
    contained in menubars.
  @end{short}
  @begin{pre}
(define-g-enum \"GtkPackDirection\" pack-direction
  (:export t
   :type-initializer \"gtk_pack_direction_get_type\")
  (:ltr 0)
  (:rtl 1)
  (:ttb 2)
  (:btt 3))
  @end{pre}
  @begin[code]{table}
    @entry[:ltr]{Widgets are packed left-to-right.}
    @entry[:rtl]{Widgets are packed right-to-left.}
    @entry[:ttb]{Widgets are packed top-to-bottom.}
    @entry[:btt]{Widgets are packed bottom-to-top.}
  @end{table}
  @see-class{gtk:menu-bar}")

;;; ----------------------------------------------------------------------------
;;; struct GtkMenuBar
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkMenuBar" menu-bar
  (:superclass menu-shell
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable")
   :type-initializer "gtk_menu_bar_get_type")
  ((child-pack-direction
    menu-bar-child-pack-direction
    "child-pack-direction" "GtkPackDirection" t t)
   (pack-direction
    menu-bar-pack-direction
    "pack-direction" "GtkPackDirection" t t)))

#+liber-documentation
(setf (documentation 'menu-bar 'type)
 "@version{#2021-11-13}
  @begin{short}
    The @sym{gtk:menu-bar} class is a subclass of the @class{gtk:menu-shell}
    class which contains one or more @class{gtk:menu-item} widgets.
  @end{short}
  The result is a standard menu bar which can hold many menu items.
  @begin[CSS nodes]{dictionary}
    The @sym{gtk:menu-bar} implementation has a single CSS node with name
    @code{menubar}.
  @end{dictionary}
  @begin[Style Property Details]{dictionary}
    @begin[code]{table}
      @begin[internal-padding]{entry}
        The @code{internal-padding} style property of type @code{:int} (Read)
        @br{}
        Amount of border space between the menu bar shadow and the menu items.
        @br{}
        @em{Warning:} The @code{internal-padding} style property has been
        deprecated since version 3.8 and should not be used in newly written
        code. Use the standard padding CSS property, through objects like
        @class{gtk:style-context} and @class{gtk:css-provider}. The value of
        this style property is ignored. @br{}
        Allowed values: >= 0 @br{}
        Default value: 1
      @end{entry}
      @begin[shadow-type]{entry}
        The @code{shadow-type} style property of type @symbol{gtk:shadow-type}
        (Read) @br{}
        Style of bevel around the menu bar. @br{}
        @em{Warning:} The @code{shadow-type} style property has been deprecated
        since version 3.20 and should not be used in newly written code. Use CSS
        to determine the shadow. The value of this style property is ignored.
        @br{}
        Default value: @code{:out}
      @end{entry}
    @end{table}
  @end{dictionary}
  @see-slot{gtk:menu-bar-child-pack-direction}
  @see-slot{gtk:menu-bar-pack-direction}
  @see-class{gtk:menu-shell}
  @see-class{gtk:menu-item}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- menu-bar-child-pack-direction --------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "child-pack-direction"
                                               'menu-bar) t)
 "The @code{child-pack-direction} property of type @symbol{gtk:pack-direction}
  (Read / Write) @br{}
  The child pack direction of the menu bar. It determines how the widgets
  contained in child menuitems are arranged. @br{}
  Default value: @code{:ltr}")

#+liber-documentation
(setf (liber:alias-for-function 'menu-bar-child-pack-direction)
      "Accessor"
      (documentation 'menu-bar-child-pack-direction 'function)
 "@version{#2021-11-13}
  @syntax[]{(gtk:menu-bar-child-pack-direction object) => direction}
  @syntax[]{(setf (gtk:menu-bar-child-pack-direction object) direction)}
  @argument[object]{a @class{gtk:menu-bar} widget}
  @argument[direction]{a value of the @symbol{gtk:pack-direction} enumeration}
  @begin{short}
    Accessor of the @slot[gtk:menu-bar]{child-pack-direction} slot of the
    @class{gtk:menu-bar} class.
  @end{short}

  The @sym{gtk:menu-bar-child-pack-direction} slot access function retrieves
  the current child pack direction of the menu bar. The
  @sym{(setf gtk:menu-bar-child-pack-direction)} slot access function sets how
  widgets should be packed inside the children of a menu bar.
  @see-class{gtk:menu-bar}
  @see-symbol{gtk:pack-direction}")

;;; --- menu-bar-pack-direction --------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "pack-direction"
                                               'menu-bar) t)
 "The @code{pack-direction} property of type @symbol{gtk:pack-direction}
  (Read / Write) @br{}
  The pack direction of the menu bar. It determines how menuitems are arranged
  in the menu bar. @br{}
  Default value: @code{:ltr}")

#+liber-documentation
(setf (liber:alias-for-function 'menu-bar-pack-direction)
      "Accessor"
      (documentation 'menu-bar-pack-direction 'function)
 "@version{#2021-11-13}
  @syntax[]{(gtk:menu-bar-pack-direction object) => direction}
  @syntax[]{(setf (gtk:menu-bar-pack-direction object) direction)}
  @argument[menubar]{a @class{gtk:menu-bar} widget}
  @argument[direction]{a value of the @symbol{gtk:pack-direction} enumeration}
  @begin{short}
    Accessor of the @slot[gtk:menu-bar]{pack-direction} slot of the
    @class{gtk:menu-bar} class.
  @end{short}

  The @sym{gtk:menu-bar-child-pack-direction} slot access function retrieves
  the current pack direction of the menu bar. The
  @sym{(setf gtk:menu-bar-child-pack-direction)} slot access function sets how
  items should be packed inside a menu bar.
  @see-class{gtk:menu-bar}
  @see-symbol{gtk:pack-direction}")

;;; ----------------------------------------------------------------------------
;;; gtk_menu_bar_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline menu-bar-new))

(defun menu-bar-new ()
 #+liber-documentation
 "@version{#2021-11-13}
  @return{The new @class{gtk:menu-bar} widget.}
  @begin{short}
    Creates a new menu bar.
  @end{short}
  @see-class{gtk:menu-bar}
  @see-function{gtk:menu-new-from-model}"
  (make-instance 'menu-bar))

(export 'menu-bar-new)

;;; ----------------------------------------------------------------------------
;;; gtk_menu_bar_new_from_model ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_menu_bar_new_from_model" menu-bar-new-from-model)
    (g:object menu-bar)
 #+liber-documentation
 "@version{#2021-11-13}
  @argument[model]{a @class{g:menu-model} object}
  @return{A new @class{gtk:menu-bar} widget.}
  @begin{short}
    Creates a new menu bar and populates it with menu items and
    submenus according to the menu model.
  @end{short}
  The created menu items are connected to actions found in the
  @class{gtk:application-window} widget to which the menu bar belongs -
  typically by means of being contained within the
  @class{gtk:application-window} widgets hierarchy.
  @see-class{gtk:menu-bar}
  @see-class{g:menu-model}
  @see-class{gtk:application-window}"
  (model (g:object g:menu-model)))

(export 'menu-bar-new-from-model)

;;; --- End of file gtk.menu-bar.lisp ------------------------------------------
