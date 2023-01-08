;;; ----------------------------------------------------------------------------
;;; gtk.adjustment.lisp
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
;;; GtkAdjustment
;;;
;;;     A representation of an adjustable bounded value
;;;
;;; Types and values
;;;
;;;     GtkAdjustment
;;;
;;; Functions
;;;
;;;     gtk_adjustment_new
;;;     gtk_adjustment_get_value                           Accessor
;;;     gtk_adjustment_set_value                           Accessor
;;;     gtk_adjustment_clamp_page
;;;     gtk_adjustment_changed                           * deprecated
;;;     gtk_adjustment_value_changed                     * deprecated
;;;     gtk_adjustment_configure
;;;     gtk_adjustment_get_lower                           Accessor
;;;     gtk_adjustment_get_page_increment                  Accessor
;;;     gtk_adjustment_get_page_size                       Accessor
;;;     gtk_adjustment_get_step_increment                  Accessor
;;;     gtk_adjustment_get_minimum_increment
;;;     gtk_adjustment_get_upper                           Accessor
;;;     gtk_adjustment_set_lower                           Accessor
;;;     gtk_adjustment_set_page_increment                  Accessor
;;;     gtk_adjustment_set_page_size                       Accessor
;;;     gtk_adjustment_set_step_increment                  Accessor
;;;     gtk_adjustment_set_upper                           Accessor
;;;
;;; Properties
;;;
;;;     gdouble    lower             Read / Write
;;;     gdouble    page-increment    Read / Write
;;;     gdouble    page-size         Read / Write
;;;     gdouble    step-increment    Read / Write
;;;     gdouble    upper             Read / Write
;;;     gdouble    value             Read / Write
;;;
;;; Signals
;;;
;;;        void    changed           No Recursion
;;;        void    value-changed     No Recursion
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkAdjustment
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; GtkAdjustment
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkAdjustment" adjustment
  (:superclass g:initially-unowned
   :export t
   :interfaces nil
   :type-initializer "gtk_adjustment_get_type")
  ((lower
    adjustment-lower
    "lower" "gdouble" t t)
   (page-increment
    adjustment-page-increment
    "page-increment" "gdouble" t t)
   (page-size
    adjustment-page-size
    "page-size" "gdouble" t t)
   (step-increment
    adjustment-step-increment
    "step-increment" "gdouble" t t)
   (upper
    adjustment-upper
    "upper" "gdouble" t t)
   (value
    adjustment-value
    "value" "gdouble" t t)))

#+liber-documentation
(setf (documentation 'adjustment 'type)
 "@version{#2021-12-18}
  @begin{short}
    The @sym{gtk:adjustment} object represents a value which has an associated
    lower and upper bound, together with step and page increments, and a page
    size.
  @end{short}
  It is used within several widgets, including the @class{gtk:spin-button},
  @class{gtk:viewport}, and @class{gtk:range} widget, which is a base class for
  the @class{gtk:scrollbar}, and @class{gtk:scale} widgets.

  The @sym{gtk:adjustment} object does not update the value itself. Instead it
  is left up to the owner of the @sym{gtk:adjustment} object to control the
  value.
  @begin[Signal Details]{dictionary}
    @subheading{The \"changed\" signal}
      @begin{pre}
 lambda (adjustment)    :no-recurse
      @end{pre}
      Emitted when one or more of the adjustment properties have been changed,
      other than the @code{value} property.
      @begin[code]{table}
        @entry[adjustment]{The @sym{gtk:adjustment} object which received the
          signal.}
      @end{table}
    @subheading{The \"value-changed\" signal}
      @begin{pre}
 lambda (adjustment)    :no-recurse
      @end{pre}
      Emitted when the @code{value} property of the adjustment has been changed.
      @begin[code]{table}
        @entry[adjustment]{The @sym{gtk:adjustment} object which received the
          signal.}
      @end{table}
  @end{dictionary}
  @see-slot{gtk:adjustment-lower}
  @see-slot{gtk:adjustment-page-increment}
  @see-slot{gtk:adjustment-page-size}
  @see-slot{gtk:adjustment-step-increment}
  @see-slot{gtk:adjustment-upper}
  @see-slot{gtk:adjustment-value}
  @see-class{gtk:range}
  @see-class{gtk:viewport}
  @see-class{gtk:spin-button}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- adjustment-lower ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "lower" 'adjustment) t)
 "The @code{lower} property of type @code{:double} (Read / Write) @br{}
  The minimum value of the adjustment. @br{}
  Default value: 0.0")

#+liber-documentation
(setf (liber:alias-for-function 'adjustment-lower)
      "Accessor"
      (documentation 'adjustment-lower 'function)
 "@version{#2020-12-18}
  @syntax[]{(gtk:adjustment-lower object) => lower}
  @syntax[]{(setf (gtk:adjustment-lower object) lower)}
  @argument[object]{a @class{gtk:adjustment} object}
  @argument[lower]{a double float with the minimum value}
  @begin{short}
    Accessor of the @slot[gtk:adjustment]{lower} slot of the
    @class{gtk:adjustment} class.
  @end{short}

  The @sym{gtk:adjustment-lower} slot access function retrieves the minimum
  value of the adjustment. The @sym{(setf gtk:adjustment-lower)} slot access
  function sets the minimum value of the adjustment.

  When setting multiple adjustment properties via their individual setters,
  multiple \"changed\" signals will be emitted. However, since the emission of
  the \"changed\" signal is tied to the emission of the \"notify\" signals of
  the changed properties, it is possible to compress the \"changed\"
  signals into one by calling the @fun{g:object-freeze-notify} and
  @fun{g:object-thaw-notify} functions around the calls to the individual
  setters.

  Alternatively, using the @fun{gtk:adjustment-configure} function has the same
  effect of compressing \"changed\" emissions.
  @see-class{gtk:adjustment}
  @see-function{g:object-freeze-notify}
  @see-function{g:object-thaw-notify}
  @see-function{gtk:adjustment-configure}")

;;; --- adjustment-page-increment ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "page-increment" 'adjustment)
     t)
 "The @code{page-increment} property of type @code{:double} (Read / Write) @br{}
  The page increment of the adjustment. @br{}
  Default value: 0.0")

#+liber-documentation
(setf (liber:alias-for-function 'adjustment-page-increment)
      "Accessor"
      (documentation 'adjustment-page-increment 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:adjustment-page-increment object) => page-increment}
  @syntax[]{(setf (gtk:adjustment-page-increment object) page-increment)}
  @argument[object]{a @class{gtk:adjustment} object}
  @argument[page-increment]{a double float with the page increment}
  @begin{short}
    Accessor of the @slot[gtk:adjustment]{page-increment} slot of the
    @class{gtk:adjustment} class.
  @end{short}

  The @sym{gtk:adjustment-page-increment} slot access function retrieves the
  page increment of the adjustment. The
  @sym{(setf gtk:adjustment-page-increment)} slot access function sets the page
  increment of the adjustment.

  See the @fun{gtk:adjustment-lower} slot access function about how to compress
  multiple emissions of the \"changed\" signal when setting multiple adjustment
  properties.
  @see-class{gtk:adjustment}
  @see-function{gtk:adjustment-lower}")

;;; --- adjustment-page-size -----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "page-size" 'adjustment) t)
 "The @code{page-size} property of type @code{:double} (Read / Write) @br{}
  The page size of the adjustment. Note that the page size is irrelevant and
  should be set to zero if the adjustment is used for a simple scalar value.
  @br{}
  Default value: 0.0")

#+liber-documentation
(setf (liber:alias-for-function 'adjustment-page-size)
      "Accessor"
      (documentation 'adjustment-page-size 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:adjustment-page-size object) => page-size}
  @syntax[]{(setf (gtk:adjustment-page-size object) page-size)}
  @argument[object]{a @class{gtk:adjustment} object}
  @argument[page-size]{a double float with the page size}
  @begin{short}
    Accessor of the @slot[gtk:adjustment]{page-size} slot of the
    @class{gtk:adjustment} class.
  @end{short}

  The @sym{gtk:adjustment-page-size} slot access function retrieves the page
  size of the adjustment. The @sym{(setf gtk:adjustment-page-size)} slot access
  function sets the page size of the adjustment.

  See the @fun{gtk:adjustment-lower} slot access function about how to compress
  multiple emissions of the \"changed\" signal when setting multiple adjustment
  properties.
  @see-class{gtk:adjustment}
  @see-function{gtk:adjustment-lower}")

;;; --- adjustment-step-increment ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "step-increment" 'adjustment)
      t)
 "The @code{step-increment} property of type @code{:double} (Read / Write) @br{}
  The step increment of the adjustment. @br{}
  Default value: 0.0")

#+liber-documentation
(setf (liber:alias-for-function 'adjustment-step-increment)
      "Accessor"
      (documentation 'adjustment-step-increment 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:adjustment-step-increment object) => step-increment}
  @syntax[]{(setf (gtk:adjustment-step-increment object) step-increment)}
  @argument[object]{a @class{gtk:adjustment} object}
  @argument[step-increment]{a double float with the step increment}
  @begin{short}
    Accessor of the @slot[gtk:adjustment]{step-increment} slot of the
    @class{gtk:adjustment} class.
  @end{short}

  The @sym{gtk:adjustment-step-increment} slot access function retrieves the
  step increment of the adjustment. The
  @sym{(setf gtk:adjustment-step-increment)} slot access function sets the step
  increment of the adjustment.

  See the @fun{gtk:adjustment-lower} slot access function about how to compress
  multiple emissions of the \"changed\" signal when setting multiple adjustment
  properties.
  @see-class{gtk:adjustment}
  @see-function{gtk:adjustment-lower}")

;;; --- adjustment-upper ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "upper" 'adjustment) t)
 "The @code{upper} property of type @code{:double} (Read / Write) @br{}
  The maximum value of the adjustment. Note that values will be restricted by
  @code{upper} - @code{page-size} if the @code{page-size} property is nonzero.
  @br{}
  Default value: 0.0")

#+liber-documentation
(setf (liber:alias-for-function 'adjustment-upper)
      "Accessor"
      (documentation 'adjustment-upper 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:adjustment-upper object) => upper}
  @syntax[]{(setf (gtk:adjustment-upper object) upper)}
  @argument[object]{a @class{gtk:adjustment} object}
  @argument[upper]{a double float with the maximum value}
  @begin{short}
    Accessor of the @slot[gtk:adjustment]{upper} slot of the
    @class{gtk:adjustment} class.
  @end{short}

  The @sym{gtk:adjustment-upper} slot access function retrieves the maximum
  value of the adjustment. The @sym{(setf gtk:adjustment-upper)} slot access
  function sets the maximum value of the adjustment.

  Note that values will be restricted by the @code{(@slot[gtk:adjustment]{upper}
  - @slot[gtk:adjustment]{page-size})} value if the
  @slot[gtk:adjustment]{page-size} value is nonzero.

  See the @fun{gtk:adjustment-lower} slot access function about how to compress
  multiple emissions of the \"changed\" signal when setting multiple adjustment
  properties.
  @see-class{gtk:adjustment}
  @see-function{gtk:adjustment-lower}
  @see-function{gtk:adjustment-upper}
  @see-function{gtk:adjustment-page-size}")

;;; --- adjustment-value ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "value" 'adjustment) t)
 "The @code{value} property of type @code{:double} (Read / Write) @br{}
  The value of the adjustment. @br{}
  Default value: 0.0")

#+liber-documentation
(setf (liber:alias-for-function 'adjustment-value)
      "Accessor"
      (documentation 'adjustment-value 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:adjustment-value object) => value}
  @syntax[]{(setf (gtk:adjustment-value object) value)}
  @argument[object]{a @class{gtk:adjustment} object}
  @argument[value]{a double float with the value}
  @begin{short}
    Accessor of the @slot[gtk:adjustment]{value} slot of the
    @class{gtk:adjustment} class.
  @end{short}

  The @sym{gtk:adjustment-value} slot access function gets the current value of
  the adjustment. The @sym{(setf gtk:adjustment-value)} slot access function
  sets the adjustment value. The value is clamped to lie between the
  @slot[gtk:adjustment]{lower} and @slot[gtk:adjustment]{upper} values.

  Note that for adjustments which are used in a @class{gtk:scrollbar} widget,
  the effective range of allowed values goes from the
  @slot[gtk:adjustment]{lower} to @code{(@slot[gtk:adjustment]{upper} -
  @slot[gtk:adjustment]{page-size})} values.
  @see-class{gtk:adjustment}
  @see-function{gtk:adjustment-lower}
  @see-function{gtk:adjustment-upper}
  @see-function{gtk:adjustment-page-size}")

;;; ----------------------------------------------------------------------------
;;; gtk_adjustment_new ()
;;; ----------------------------------------------------------------------------

(defun adjustment-new (value
                           lower
                           upper
                           step-increment
                           page-increment
                           page-size)
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[value]{a double float with the initial value}
  @argument[lower]{a double float with the minimum value}
  @argument[upper]{a double with the maximum value}
  @argument[step-increment]{a double float with the step increment}
  @argument[page-increment]{a double float with the page increment}
  @argument[page-size]{a double float with the page size}
  @return{A new @class{gtk:adjustment} object.}
  @short{Creates a new adjustment.}
  @see-class{gtk:adjustment}"
  (let ((adjustment (make-instance 'adjustment
                                   :lower lower
                                   :upper upper
                                   :step-increment step-increment
                                   :page-increment page-increment
                                   :page-size page-size)))
    ;; ensure setting of the arguments lower and upper and then value
    (setf (adjustment-value adjustment) value)
    adjustment))

(export 'adjustment-new)

;;; ----------------------------------------------------------------------------
;;; gtk_adjustment_clamp_page ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_adjustment_clamp_page" adjustment-clamp-page) :void
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[adjustment]{a @class{gtk:adjustment} object}
  @argument[lower]{a double float with the lower value}
  @argument[upper]{a double float with the upper value}
  @begin{short}
    Updates the adjustment value to ensure that the range between @code{lower}
    and @code{upper} is in the current page.
  @end{short}
  If the range is larger than the page size, then only the start of it will be
  in the current page. A \"changed\" signal will be emitted if the value is
  changed.
  @see-class{gtk:adjustment}"
  (adjustment (g:object adjustment))
  (lower :double)
  (upper :double))

(export 'adjustment-clamp-page)

;;; ----------------------------------------------------------------------------
;;; gtk_adjustment_changed ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_adjustment_changed" adjustment-changed) :void
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[adjustment]{a @class{gtk:adjustment} object}
  @begin{short}
    Emits a \"changed\" signal from the @class{gtk:adjustment}.
  @end{short}
  This is typically called by the owner of the adjustment after it has changed
  any of the adjustment fields other than the value.
  @begin[Warning]{dictionary}
    The @sym{gtk:adjustment-changed} function has been deprecated since version
    3.18 and should not be used in newly written code. GTK emits the \"changed\"
    signal itself whenever any of the properties (other than the
    @slot[gtk:adjustment]{value}) property change.
  @end{dictionary}
  @see-class{gtk:adjustment}
  @see-function{gtk:adjustment-value}"
  (adjustment (g:object adjustment)))

(export 'adjustment-changed)

;;; ----------------------------------------------------------------------------
;;; gtk_adjustment_value_changed ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_adjustment_value_changed" adjustment-value-changed) :void
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[adjustment]{a @class{gtk:adjustment} object}
  @begin{short}
    Emits a \"value_changed\" signal from the adjustment.
  @end{short}
  This is typically called by the owner of the adjustment after it has changed
  the adjustment @slot[gtk:adjustment]{value} property.
  @begin[Warning]{dictionary}
    The @sym{gtk:adjustment-value-changed} function has been deprecated since
    version 3.18 and should not be used in newly written code. GTK emits the
    \"value-changed\" signal itself whenever any of the properties (other than
    value) change.
  @end{dictionary}
  @see-class{gtk:adjustment}"
  (adjustment (g:object adjustment)))

(export 'adjustment-value-changed)

;;; ----------------------------------------------------------------------------
;;; gtk_adjustment_configure ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_adjustment_configure" adjustment-configure) :void
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[adjustment]{a @class{gtk:adjustment} object}
  @argument[value]{a double float with the new value}
  @argument[lower]{a double float with the new minimum value}
  @argument[upper]{a double float with the new maximum value}
  @argument[step-increment]{a double float with the new step increment}
  @argument[page-increment]{a double float with the new page increment}
  @argument[page-size]{a double float with the new page size}
  @begin{short}
    Sets all properties of the adjustment at once.
  @end{short}
  Use this function to avoid multiple emissions of the \"changed\" signal. See
  the @fun{gtk:adjustment-lower} function for an alternative way of compressing
  multiple emissions of \"changed\" signals into one.
  @see-class{gtk:adjustment}
  @see-function{gtk:adjustment-lower}"
  (adjustment (g:object adjustment))
  (value :double)
  (lower :double)
  (upper :double)
  (step-increment :double)
  (page-increment :double)
  (page-size :double))

(export 'adjustment-configure)

;;; ----------------------------------------------------------------------------
;;; gtk_adjustment_get_minimum_increment () -> adjustment-minimum-increment
;;; ----------------------------------------------------------------------------

(declaim (inline adjustment-minimum-increment))

(defun adjustment-minimum-increment (adjustment)
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[adjustment]{a @class{gtk:adjustment} object}
  @return{A double float with the minimum increment of the adjustment.}
  @short{Gets the smaller of step increment and page increment.}
  @see-class{gtk:adjustment}
  @see-function{gtk:adjustment-step-increment}
  @see-function{gtk:adjustment-page-increment}"
  (min (adjustment-step-increment adjustment)
       (adjustment-page-increment adjustment)))

(export 'adjustment-minimum-increment)

;;; --- End of file gtk.adjustment.lisp ----------------------------------------
