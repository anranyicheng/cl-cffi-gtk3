;;; ----------------------------------------------------------------------------
;;; gtk3.hsv.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk3/>.
;;;
;;; Copyright (C) 2011 - 2023 Dieter Kaiser
;;;
;;; Permission is hereby granted, free of charge, to any person obtaining a
;;; copy of this software and associated documentation files (the "Software"),
;;; to deal in the Software without restriction, including without limitation
;;; the rights to use, copy, modify, merge, publish, distribute, sublicense,
;;; and/or sell copies of the Software, and to permit persons to whom the
;;; Software is furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be included in
;;; all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
;;; THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;; DEALINGS IN THE SOFTWARE.
;;; ----------------------------------------------------------------------------
;;;
;;; GtkHSV
;;;
;;;     A color wheel widget
;;;
;;; Types and Values
;;;
;;;     GtkHSV
;;;
;;; Functions
;;;
;;;     gtk_hsv_new
;;;     gtk_hsv_set_color
;;;     gtk_hsv_get_color
;;;     gtk_hsv_set_metrics
;;;     gtk_hsv_get_metrics
;;;     gtk_hsv_is_adjusting
;;;     gtk_hsv_to_rgb
;;;     gtk_rgb_to_hsv
;;;
;;; Signals
;;;
;;;     changed
;;;     move
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkHSV
;;;
;;; Implemented Interfaces
;;;
;;;     GtkHSV implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkHSV
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkHSV" hsv
  (:superclass widget
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable")
   :type-initializer "gtk_hsv_get_type")
  nil)

#+liber-documentation
(setf (documentation 'hsv 'type)
 "@version{#2023-3-20}
  @begin{short}
    The @sym{gtk:hsv} widget is the \"color wheel\" part of a complete color
    selector widget.
  @end{short}
  It allows to select a color by determining its HSV components in an intuitive
  way. Moving the selection around the outer ring changes the hue, and moving
  the selection point inside the inner triangle changes value and saturation.
  @begin[Warning]{dictionary}
    The @sym{gtk:hsv} widget has been deprecated since GTK 3.4 together with
    the @class{gtk:color-selection} widget, where it was used.
  @end{dictionary}
  @begin[Signal Details]{dictionary}
    @subheading{The \"changed\" signal}
      @begin{pre}
lambda (hsv)    :run-first
      @end{pre}
      @begin[code]{table}
        @entry[hsv]{The @sym{gtk:hsv} widget which received the signal.}
      @end{table}
    @subheading{The \"move\" signal}
      @begin{pre}
lambda (hsv direction)    :action
      @end{pre}
      @begin[code]{table}
        @entry[hsv]{The @sym{gtk:hsv} widget which received the signal.}
        @entry[direction]{A value of the @symbol{gtk:direction-type}
          enumeration.}
      @end{table}
  @end{dictionary}
  @see-constructor{gtk:hsv-new}
  @see-class{gtk:color-selection}
  @see-class{gtk:color-selection-dialog}")

;;; ----------------------------------------------------------------------------
;;; gtk_hsv_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline hsv-new))

(defun hsv-new ()
 #+liber-documentation
 "@version{#2023-3-20}
  @return{A newly-created @class{gtk:hsv} widget.}
  @begin{short}
    Creates a new HSV color selector.
  @end{short}
  @begin[Warning]{dictionary}
    The @sym{gtk:hsv-new} function is deprecated since version 3.4 and should
    not be used in newly written code.
  @end{dictionary}
  @see-class{gtk:hsv}"
  (make-instance 'hsv))

(export 'hsv-new)

;;; ----------------------------------------------------------------------------
;;; gtk_hsv_set_color ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_hsv_set_color" hsv-set-color) :void
 #+liber-documentation
 "@version{#2023-3-20}
  @argument[hsv]{a @class{gtk:hsv} widget}
  @argument[h]{a double float hue component}
  @argument[s]{a double float saturation component}
  @argument[v]{a double float value component}
  @begin{short}
    Sets the current color in an HSV color selector.
  @end{short}
  Color component values must be in the [0.0, 1.0] range.
  @begin[Warning]{dictionary}
    The @sym{gtk:hsv-set-color} function is deprecated since version 3.4 and
    should not be used in newly written code.
  @end{dictionary}
  @see-class{gtk:hsv}"
  (hsv (g:object hsv))
  (h :double)
  (s :double)
  (v :double))

(export 'hsv-set-color)

;;; ----------------------------------------------------------------------------
;;; gtk_hsv_get_color ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_hsv_get_color" %hsv-get-color) :void
  (hsv (g:object hsv))
  (h (:pointer :double))
  (s (:pointer :double))
  (v (:pointer :double)))

(defun hsv-get-color (hsv)
 #+liber-documentation
 "@version{#2023-3-20}
  @argument[hsv]{a @class{gtk:hsv} widget}
  @begin{return}
    @arg{h} -- a double float hue component @br{}
    @arg{s} -- a double float saturation component @br{}
    @arg{v} -- a double float value component
  @end{return}
  @begin{short}
    Queries the current color in an HSV color selector.
  @end{short}
  Returned values will be in the [0.0, 1.0] range.
  @begin[Warning]{dictionary}
    The @sym{gtk:hsv-get-color} function is deprecated since version 3.4 and
    should not be used in newly written code.
  @end{dictionary}
  @see-class{gtk:hsv}"
  (with-foreign-objects ((h :double) (s :double) (v :double))
    (%hsv-get-color hsv h s v)
    (values (cffi:mem-ref h :double)
            (cffi:mem-ref s :double)
            (cffi:mem-ref v :double))))

(export 'hsv-get-color)

;;; ----------------------------------------------------------------------------
;;; gtk_hsv_set_metrics ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_hsv_set_metrics" hsv-set-metrics) :void
 #+liber-documentation
 "@version{#2023-3-20}
  @argument[hsv]{a @class{gtk:hsv} widget}
  @argument[size]{an integer with the diameter for the hue ring}
  @argument[width]{an integer with the width of the hue ring}
  @short{Sets the size and ring width of an HSV color selector.}
  @begin[Warning]{dictionary}
    The @sym{gtk:hsv-set-metrics} function is deprecated since version 3.4 and
    should not be used in newly written code.
  @end{dictionary}
  @see-class{gtk:hsv}"
  (hsv (g:object hsv))
  (size :int)
  (width :int))

(export 'hsv-set-metrics)

;;; ----------------------------------------------------------------------------
;;; gtk_hsv_get_metrics ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_hsv_get_metrics" %hsv-get-metrics) :void
  (hsv (g:object hsv))
  (size (:pointer :int))
  (width (:pointer :int)))

(defun hsv-get-metrics (hsv)
 #+liber-documentation
 "@version{#2023-3-20}
  @argument[hsv]{a @class{gtk:hsv} widget}
  @begin{return}
    @arg{size} -- an integer with the diameter of the hue ring @br{}
    @arg{width} -- an integer with the width of the hue ring
  @end{return}
  @short{Queries the size and ring width of an HSV color selector.}
  @begin[Warning]{dictionary}
    The function @sym{gtk:hsv-get-metrics} is deprecated since version 3.4 and
    should not be used in newly written code.
  @end{dictionary}
  @see-class{gtk:hsv}"
  (with-foreign-objects ((size :int) (width :int))
    (%hsv-get-metrics hsv size width)
    (values (cffi:mem-ref size :int) (cffi:mem-ref width :int))))

(export 'hsv-get-metrics)

;;; ----------------------------------------------------------------------------
;;; gtk_hsv_is_adjusting ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_hsv_is_adjusting" hsv-is-adjusting) :boolean
 #+liber-documentation
 "@version{#2023-3-20}
  @argument[hsv]{a @class{gtk:hsv} widget}
  @begin{return}
    @em{True} if clients can ignore changes to the color value, since they may
    be transitory, or @em{false} if they should consider the color value status
    to be final.
  @end{return}
  @begin{short}
    An HSV color selector can be said to be adjusting if multiple rapid changes
    are being made to its value, for example, when the user is adjusting the
    value with the mouse.
  @end{short}
  This function queries whether the HSV color selector is being adjusted or not.
  @begin[Warning]{dictionary}
    The @sym{gtk:hsv-is-adjusting} function is deprecated since version 3.4 and
    should not be used in newly written code.
  @end{dictionary}
  @see-class{gtk:hsv}"
  (hsv (g:object hsv)))

(export 'hsv-is-adjusting)

;;; ----------------------------------------------------------------------------
;;; gtk_hsv_to_rgb ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_hsv_to_rgb" %hsv-to-rgb) :void
  (h :double)
  (s :double)
  (v :double)
  (r (:pointer :double))
  (g (:pointer :double))
  (b (:pointer :double)))

(defun hsv-to-rgb (h s v)
 #+liber-documentation
 "@version{#2023-3-20}
  @argument[h]{a double float hue component}
  @argument[s]{a double float saturation component}
  @argument[v]{a double float value component}
  @begin{return}
    @arg{r} -- a double float red component @br{}
    @arg{g} -- a double float green component @br{}
    @arg{b} -- a double float blue component
  @end{return}
  @begin{short}
    Converts a color from HSV space to RGB. Input values must be in the
    [0.0, 1.0] range, output values will be in the same range.
  @end{short}
  @see-class{gtk:hsv}
  @see-function{gtk:rgb-to-hsv}"
  (with-foreign-objects ((r :double) (g :double) (b :double))
    (%hsv-to-rgb h s v r g b)
    (values (cffi:mem-ref r :double)
            (cffi:mem-ref g :double)
            (cffi:mem-ref b :double))))

(export 'hsv-to-rgb)

;;; ----------------------------------------------------------------------------
;;; gtk_rgb_to_hsv ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_rgb_to_hsv" %rgb-to-hsv) :void
  (r :double)
  (g :double)
  (b :double)
  (h (:pointer :double))
  (s (:pointer :double))
  (v (:pointer :double)))

(defun rgb-to-hsv (r g b)
 #+liber-documentation
 "@version{#2023-3-20}
  @argument[r]{a double float red component}
  @argument[g]{a double float green component}
  @argument[b]{a double float blue component}
  @begin{return}
    @arg{h} -- the double float hue component @br{}
    @arg{s} -- the double float saturation component @br{}
    @arg{v} -- the double float value component
  @end{return}
  @begin{short}
    Converts a color from RGB space to HSV. Input values must be in the
    [0.0, 1.0] range; output values will be in the same range.
  @end{short}
  @see-class{gtk:hsv}
  @see-function{gtk:hsv-to-rgb}"
  (with-foreign-objects ((h :double) (s :double) (v :double))
    (%rgb-to-hsv r g b h s v)
    (values (cffi:mem-ref h :double)
            (cffi:mem-ref s :double)
            (cffi:mem-ref v :double))))

(export 'rgb-to-hsv)

;;; --- End of file gtk3.hsv.lisp ----------------------------------------------
