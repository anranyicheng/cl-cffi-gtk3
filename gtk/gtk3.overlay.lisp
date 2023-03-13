;;; ----------------------------------------------------------------------------
;;; gtk.overlay.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
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
;;; GtkOverlay
;;;
;;;     A container which overlays widgets on top of each other
;;;
;;; Types and Values
;;;
;;;     GtkOverlay
;;;
;;; Functions
;;;
;;;     gtk_overlay_new
;;;     gtk_overlay_add_overlay
;;;     gtk_overlay_reorder_overlay
;;;     gtk_overlay_get_overlay_pass_through   -> gtk:overlay-child-pass-through
;;;     gtk_overlay_set_overlay_pass_through   -> gtk:overlay-child-pass-through
;;;
;;; Child Properties
;;;
;;;         gint    index                 Read / Write
;;;     gboolean    pass-through          Read / Write
;;;
;;; Signals
;;;
;;;     gboolean    get-child-position    Run Last
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkBin
;;;                     ╰── GtkOverlay
;;;
;;; Implemented Interfaces
;;;
;;;     GtkOverlay implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkOverlay
;;; ----------------------------------------------------------------------------

;; TODO: The "get-child-position" signal handler has an return location
;; of type GdkRectangle. Check the Lisp implementation of a handler.

(define-g-object-class "GtkOverlay" overlay
  (:superclass bin
    :export t
    :interfaces ("AtkImplementorIface"
                 "GtkBuildable")
    :type-initializer "gtk_overlay_get_type")
  nil)

#+liber-documentation
(setf (documentation 'overlay 'type)
 "@version{#2023-3-13}
  @begin{short}
    The @sym{gtk:overlay} widget is a container which contains a single main
    widget, on top of which it can place overlay widgets.
  @end{short}
  The position of each overlay widget is determined by its
  @slot[gtk:widget]{halign} and @slot[gtk:widget]{valign} properties. E.g. a
  overlay widget with both alignments set to @code{:start} will be placed at
  the top left corner of the main widget, whereas an overlay with the
  @slot[gtk:widget]{halign} property set to @code{:center} and the
  @slot[gtk:widget]{valign} property set to @code{:end} will be placed a the
  bottom edge of the main widget, horizontally centered. The position can be
  adjusted by setting the margin properties of the overlay widget to non-zero
  values.

  More complicated placement of overlays is possible by connecting to the
  \"get-child-position\" signal.
  @begin[GtkOverlay as GtkBuildable]{dictionary}
    The @sym{gtk:overlay} implementation of the @class{gtk:buildable} interface
    supports placing a child widget as an overlay by specifying
    @code{\"overlay\"} as the @code{\"type\"} attribute of a @code{<child>}
    element.
  @end{dictionary}
  @begin[CSS nodes]{dictionary}
    The @sym{gtk:overlay} implementation has a single CSS node with the name
    @code{overlay}. Overlay children whose alignments cause them to be
    positioned at an edge get the @code{.left}, @code{.right}, @code{.top},
    and/or @code{.bottom} style classes according to their position.
  @end{dictionary}
  @begin[Child Property Details]{dictionary}
    @begin[code]{table}
      @begin[index]{entry}
        The @code{index} child property of type @code{:int} (Read / Write) @br{}
        The index of the overlay in the parent, -1 for the main child. @br{}
        Allowed values: >= -1 @br{}
        Default value: 0
      @end{entry}
      @begin[pass-through]{entry}
        The @code{pass-through} child property of type @code{:boolean}
        (Read / Write) @br{}
        Pass through input, does not affect main child. @br{}
        Default value: @em{false}
      @end{entry}
    @end{table}
  @end{dictionary}
  @begin[Signal Details]{dictionary}
    @subheading{The \"get-child-position\" signal}
      @begin{pre}
lambda (overlay widget allocation)    :run-last
      @end{pre}
      The signal is emitted to determine the position and size of any overlay
      child widgets. A handler for this signal should fill allocation with the
      desired position and size for @arg{widget}, relative to the 'main' child
      of the overlay. The default handler for this signal uses the
      @slot[gtk:widget]{halign} and @slot[gtk:widget]{valign} properties of the
      widget to determine the position and gives the widget its natural size,
      except that an alignment of @code{:fill} will cause the overlay to be
      full-width/height. If the main child is a @class{gtk:scrolled-window}
      widget, the overlays are placed relative to its contents.
      @begin[code]{table}
        @entry[overlay]{The @sym{gtk:overlay} widget which emitted the signal.}
        @entry[widget]{The @class{gtk:widget} child widget to position.}
        @entry[allocation]{Return location of type @class{gdk:rectangle} for
          the allocation.}
        @entry[Returns]{@em{True} if the allocation has been filled.}
      @end{table}
  @end{dictionary}
  @see-class{gtk:buildable}
  @see-class{gtk:scrolled-window}")

;;; ----------------------------------------------------------------------------
;;; Child Property and Child Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- overlay-child-index ----------------------------------------------------

(define-child-property overlay-child-index "index" "gint" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'overlay-child-index)
      "Accessor"
      (documentation 'overlay-child-index 'function)
 "@version{#2023-3-13}
  @syntax[]{(gtk:overlay-child-index object) => index)}
  @syntax[]{(setf (gtk:overlay-child-index object) index)}
  @argument[container]{a @class{gtk:overlay} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[index]{an integer with the index of the child widget in the parent}
  @begin{short}
    Accessor of the @code{index} child property of the @class{gtk:overlay}
    class.
  @end{short}
  The index of the child widget in the parent, -1 for the main child.
  @see-class{gtk:overlay}
  @see-class{gtk:widget}")

;;; --- overlay-child-pass-through ---------------------------------------------

(define-child-property overlay-child-pass-through
                       "pass-through" "gboolean" t t t)

#+liber-documentation
(setf (liber:alias-for-function 'overlay-child-pass-through)
      "Accessor"
      (documentation 'overlay-child-pass-through 'function)
 "@version{#2023-3-13}
  @syntax[]{(gtk:overlay-child-pass-through container child) => setting)}
  @syntax[]{(setf (gtk:overlay-child-pass-through container child) setting)}
  @argument[container]{a @class{gtk:overlay} widget}
  @argument[child]{a @class{gtk:widget} child widget}
  @argument[setting]{a boolean whether to pass through input}
  @begin{short}
    Accessor of the @code{pass-through} child property of the
    @class{gtk:overlay} class.
  @end{short}
  Pass through input, does not affect main child.
  @see-class{gtk:overlay}
  @see-class{gtk:widget}")

;;; ----------------------------------------------------------------------------
;;; gtk_overlay_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline overlay-new))

(defun overlay-new ()
 #+liber-documentation
 "@version{#2021-10-21}
  @return{A new @class{gtk:overlay} widget.}
  @begin{short}
    Creates a new overlay container.
  @end{short}
  @see-class{gtk:overlay}"
  (make-instance 'overlay))

(export 'overlay-new)

;;; ----------------------------------------------------------------------------
;;; gtk_overlay_add_overlay ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_overlay_add_overlay" overlay-add-overlay) :void
 #+liber-documentation
 "@version{#2021-11-30}
  @argument[overlay]{a @class{gtk:overlay} widget}
  @argument[widget]{a @class{gtk:widget} child widget to be added to the
    container}
  @begin{short}
    Adds a child widget to the overlay container.
  @end{short}
  The child widget will be stacked on top of the main widget added with the
  @fun{gtk:container-add} function.

  The position at which the child widget is placed is determined from its
  @slot[gtk:widget]{halign} and @slot[gtk:widget]{valign} properties.
  @see-class{gtk:overlay}
  @see-class{gtk:widget}
  @see-function{gtk:container-add}
  @see-function{gtk:widget-halign}
  @see-function{gtk:widget-valign}"
  (overlay (g:object overlay))
  (widget (g:object widget)))

(export 'overlay-add-overlay)

;;; ----------------------------------------------------------------------------
;;; gtk_overlay_reorder_overlay ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_overlay_reorder_overlay" overlay-reorder-overlay) :void
 #+liber-documentation
 "@version{#2023-3-13}
  @argument[overlay]{a @class{gtk:overlay} widget}
  @argument[child]{a overlaid @class{gtk:widget} child widget to move}
  @argument[position]{an integer with the new index for the child widget in the
    list of overlay children of the overlay container, starting from 0, if
    negative, indicates the end of the list}
  @begin{short}
    Moves a child widget to a new index in the list of overlay children.
  @end{short}
  The list contains overlays in the order that these were added to the overlay
  container.

  An index of the widget in the overlay children list determines which order
  the children are drawn if they overlap. The first child is drawn at the
  bottom. It also affects the default focus chain order.
  @see-class{gtk:overlay}
  @see-class{gtk:widget}"
  (overlay (g:object overlay))
  (child (g:object widget))
  (position :int))

(export 'overlay-reorder-overlay)

;;; ----------------------------------------------------------------------------
;;; gtk_overlay_get_overlay_pass_through ()
;;; gtk_overlay_set_overlay_pass_through ()
;;; ----------------------------------------------------------------------------

;; Implemented as the child accessor overlay-child-pass-through

;;; --- End of file gtk.overlay.lisp -------------------------------------------
