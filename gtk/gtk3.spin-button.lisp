;;; ----------------------------------------------------------------------------
;;; gtk3.spin-button.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk3/>.
;;;
;;; Copyright (C) 2011 - 2024 Dieter Kaiser
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
;;; GtkSpinButton
;;;
;;;     Retrieve an integer or floating point number from the user.
;;;
;;; Types and Values
;;;
;;;     GtkSpinButton
;;;     GtkSpinButtonUpdatePolicy
;;;     GtkSpinType
;;;
;;;     GTK_INPUT_ERROR
;;;
;;; Functions
;;;
;;;     gtk_spin_button_configure
;;;     gtk_spin_button_new
;;;     gtk_spin_button_new_with_range
;;;     gtk_spin_button_set_increments
;;;     gtk_spin_button_set_range
;;;     gtk_spin_button_get_value_as_int
;;;     gtk_spin_button_spin
;;;     gtk_spin_button_update
;;;     gtk_spin_button_get_increments
;;;     gtk_spin_button_get_range
;;;
;;; Properties
;;;
;;;     adjustment
;;;     climb-rate
;;;     digits
;;;     numeric
;;;     snap-to-ticks
;;;     update-policy
;;;     value
;;;     wrap
;;;
;;; Style Properties
;;;
;;;     shadow-type
;;;
;;; Signals
;;;
;;;     change-value
;;;     input
;;;     output
;;;     value-changed
;;;     wrapped
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;            ╰── GtkEntry
;;;                 ╰── GtkSpinButton
;;;
;;; Implemented Interfaces
;;;
;;;     GtkSpinButton implements AtkImplementorIface, GtkBuildable, GtkEditable,
;;;     GtkCellEditable and GtkOrientable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; GtkSpinButtonUpdatePolicy
;;; ----------------------------------------------------------------------------

(gobject:define-genum "GtkSpinButtonUpdatePolicy" spin-button-update-policy
  (:export t
   :type-initializer "gtk_spin_button_update_policy_get_type")
  (:always 0)
  (:if-valid 1))

#+liber-documentation
(setf (liber:alias-for-symbol 'spin-button-update-policy)
      "GEnum"
      (liber:symbol-documentation 'spin-button-update-policy)
 "@version{#2024-3-22}
  @begin{declaration}
(gobject:define-genum \"GtkSpinButtonUpdatePolicy\" spin-button-update-policy
  (:export t
   :type-initializer \"gtk_spin_button_update_policy_get_type\")
  (:always 0)
  (:if-valid 1))
  @end{declaration}
  @begin{values}
    @begin[code]{table}
      @entry[:always]{When refreshing the spin button, the value is always
        displayed}
      @entry[:if-valid]{When refreshing the spin button, the value is only
        displayed if it is valid within the bounds of the spin button's
        adjustment.}
    @end{table}
  @end{values}
  @begin{short}
    The spin button update policy determines whether the spin button displays
    values even if they are outside the bounds of its adjustment. See the
    @fun{gtk:spin-button-update-policy} function.
  @end{short}
  @see-class{gtk:spin-button}
  @see-function{gtk:spin-button-update-policy}")

;;; ----------------------------------------------------------------------------
;;; GtkSpinType
;;; ----------------------------------------------------------------------------

(gobject:define-genum "GtkSpinType" spin-type
  (:export t
   :type-initializer "gtk_spin_type_get_type")
  (:step-forward 0)
  (:step-backward 1)
  (:page-forward 2)
  (:page-backward 3)
  (:home 4)
  (:end 5)
  (:user-defined 6))

#+liber-documentation
(setf (liber:alias-for-symbol 'spin-type)
      "GEnum"
      (liber:symbol-documentation 'spin-type)
 "@version{#2024-3-22}
  @begin{declaration}
(gobject:define-genum \"GtkSpinType\" spin-type
  (:export t
   :type-initializer \"gtk_spin_type_get_type\")
  (:step-forward 0)
  (:step-backward 1)
  (:page-forward 2)
  (:page-backward 3)
  (:home 4)
  (:end 5)
  (:user-defined 6))
  @end{declaration}
  @begin{values}
    @begin[code]{table}
      @entry[:step-forward]{Increment by the adjustments step increment.}
      @entry[:step-backward]{Decrement by the adjustments step increment.}
      @entry[:page-forward]{Increment by the adjustments page increment.}
      @entry[:page-backward]{Decrement by the adjustments page increment.}
      @entry[:home]{Go to the adjustments lower bound.}
      @entry[:end]{Go to the adjustments upper bound.}
      @entry[:user-defined]{Change by a specified amount.}
    @end{table}
  @end{values}
  @begin{short}
    The values of the @symbol{gtk:spin-type} enumeration are used to specify
    the change to make in the @fun{gtk:spin-button-spin} function.
  @end{short}
  @see-class{gtk:spin-button}
  @see-function{gtk:spin-button-spin}")

;;; ----------------------------------------------------------------------------
;;; GTK_INPUT_ERROR
;;;
;;; #define GTK_INPUT_ERROR -1
;;;
;;; Constant to return from a signal handler for the "input" signal in case of
;;; conversion failure.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; struct GtkSpinButton
;;; ----------------------------------------------------------------------------

(gobject:define-gobject "GtkSpinButton" spin-button
  (:superclass entry
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkEditable"
                "GtkCellEditable"
                "GtkOrientable")
   :type-initializer "gtk_spin_button_get_type")
  ((adjustment
    spin-button-adjustment
    "adjustment" "GtkAdjustment" t t)
   (climb-rate
    spin-button-climb-rate
    "climb-rate" "gdouble" t t)
   (digits
    spin-button-digits
    "digits" "guint" t t)
   (numeric
    spin-button-numeric
    "numeric" "gboolean" t t)
   (snap-to-ticks
    spin-button-snap-to-ticks
    "snap-to-ticks" "gboolean" t t)
   (update-policy
    spin-button-update-policy
    "update-policy" "GtkSpinButtonUpdatePolicy" t t)
   (value
    spin-button-value
    "value" "gdouble" t t)
   (wrap
    spin-button-wrap
    "wrap" "gboolean" t t)))

#+liber-documentation
(setf (documentation 'spin-button 'type)
 "@version{2023-12-29}
  @begin{short}
    The @class{gtk:spin-button} widget is an ideal way to allow the user to set
    the value of some attribute.
  @end{short}
  Rather than having to directly type a number into a @class{gtk:entry} widget,
  the spin button allows the user to click on one of two arrows to increment or
  decrement the displayed value. A value can still be typed in, with the bonus
  that it can be checked to ensure it is in a given range.

  @image[spinbutton]{Figure: GtkSpinButton}

  The main properties of a @class{gtk:spin-button} widget are through an
  adjustment. See the @class{gtk:adjustment} class for more details about an
  adjustment's properties. Note that the spin button will by default make its
  entry large enough to accomodate the lower and upper bounds of the adjustment,
  which can lead to surprising results. Best practice is to set both the
  @code{width-chars} and @code{max-width-chars} poperties to the desired number
  of characters to display in the entry.
  @begin[CSS nodes]{dictionary}
    @begin{pre}
 spinbutton.horizontal
 ├── undershoot.left
 ├── undershoot.right
 ├── entry
 │   ╰── ...
 ├── button.down
 ╰── button.up

 spinbutton.vertical
 ├── undershoot.left
 ├── undershoot.right
 ├── button.up
 ├── entry
 │   ╰── ...
 ╰── button.down
    @end{pre}
  @end{dictionary}
  The @class{gtk:spin-button} implementation main CSS node has the name
  @code{spinbutton}. It creates subnodes for the entry and the two buttons,
  with these names. The button nodes have the @code{.up} and @code{.down} style
  classes. The @class{gtk:entry} subnodes, if present, are put below the
  entry node. The orientation of the spin button is reflected in the
  @code{.vertical} or @code{.horizontal} style class on the main node.
  @begin[Examples]{dictionary}
    Code fragment for creating a spin button. The value from the spin button is
    retrieved with the @fun{gtk:spin-button-value} function in a signal handler
    as a floating point number. Use the @fun{gtk:spin-button-value-as-int}
    function to retrieve the value as an integer.
    @begin{pre}
(let (...
      (spinner (make-instance 'gtk:spin-button
                              :adjustment
                              (make-instance 'gtk:adjustment
                                             :value 50.0
                                             :lower 0.0
                                             :upper 100.0
                                             :step-increment 1.0
                                             :page-increment 5.0
                                             :page-size 0.0)
                              :climb-rate 0
                              :digits 0
                              :wrap t)))

  (g:signal-connect spinner \"value-changed\"
                    (lambda (widget)
                      (let ((value (gtk:spin-button-value widget)))))
                        ... ))
    @end{pre}
  @end{dictionary}
  @begin[Style Property Details]{dictionary}
    @begin[code]{table}
      @begin[shadow-type]{entry}
        The \"shadow-type\" style property of type @symbol{gtk:shadow-type}
        (Read) @br{}
        Style of bevel around the spin button. @br{}
        @em{Warning:} The @code{shadow-type} style property has been deprecated
        since version 3.20 and should not be used in newly written code. Use CSS
        to determine the style of the border. The value of this style property
        is ignored. @br{}
        Default value: @code{:in}
      @end{entry}
    @end{table}
  @end{dictionary}
  @begin[Signal Details]{dictionary}
    @subheading{The \"change-value\" signal}
      @begin{pre}
lambda (spinbutton scroll)    :action
      @end{pre}
      Keybinding signal which gets emitted when the user initiates a value
      change. Applications should not connect to it, but may emit it with the
      @fun{g:signal-emit} function if they need to control the cursor
      programmatically. The default bindings for this signal are Up/Down and
      PageUp and/PageDown.
      @begin[code]{table}
        @entry[spinbutton]{The @class{gtk:spin-button} widget on which the
          signal was emitted.}
        @entry[scroll]{A value of the @symbol{gtk:scroll-type} enumeration to
          specify the speed and amount of change.}
      @end{table}
    @subheading{The \"input\" signal}
      @begin{pre}
lambda (spinbutton new-value)    :run-last
      @end{pre}
      Can be used to influence the conversion of the users input into a double
      float value. The signal handler is expected to use the
      @fun{gtk:entry-text} function to retrieve the text of the entry and set
      @arg{new-value} to the new value. The default conversion uses the
      @code{g_strtod()} function.
      @begin[code]{table}
        @entry[spinbutton]{The @class{gtk:spin-button} widget on which the
          signal was emitted.}
        @entry[new-value]{A pointer to a double float with the return location
          for the new value.}
        @entry[Returns]{@em{True} for a successful conversion, @em{false} if
          the input was not handled, and @code{GTK_INPUT_ERROR} if the
          conversion failed.}
      @end{table}
    @subheading{The \"output\" signal}
      @begin{pre}
lambda (spinbutton)    :run-last
      @end{pre}
      Can be used to change the formatting of the value that is displayed in
      the spin buttons entry.
      @begin{pre}
(let (...
      ;; A spin button for a number
      (spinner1 (make-instance 'gtk:spin-button
                               :adjustment
                               (make-instance 'gtk:adjustment
                                              :value 1.0
                                              :lower -10000.0
                                              :upper  10000.0
                                              :step-increment 0.5
                                              :page-increment 100.0
                                              :page-size 0.0)
                               :climb-rate 1.0
                               :digits 2
                               :wrap t))
      ;; A spin button for the digits to display
      (spinner2 (make-instance 'gtk:spin-button
                               :adjustment
                               (make-instance 'gtk:adjustment
                                              :value 2
                                              :lower 1
                                              :upper 5
                                              :step-increment 1
                                              :page-increment 1
                                              :page-size 0)
                                :climb-rate 0.0
                                :digits 0
                                :wrap t)))
  ;; Customize the appearance of the number
  (g:signal-connect spinner1 \"output\"
    (lambda (spin-button)
      (let ((value (gtk:adjustment-value
                     (gtk:spin-button-adjustment spin-button)))
            (digits (truncate
                      (gtk:adjustment-value
                        (gtk:spin-button-adjustment spinner2)))))
        (setf (gtk:entry-text spin-button)
              (format nil \"~@@?\" (format nil \"~~,~d@@f\" digits) value)))))
  ... )
      @end{pre}
      @begin[code]{table}
        @entry[spinbutton]{The @class{gtk:spin-button} widget which received
          the signal.}
        @entry[Returns]{@em{True} if the value has been displayed.}
      @end{table}
    @subheading{The \"value-changed\" signal}
      @begin{pre}
lambda (spinbutton)    :run-last
      @end{pre}
      Is emitted when the value represented by @arg{spin-button} changes. Also
      see the @code{\"output\"} signal.
      @begin[code]{table}
        @entry[spinbutton]{The @class{gtk:spin-button} widget on which the
          signal was emitted.}
      @end{table}
    @subheading{The \"wrapped\" signal}
      @begin{pre}
lambda (spinbutton)    :run-last
      @end{pre}
      Is emitted right after the spin button wraps from its maximum to minimum
      value or vice versa.
      @begin[code]{table}
        @entry[spinbutton]{The @class{gtk:spin-button} widget which received
          the signal.}
      @end{table}
  @end{dictionary}
  @see-constructor{gtk:spin-button-new}
  @see-constructor{gtk:spin-button-new-with-range}
  @see-slot{gtk:spin-button-adjustment}
  @see-slot{gtk:spin-button-climb-rate}
  @see-slot{gtk:spin-button-digits}
  @see-slot{gtk:spin-button-numeric}
  @see-slot{gtk:spin-button-snap-to-ticks}
  @see-slot{gtk:spin-button-update-policy}
  @see-slot{gtk:spin-button-value}
  @see-slot{gtk:spin-button-wrap}
  @see-class{gtk:entry}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- gtk:spin-button-adjustment ---------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "adjustment" 'spin-button) t)
 "The @code{adjustment} property of type @class{gtk:adjustment} (Read / Write)
  @br{}
  The adjustment that holds the value of the spin button.")

#+liber-documentation
(setf (liber:alias-for-function 'spin-button-adjustment)
      "Accessor"
      (documentation 'spin-button-adjustment 'function)
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-adjustment object) => adjustment}
  @syntax{(setf (gtk:spint-button-adjustment object) adjustment)}
  @argument[object]{a @class{gtk:spin-button} widget}
  @argument[adjustment]{a @class{gtk:adjustment} object to replace the existing
    adjustment}
  @begin{short}
    Accessor of the @slot[gtk:spin-button]{adjustment} slot of the
    @class{gtk:spin-button} class.
  @end{short}
  The @fun{gtk:spin-button-adjustment} function gets the adjustment associated
  with a spin button. The @setf{gtk:spin-button-adjustment} function replaces
  the adjustment.
  @see-class{gtk:spin-button}
  @see-class{gtk:adjustment}")

;;; --- gtk:spin-button-climb-rate ---------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "climb-rate" 'spin-button) t)
 "The @code{climb-rate} property of type @code{:double} (Read / Write) @br{}
  The acceleration rate when you hold down a button. @br{}
  Allowed values: >= 0 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'spin-button-climb-rate)
      "Accessor"
      (documentation 'spin-button-climb-rate 'function)
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-climb-rate object) => rate}
  @syntax{(setf (gtk:spint-button-climb-rate object) rate)}
  @argument[object]{a @class{gtk:spin-button} widget}
  @argument[rate]{a double float with the acceleration rate}
  @begin{short}
    Accessor of the @slot[gtk:spin-button]{climb-rate} slot of the
    @class{gtk:spin-button} class.
  @end{short}
  The @fun{gtk:spin-button-climb-rate} function gets the acceleration rate when
  you hold down a button. The @setf{gtk:spin-button-climb-rate} function sets
  the acceleration rate.
  @see-class{gtk:spin-button}")

;;; --- gtk:spin-button-digits -------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "digits" 'spin-button) t)
 "The @code{digits} property of type @code{:uint} (Read / Write) @br{}
  The number of decimal places to display. @br{}
  Allowed values: <= 20 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'spin-button-digits)
      "Accessor"
      (documentation 'spin-button-digits 'function)
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-digits object) => digits}
  @syntax{(setf (gtk:spint-button-digits object) digits)}
  @argument[object]{a @class{gtk:spin-button} widget}
  @argument[digits]{an unsigned integer with the number of digits after the
    decimal point to be displayed for the spin button's value}
  @begin{short}
    Accessor of the @slot[gtk:spin-button]{digits} slot of the
    @class{gtk:spin-button} class.
  @end{short}
  The @fun{gtk:spin-button-digits} function fetches the precision to be
  displayed by the spin button. The @setf{gtk:spin-button-digits} function sets
  the precision. Up to 20 digit precision is allowed.
  @see-class{gtk:spin-button}")

;;; --- gtk:spin-button-numeric ------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "numeric" 'spin-button) t)
 "The @code{numeric} property of type @code{:boolean} (Read / Write) @br{}
  Whether non numeric characters should be ignored. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'spin-button-numeric)
      "Accessor"
      (documentation 'spin-button-numeric 'function)
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-numeric object) => numeric}
  @syntax{(setf (gtk:spin-button-numeric object) numeric)}
  @argument[object]{a @class{gtk:spin-button} widget}
  @argument[numeric]{a boolean indicating if only numeric entry is allowed}
  @begin{short}
    Accessor of the @slot[gtk:spin-button]{numeric} slot of the
    @class{gtk:spin-button} class.
  @end{short}
  The @fun{gtk:spin-button-numeric} function returns whether non numeric text
  can be typed into the spin button. The @setf{gtk:spin-button-numeric}
  function sets the flag.
  @see-class{gtk:spin-button}")

;;; --- gtk:spin-button-snap-to-ticks ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "snap-to-ticks" 'spin-button) t)
 "The @code{snap-to-ticks} property of type @code{:boolean} (Read / Write) @br{}
  Whether erroneous values are automatically changed to a spin button's nearest
  step increment. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'spin-button-snap-to-ticks)
      "Accessor"
      (documentation 'spin-button-snap-to-ticks 'function)
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-snap-to-ticks object) => snap-to-ticks}
  @syntax{(setf (gtk:spin-button-snap-to-ticks object) snap-to-ticks)}
  @argument[object]{a @class{gtk:spin-button} widget}
  @argument[snap-to-ticks]{a boolean indicating if invalid values should be
    corrected}
  @begin{short}
    Accessor of the @slot[gtk:spin-button]{snap-to-ticks} slot of the
    @class{gtk:spin-button} class.
  @end{short}
  The @fun{gtk:spin-button-snap-to-ticks} function returns whether the values
  are corrected to the nearest step. The @setf{gtk:spin-button-snap-to-ticks}
  function sets the policy as to whether values are corrected to the nearest
  step increment when a spin button is activated after providing an invalid
  value.
  @see-class{gtk:spin-button}")

;;; --- gtk:spin-button-update-policy ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "update-policy" 'spin-button) t)
 "The @code{update-policy} property of type
  @symbol{gtk:spin-button-update-policy} (Read / Write) @br{}
  Whether the spin button should update always, or only when the value is
  legal. @br{}
  Default value: @code{:always}")

#+liber-documentation
(setf (liber:alias-for-function 'spin-button-update-policy)
      "Accessor"
      (documentation 'spin-button-update-policy 'function)
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-update-policy object) => update-policy}
  @syntax{(setf (gtk:spin-button-upadate-policy object) update-policy)}
  @argument[object]{a @class{gtk:spin-button} widget}
  @argument[policy]{a value of the @symbol{gtk:spin-button-update-policy}
    enumeration}
  @begin{short}
    Accessor of the @slot[gtk:spin-button]{update-policy} slot of the
    @class{gtk:spin-button} class.
  @end{short}
  The @fun{gtk:spin-button-update-policy} function gets the update behavior of
  a spin button. The @setf{gtk:spin-button-update-policy} function sets the
  update behavior. This determines whether the spin button is always updated or
  only when a valid value is set.
  @see-class{gtk:spin-button}
  @see-symbol{gtk:spin-button-update-policy}")

;;; --- gtk:spin-button-value --------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "value" 'spin-button) t)
 "The @code{value} property of type @code{:double} (Read / Write) @br{}
  Reads the current value, or sets a new value. @br{}
  Default value: 0.0")

#+liber-documentation
(setf (liber:alias-for-function 'spin-button-value)
      "Accessor"
      (documentation 'spin-button-value 'function)
 "@version{2023-12-29}
  @syntax{(gtk:spin-button-value object) => value}
  @syntax{(setf (gtk:spin-button-value object) value)}
  @argument[object]{a @class{gtk:spin-button} widget}
  @argument[value]{a double float with the value of the spin button}
  @begin{short}
    Accessor of the @slot[gtk:spin-button]{value} slot of the
    @class{gtk:spin-button} class.
  @end{short}
  The @fun{gtk:spin-button-value} function gets the value of the spin button.
  The @setf{gtk:spin-button-value} function sets the value.
  @see-class{gtk:spin-button}")

;;; --- gtk:spin-button-wrap ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "wrap" 'spin-button) t)
 "The @code{wrap} property of type @code{:boolean} (Read / Write) @br{}
  Whether a spin button should wrap upon reaching its limits. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'spin-button-wrap)
      "Accessor"
      (documentation 'spin-button-wrap 'function)
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-value object) => wrap}
  @syntax{(setf (gtk:spin-button-value object) wrap)}
  @argument[object]{a @class{gtk:spin-button} widget}
  @argument[wrap]{a boolean indicating if wrapping behavior is performed}
  @begin{short}
    Accessor of the @slot[gtk:spin-button]{wrap} slot of the
    @class{gtk:spin-button} class.
  @end{short}
  The @fun{gtk:spin-button} function returns whether the spin button's value
  wraps around to the opposite limit when the upper or lower limit of the range
  is exceeded. The @setf{gtk:spin-button} function sets the flag that determines
  if a spin button value wraps around.
  @see-class{gtk:spin-button}")

;;; ----------------------------------------------------------------------------
;;; gtk_spin_button_configure ()
;;; ----------------------------------------------------------------------------

(cffi:defcfun ("gtk_spin_button_configure" spin-button-configure) :void
 #+liber-documentation
 "@version{#2023-3-12}
  @argument[spinbutton]{a @class{gtk:spin-button} widget}
  @argument[adjustment]{a @class{gtk:adjustment} object}
  @argument[rate]{a double float with the climb rate}
  @argument[digits]{an unsigned integer with the number of decimal places to
    display in the spin button}
  @begin{short}
    Changes the properties of an existing spin button.
  @end{short}
  The adjustment, climb rate, and number of decimal places are all changed
  accordingly, after this function call.
  @see-class{gtk:spin-button}
  @see-function{gtk:spin-button-adjustment}
  @see-function{gtk:spin-button-climb-rate}
  @see-function{gtk:spin-button-digits}"
  (spinbutton (g:object spin-button))
  (adjustment (g:object adjustment))
  (rate :double)
  (digits :uint))

(export 'spin-button-configure)

;;; ----------------------------------------------------------------------------
;;; gtk_spin_button_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline spin-button-new))

(defun spin-button-new (adjustment rate digits)
 #+liber-documentation
 "@version{#2023-3-12}
  @argument[adjustment]{a @class{gtk:adjustment} object that this spin button
    should use, or @code{nil}}
  @argument[rate]{a double float which specifies how much the spin button
    changes when an arrow is clicked on}
  @argument[digits]{an unsigned integer with the number of decimal places to
    display}
  @return{The new @class{gtk:spin-button} widget.}
  @begin{short}
    Creates a new spin button.
  @end{short}
  If the @arg{adjustment} argument is @code{nil}, the adjustment of the spin
  button is intialized with default values.
  @see-class{gtk:spin-button}
  @see-class{gtk:adjustment}"
  (make-instance 'spin-button
                 :adjustment adjustment
                 :climb-rate rate
                 :digits digits))

(export 'spin-button-new)

;;; ----------------------------------------------------------------------------
;;; gtk_spin_button_new_with_range ()
;;; ----------------------------------------------------------------------------

(cffi:defcfun ("gtk_spin_button_new_with_range" %spin-button-new-with-range)
    (g:object spin-button)
  (min :double)
  (max :double)
  (step :double))

(defun spin-button-new-with-range (min max step)
 #+liber-documentation
 "@version{#2023-3-12}
  @argument[min]{a double float with the minimum allowable value}
  @argument[max]{a double float with the maximum allowable value}
  @argument[step]{a double float with the increment added or subtracted by
    spinning the widget}
  @return{The new @class{gtk:spin-button} widget.}
  @begin{short}
    This is a convenience constructor that allows creation of a numeric
    spin button without manually creating an adjustment.
  @end{short}
  The value is initially set to the minimum value and a page increment of
  10 * @arg{step} is the default. The precision of the spin button is
  equivalent to the precision of @arg{step}.

  The way in which the precision is derived works best if @arg{step} is a power
  of ten. If the resulting precision is not suitable for your needs, use the
  @fun{gtk:spin-button-digits} function to correct it.
  @begin[Notes]{dictionary}
    In the Lisp implementation the arguments @arg{min}, @arg{max}, and
    @arg{step} are coerced to a double float number.
  @end{dictionary}
  @begin[Examples]{dictionary}
    In this example the arguments of the function are given as integer numbers.
    @begin{pre}
(defvar spinbutton (gtk:spin-button-new-with-range 5 15 5)) => SPINBUTTON
;; Get the adjustment of the spin button
(defvar adjustment (gtk:spin-button-adjustment spinbutton)) => ADJUSTMENT
;; Get the slots of the adjustment of the spin button
(gtk:adjustment-lower adjustment) => 5.0d0
(gtk:adjustment-page-increment adjustment) => 50.0d0
(gtk:adjustment-page-size adjustment) => 0.0d0
(gtk:adjustment-step-increment adjustment) => 5.0d0
(gtk:adjustment-upper adjustment) => 15.0d0
(gtk:adjustment-value adjustment) =>5.0d0
    @end{pre}
  @end{dictionary}
  @see-function{gtk:spin-button}
  @see-function{gtk:spin-button-digits}"
  (%spin-button-new-with-range (coerce min 'double-float)
                               (coerce max 'double-float)
                               (coerce step 'double-float)))

(export 'spin-button-new-with-range)

;;; ----------------------------------------------------------------------------
;;; gtk_spin_button_get_increments ()
;;; gtk_spin_button_set_increments () -> spin-button-increments
;;; ----------------------------------------------------------------------------

(defun (setf spin-button-increments) (increments spinbutton)
  (destructuring-bind (step page) increments
    (cffi:foreign-funcall "gtk_spin_button_set_increments"
                          (g:object spin-button) spinbutton
                          :double (coerce step 'double-float)
                          :double (coerce page 'double-float)
                          :void)
    (values step page)))

(cffi:defcfun ("gtk_spin_button_get_increments" %spin-button-increments) :void
  (spinbutton (g:object spin-button))
  (step (:pointer :double))
  (page (:pointer :double)))

(defun spin-button-increments (spinbutton)
 #+liber-documentation
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-increments spin-button) => step, page}
  @syntax{(setf (gtk:spin-button-increments spin-button) (list step page))}
  @argument[spinbutton]{a @class{gtk:spin-button} widget}
  @argument[step]{a double float increment applied for a button 1 press}
  @argument[page]{a double float increment applied for a button 2 press}
  @begin{short}
    Accessor of the step and page increments of the spin button.
  @end{short}
  The @fun{gtk:spin-button-increments} function gets the current step and page
  increments used by the spin button. The
  @setf{gtk:spin-button-increments} function sets the step and page increments.

  This affects how quickly the value changes when the spin button's arrows are
  activated.
  @begin[Notes]{dictionary}
    The values for the page and step increments are stored in the
    @slot[gtk:adjustment]{page-increment} and
    @slot[gtk:adjustment]{step-increment} slots of the adjustment associated
    with the spin button.
  @end{dictionary}
  @see-class{gtk:spin-button}
  @see-function{gtk:adjustment-page-increment}
  @see-function{gtk:adjustment-step-increment}"
  (cffi:with-foreign-objects ((step :double) (page :double))
    (%spin-button-increments spinbutton step page)
    (values (cffi:mem-ref step :double)
            (cffi:mem-ref page :double))))

(export 'spin-button-increments)

;;; ----------------------------------------------------------------------------
;;; gtk_spin_button_get_range ()
;;; gtk_spin_button_set_range () -> spin-button-range
;;; ----------------------------------------------------------------------------

(defun (setf spin-button-range) (range spinbutton)
  (destructuring-bind (min max) range
    (cffi:foreign-funcall "gtk_spin_button_set_range"
                          (g:object spin-button) spinbutton
                          :double (coerce min 'double-float)
                          :double (coerce max 'double-float)
                          :void)
    (values min max)))

(cffi:defcfun ("gtk_spin_button_get_range" %spin-button-range) :void
  (spinbutton (g:object spin-button))
  (min (:pointer :double))
  (max (:pointer :double)))

(defun spin-button-range (spinbutton)
 #+liber-documentation
 "@version{#2023-3-12}
  @syntax{(gtk:spin-button-range spin-button) => min, max}
  @syntax{(setf (gtk:spin-button-range spin-button) (list min max))}
  @argument[spinbutton]{a @class{gtk:spin-button} widget}
  @argument[min]{a double float minimum allowable value}
  @argument[max]{a double float maximum allowable value}
  @begin{short}
    Accessor of the minimum and maximum value of the spin button.
  @end{short}
  The @fun{gtk:spin-button-range} function gets the minimum and maximum allowed
  values for the spin button. The @setf{gtk:spin-button-range} function sets
  the minimum and maximum allowable values.

  If the current value is outside this range, it will be adjusted to fit
  within the range, otherwise it will remain unchanged.
  @see-class{gtk:spin-button}"
  (cffi:with-foreign-objects ((min :double) (max :double))
    (%spin-button-range spinbutton min max)
    (values (cffi:mem-ref min :double)
            (cffi:mem-ref max :double))))

(export 'spin-button-range)

;;; ----------------------------------------------------------------------------
;;; gtk_spin_button_get_value_as_int () -> spin-button-value-as-int
;;; ----------------------------------------------------------------------------

(defun spin-button-value-as-int (spinbutton)
 #+liber-documentation
 "@version{#2023-3-12}
  @argument[spinbutton]{a @class{gtk:spin-button} widget}
  @return{The integer with the value of @arg{spin-button}.}
  @begin{short}
    Gets the value of the spin button represented as an integer.
  @end{short}
  @see-class{gtk:spin-button}
  @see-function{gtk:spin-button-value}"
  (truncate (spin-button-value spinbutton)))

(export 'spin-button-value-as-int)

;;; ----------------------------------------------------------------------------
;;; gtk_spin_button_spin ()
;;; ----------------------------------------------------------------------------

(cffi:defcfun ("gtk_spin_button_spin" spin-button-spin) :void
 #+liber-documentation
 "@version{#2023-3-12}
  @argument[spinbutton]{a @class{gtk:spin-button} widget}
  @argument[direction]{a value of the @symbol{gtk:spin-type} enumeration
    indicating the direction to spin}
  @argument[increment]{a double float step increment to apply in the specified
    direction}
  @begin{short}
    Increment or decrement a spin button's value in a specified direction by a
    specified amount.
  @end{short}
  @see-class{gtk:spin-button}
  @see-symbol{gtk:spin-type}"
  (spinbutton (g:object spin-button))
  (direction spin-type)
  (increment :double))

(export 'spin-button-spin)

;;; ----------------------------------------------------------------------------
;;; gtk_spin_button_update ()
;;; ----------------------------------------------------------------------------

(cffi:defcfun ("gtk_spin_button_update" spin-button-update) :void
 #+liber-documentation
 "@version{#2023-3-12}
  @argument[spinbutton]{a @class{gtk:spin-button} widget}
  @begin{short}
    Manually force an update of the spin button.
  @end{short}
  @see-class{gtk:spin-button}"
  (spinbutton (g:object spin-button)))

(export 'spin-button-update)

;;; --- End of file gtk3.spin-button.lisp --------------------------------------
