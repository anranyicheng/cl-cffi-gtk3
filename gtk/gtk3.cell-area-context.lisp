;;; ----------------------------------------------------------------------------
;;; gtk.cell-area-context.lisp
;;;
;;; The documentation of this file is taken from the GTK+ 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK+ library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2012 - 2020 Dieter Kaiser
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
;;; GtkCellAreaContext
;;;
;;;     Stores geometrical information for a series of rows in a GtkCellArea
;;;
;;; Types and Values
;;;
;;;     GtkCellAreaContext
;;;
;;; Functions
;;;
;;;     gtk_cell_area_context_get_area                     Accessor
;;;     gtk_cell_area_context_allocate
;;;     gtk_cell_area_context_reset
;;;     gtk_cell_area_context_get_preferred_width
;;;     gtk_cell_area_context_get_preferred_height
;;;     gtk_cell_area_context_get_preferred_height_for_width
;;;     gtk_cell_area_context_get_preferred_width_for_height
;;;     gtk_cell_area_context_get_allocation
;;;     gtk_cell_area_context_push_preferred_width
;;;     gtk_cell_area_context_push_preferred_height
;;;
;;; Properties
;;;
;;;     GtkCellArea*   area              Read / Write / Construct Only
;;;            gint    minimum-height    Read
;;;            gint    minimum-width     Read
;;;            gint    natural-height    Read
;;;            gint    natural-width     Read
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GtkCellAreaContext
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; GtkCellAreaContext
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkCellAreaContext" gtk-cell-area-context
  (:superclass g:object
   :export t
   :interfaces nil
   :type-initializer "gtk_cell_area_context_get_type")
  ((area
    gtk-cell-area-context-area
    "area" "GtkCellArea" t t)
   (minimum-height
    gtk-cell-area-context-minimum-height
    "minimum-height" "gint" t nil)
   (minimum-width
    gtk-cell-area-context-minimum-width
    "minimum-width" "gint" t nil)
   (natural-height
    gtk-cell-area-context-natural-height
    "natural-height" "gint" t nil)
   (natural-width
    gtk-cell-area-context-natural-width
    "natural-width" "gint" t nil)))

#+liber-documentation
(setf (documentation 'gtk-cell-area-context 'type)
 "@version{#2020-6-28}
  @begin{short}
    The @sym{gtk-cell-area-context} object is created by a given
    @class{gtk-cell-area} implementation via its @code{create_context()} virtual
    method and is used to store cell sizes and alignments for a series of
    @class{gtk-tree-model} rows that are requested and rendered in the same
    context.
  @end{short}

  @class{gtk-cell-layout} widgets can create any number of contexts in which to
  request and render groups of data rows. However its important that the same
  context which was used to request sizes for a given @class{gtk-tree-model} row
  also be used for the same row when calling other @class{gtk-cell-area} APIs
  such as the functions @fun{gtk-cell-area-render} and
  @fun{gtk-cell-area-event}.
  @see-slot{gtk-cell-area-context-area}
  @see-slot{gtk-cell-area-context-minimum-height}
  @see-slot{gtk-cell-area-context-minimum-width}
  @see-slot{gtk-cell-area-context-natural-height}
  @see-slot{gtk-cell-area-context-natural-width}
  @see-class{gtk-cell-area}
  @see-class{gtk-tree-model}
  @see-class{gtk-cell-layout}
  @see-function{gtk-cell-area-render}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- gtk-cell-area-context-area ---------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "area" 'gtk-cell-area-context) t)
 "The @code{area} property of type @class{gtk-cell-area}
  (Read / Write / Construct) @br{}
  The cell area this context was created by.")

#+liber-documentation
(setf (liber:alias-for-function 'gtk-cell-area-context-area)
      "Accessor"
      (documentation 'gtk-cell-area-context-area 'function)
 "@version{#2020-6-28}
  @syntax[]{(gtk-cell-area-context-area object) => area}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[area]{a @class{gtk-cell-area} object}
  @begin{short}
    Accessor of the @slot[gtk-cell-area-context]{area} slot of the
    @class{gtk-cell-area-context} class.
  @end{short}

  The slot access function @sym{gtk-cell-area-context-area} fetches the
  @class{gtk-cell-area} object the context was created by.

  This is generally unneeded by layouting widgets. However it is important for
  the context implementation itself to fetch information about the area it is
  being used for. For instance at @code{GtkCellAreaContextClass.allocate()}
  time its important to know details about any cell spacing that the
  @class{gtk-cell-area} is configured with in order to compute a proper
  allocation.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}")

;;; --- gtk-cell-area-context-minimum-height -----------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "minimum-height"
                                               'gtk-cell-area-context) t)
 "The @code{minimum-height} property of type @code{:int} (Read) @br{}
  The minimum height for the @class{gtk-cell-area} in this context for all
  @class{gtk-tree-model} rows that this context was requested for using the
  function @fun{gtk-cell-area-preferred-height}. @br{}
  Allowed values: >= -1 @br{}
  Default value: -1")

#+liber-documentation
(setf (liber:alias-for-function 'gtk-cell-area-context-minimum-height)
      "Accessor"
      (documentation 'gtk-cell-area-context-minimum-height 'function)
 "@version{#2020-6-28}
  @syntax[]{(gtk-cell-area-context-minimum-height object) => height}
  @syntax[]{(setf (gtk-cell-area-context-minimum-height object) height}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[height]{an integer with the minimum height}
  @begin{short}
    Accessor of the @slot[gtk-cell-area-context]{minimum-height} slot of the
    @class{gtk-cell-area-context} class.
  @end{short}

  The minimum height for the @class{gtk-cell-area} in this context for all
  @class{gtk-tree-model} rows that this context was requested for using the
  function @fun{gtk-cell-area-preferred-height}.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}
  @see-class{gtk-tree-model}
  @see-function{gtk-cell-area-preferred-height}")

;;; --- gtk-cell-area-context-minimum-width ------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "minimum-width"
                                               'gtk-cell-area-context) t)
 "The @code{minimum-width} property of type @code{:int} (Read) @br{}
  The minimum width for the @class{gtk-cell-area} in this context for all
  @class{gtk-tree-model} rows that this context was requested for using the
  function @fun{gtk-cell-area-preferred-width}. @br{}
  Allowed values: >= -1 @br{}
  Default value: -1")

#+liber-documentation
(setf (liber:alias-for-function 'gtk-cell-area-context-minimum-width)
      "Accessor"
      (documentation 'gtk-cell-area-context-minimum-width 'function)
 "@version{#2020-6-28}
  @syntax[]{(gtk-cell-area-context-minimum-width object) => width}
  @syntax[]{(setf (gtk-cell-area-context-minimum-width object) width}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[width]{an integer with the minimum width}
  @begin{short}
    Accessor of the @slot[gtk-cell-area-context]{minimum-width} slot of the
    @class{gtk-cell-area-context} class.
  @end{short}

  The minimum width for the @class{gtk-cell-area} in this context for all
  @class{gtk-tree-model} rows that this context was requested for using the
  function @fun{gtk-cell-area-preferred-width}.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}
  @see-class{gtk-tree-model}
  @see-function{gtk-cell-area-preferred-width}")

;;; --- gtk-cell-area-context-natural-height -----------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "natural-height"
                                               'gtk-cell-area-context) t)
 "The @code{natural-height} property of type @code{:int} (Read) @br{}
  The natural height for the @class{gtk-cell-area} in this context for all
  @class{gtk-tree-model} rows that this context was requested for using the
  function @fun{gtk-cell-area-preferred-height}. @br{}
  Allowed values: >= -1 @br{}
  Default value: -1")

#+liber-documentation
(setf (liber:alias-for-function 'gtk-cell-area-context-natural-height)
      "Accessor"
      (documentation 'gtk-cell-area-context-natural-height 'function)
 "@version{#2020-6-28}
  @syntax[]{(gtk-cell-area-context-natural-height object) => height}
  @syntax[]{(setf (gtk-cell-area-context-natural-height object) height}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[height]{an integer with the natural height}
  @begin{short}
    Accessor of the @slot[gtk-cell-area-context]{natural-height} slot of the
    @class{gtk-cell-area-context} class.
  @end{short}

  The natural height for the @class{gtk-cell-area} in this context for all
  @class{gtk-tree-model} rows that this context was requested for using the
  function @fun{gtk-cell-area-preferred-height}.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}
  @see-class{gtk-tree-model}
  @see-function{gtk-cell-area-preferred-height}")

;;; --- gtk-cell-area-context-natural-width ------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "natural-width"
                                               'gtk-cell-area-context) t)
 "The @code{natural-width} property of type @code{:int} (Read) @br{}
  The natural width for the @class{gtk-cell-area} in this context for all
  @class{gtk-tree-model} rows that this context was requested for using the
  function @fun{gtk-cell-area-preferred-width}. @br{}
  Allowed values: >= -1 @br{}
  Default value: -1")

#+liber-documentation
(setf (liber:alias-for-function 'gtk-cell-area-context-natural-width)
      "Accessor"
      (documentation 'gtk-cell-area-context-natural-width 'function)
 "@version{#2020-6-28}
  @syntax[]{(gtk-cell-area-context-natural-width object) => width}
  @syntax[]{(setf (gtk-cell-area-context-natural-width object) width}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[width]{an integer with the natural width}
  @begin{short}
    Accessor of the @slot[gtk-cell-area-context]{natural-width} slot of the
    @class{gtk-cell-area-context} class.
  @end{short}

  The natural width for the @class{gtk-cell-area} in this context for all
  @class{gtk-tree-model} rows that this context was requested for using the
  function @fun{gtk-cell-area-preferred-width}.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}
  @see-class{gtk-tree-model}
  @see-function{gtk-cell-area-preferred-width}")

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_allocate ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_allocate" gtk-cell-area-context-allocate) :void
 #+liber-documentation
 "@version{#2020-6-28}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[width]{an integer with the allocated width for all
    @class{gtk-tree-model} rows rendered with context, or -1}
  @argument[height]{an integer with the allocated height for all
    @class{gtk-tree-model} rows rendered with context, or -1}
  @begin{short}
    Allocates a width and/or a height for all rows which are to be rendered
    with @arg{context}.
  @end{short}

  Usually allocation is performed only horizontally or sometimes vertically
  since a group of rows are usually rendered side by side vertically or
  horizontally and share either the same width or the same height. Sometimes
  they are allocated in both horizontal and vertical orientations producing a
  homogeneous effect of the rows. This is generally the case for
  @class{gtk-tree-view} when the @slot[gtk-tree-view]{fixed-height-mode}
  property is enabled.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-tree-model}
  @see-class{gtk-tree-view}"
  (context (g:object gtk-cell-area-context))
  (width :int)
  (height :int))

(export 'gtk-cell-area-context-allocate)

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_reset ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_reset" gtk-cell-area-context-reset) :void
 #+liber-documentation
 "@version{#2020-6-28}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @begin{short}
    Resets any previously cached request and allocation data.
  @end{short}

  When underlying @class{gtk-tree-model} data changes its important to reset the
  context if the content size is allowed to shrink. If the content size is only
  allowed to grow, this is usually an option for views rendering large data
  stores as a measure of optimization, then only the row that changed or was
  inserted needs to be (re)requested with the function
  @fun{gtk-cell-area-preferred-width}.

  When the new overall size of the context requires that the allocated size
  changes, or whenever this allocation changes at all, the variable row sizes
  need to be re-requested for every row.

  For instance, if the rows are displayed all with the same width from top to
  bottom then a change in the allocated width necessitates a recalculation of
  all the displayed row heights using the function
  @fun{gtk-cell-area-preferred-height-for-width}.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-tree-model}
  @see-function{gtk-cell-area-preferred-width}
  @see-function{gtk-cell-area-preferred-height-for-width}"
  (context (g:object gtk-cell-area-context)))

(export 'gtk-cell-area-context-reset)

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_preferred_width ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_get_preferred_width"
          %gtk-cell-area-context-preferred-width) :void
  (context (g:object gtk-cell-area-context))
  (minium-width (:pointer :int))
  (natural-width (:pointer :int)))

(defun gtk-cell-area-context-preferred-width (context)
 #+liber-documentation
 "@version{#2020-6-27}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @begin{return}
    @code{minimum-width} -- an integer with the minimum width, or
                            @code{nil} @br{}
    @code{natural-width} -- an integer with the natural width, or @code{nil}
  @end{return}
  @begin{short}
    Gets the accumulative preferred width for all rows which have been requested
    with this context.
  @end{short}

  After the function @fun{gtk-cell-area-context-reset} is called and/or before
  ever requesting the size of a @class{gtk-cell-area}, the returned values
  are 0.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}
  @see-function{gtk-cell-area-context-reset}"
  (with-foreign-objects ((minimum-width :int) (natural-width :int))
    (%gtk-cell-area-context-preferred-width context
                                            minimum-width
                                            natural-width)
    (values (cffi:mem-ref minimum-width :int)
            (cffi:mem-ref natural-width :int))))

(export 'gtk-cell-area-context-preferred-width)

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_preferred_height ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_get_preferred_height"
          %gtk-cell-area-context-preferred-height) :void
  (context (g:object gtk-cell-area-context))
  (minium-height (:pointer :int))
  (natural-height (:pointer :int)))

(defun gtk-cell-area-context-preferred-height (context)
 #+liber-documentation
 "@version{#2020-6-27}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @begin{return}
    @code{minimum-height} -- an integer with the minimum height, or
                             @code{nil} @br{}
    @code{natural-height} -- an integer with the natural height, or @code{nil}
  @end{return}
  @begin{short}
    Gets the accumulative preferred height for all rows which have been
    requested with this context.
  @end{short}

  After the function @fun{gtk-cell-area-context-reset} is called and/or before
  ever requesting the size of a @class{gtk-cell-area}, the returned values
  are 0.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}
  @see-function{gtk-cell-area-context-reset}"
  (with-foreign-objects ((minimum-height :int) (natural-height :int))
    (%gtk-cell-area-context-preferred-height context
                                             minimum-height
                                             natural-height)
    (values (cffi:mem-ref minimum-height :int)
            (cffi:mem-ref natural-height :int))))

(export 'gtk-cell-area-context-preferred-height)

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_preferred_height_for_width ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_get_preferred_height_for_width"
          %gtk-cell-area-context-preferred-height-for-width) :void
  (context (g:object gtk-cell-area-context))
  (width :int)
  (minium-height (:pointer :int))
  (natural-height (:pointer :int)))

(defun gtk-cell-area-context-preferred-height-for-width (context width)
 #+liber-documentation
 "@version{#2020-6-27}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[width]{an integer with a proposed width for allocation}
  @begin{return}
    @code{minimum-height} -- an integer with the minimum height, or
                             @code{nil} @br{}
    @code{natural-height} -- an integer with the natural height, or @code{nil}
  @end{return}
  @begin{short}
    Gets the accumulative preferred height for @arg{width} for all rows which
    have been requested for the same said width with this context.
  @end{short}

  After the function @fun{gtk-cell-area-context-reset} is called and/or before
  ever requesting the size of a @class{gtk-cell-area}, the returned values
  are -1.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}
  @see-function{gtk-cell-area-context-reset}"
  (with-foreign-objects ((minimum-height :int) (natural-height :int))
    (%gtk-cell-area-context-preferred-height-for-width context
                                                       width
                                                       minimum-height
                                                       natural-height)
    (values (cffi:mem-ref minimum-height :int)
            (cffi:mem-ref natural-height :int))))

(export 'gtk-cell-area-context-preferred-height-for-width)

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_preferred_width_for_height ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_get_preferred_width_for_height"
          %gtk-cell-area-context-preferred-width-for-height) :void
  (context (g:object gtk-cell-area-context))
  (height :int)
  (minium-width (:pointer :int))
  (natural-width (:pointer :int)))

(defun gtk-cell-area-context-preferred-width-for-height (context height)
 #+liber-documentation
 "@version{#2020-6-27}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[height]{an integer with a proposed height for allocation}
  @begin{return}
    @code{minimum-width} -- an integer with the minimum width, or
                            @code{nil} @br{}
    @code{natural-width} -- an integer with the natural width, or @code{nil}
  @end{return}
  @begin{short}
    Gets the accumulative preferred width for @arg{height} for all rows which
    have been requested for the same said height with this context.
  @end{short}

  After the function @fun{gtk-cell-area-context-reset} is called and/or before
  ever requesting the size of a @class{gtk-cell-area}, the returned values
  are -1.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-cell-area}
  @see-function{gtk-cell-area-context-reset}"
  (with-foreign-objects ((minimum-width :int) (natural-width :int))
    (%gtk-cell-area-context-preferred-height-for-width context
                                                       height
                                                       minimum-width
                                                       natural-width)
    (values (cffi:mem-ref minimum-width :int)
            (cffi:mem-ref natural-width :int))))

(export 'gtk-cell-area-context-preferred-width-for-height)

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_get_allocation () -> gtk-cell-area-context-allocation
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_get_allocation"
          %gtk-cell-area-context-allocation) :void
  (context (g:object gtk-cell-area-context))
  (width (:pointer :int))
  (height (:pointer :int)))

(defun gtk-cell-area-context-allocation (context)
 #+liber-documentation
 "@version{#2020-6-28}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @begin{return}
    @code{width} -- an integer with the allocated width, or @code{nil} @br{}
    @code{height} -- an integer with the allocated height, or @code{nil}
  @end{return}
  @begin{short}
    Fetches the current allocation size for @arg{context}.
  @end{short}

  If the context was not allocated in @arg{width} or @arg{height}, or if the
  context was recently reset with the function
  @fun{gtk-cell-area-context-reset}, the returned value will be -1.
  @see-class{gtk-cell-area-context}
  @see-function{gtk-cell-area-context-reset}"
  (with-foreign-objects ((width :int) (height :int))
    (%gtk-cell-area-context-allocation context width height)
    (values (cffi:mem-ref width :int)
            (cffi:mem-ref height :int))))

(export 'gtk-cell-area-context-allocation)

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_push_preferred_width ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_push_preferred_width"
           gtk-cell-area-context-push-preferred-width) :void
 #+liber-documentation
 "@version{#2020-6-28}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[minimum-width]{an integer with the proposed new minimum width for
    @arg{context}}
  @argument[natural-width]{an integer with the proposed new natural width for
    @arg{context}}
  @begin{short}
    Causes the minimum and/or natural width to grow if the new proposed sizes
    exceed the current minimum and natural width.
  @end{short}

  This is used by @class{gtk-cell-area-context} implementations during the
  request process over a series of @class{gtk-tree-model} rows to progressively
  push the requested width over a series of the function
  @fun{gtk-cell-area-preferred-width} requests.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-tree-model}
  @see-function{gtk-cell-area-preferred-width}"
  (context (g:object gtk-cell-area-context))
  (minimum-width :int)
  (natural-width :int))

(export 'gtk-cell-area-context-push-preferred-width)

;;; ----------------------------------------------------------------------------
;;; gtk_cell_area_context_push_preferred_height ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_cell_area_context_push_preferred_height"
           gtk-cell-area-context-push-preferred-height) :void
 #+liber-documentation
 "@version{#2020-6-28}
  @argument[context]{a @class{gtk-cell-area-context} object}
  @argument[minimum-height]{an integer with the proposed new minimum height for
    @arg{context}}
  @argument[natural-height]{an integer with the proposed new natural height for
    @arg{context}}
  @begin{short}
    Causes the minimum and/or natural height to grow if the new proposed sizes
    exceed the current minimum and natural height.
  @end{short}

  This is used by @class{gtk-cell-area-context} implementations during the
  request process over a series of @class{gtk-tree-model} rows to progressively
  push the requested height over a series of the function
  @fun{gtk-cell-area-preferred-height} requests.
  @see-class{gtk-cell-area-context}
  @see-class{gtk-tree-model}
  @see-function{gtk-cell-area-preferred-height}"
  (context (g:object gtk-cell-area-context))
  (minimum-height :int)
  (natural-height :int))

(export 'gtk-cell-area-context-push-preferred-height)

;;; --- End of file gtk.cell-area-context.lisp ---------------------------------
