;;; ----------------------------------------------------------------------------
;;; gtk.switch.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
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
;;; GtkSwitch
;;;
;;;     A "light switch" style toggle
;;;
;;; Types and Values
;;;
;;;     GtkSwitch
;;;
;;; Functions
;;;
;;;     gtk_switch_new
;;;     gtk_switch_set_active
;;;     gtk_switch_get_active
;;;     gtk_switch_set_state
;;;     gtk_switch_get_state
;;;
;;; Properties
;;;
;;;     gboolean    active           Read / Write
;;;     gboolean    state            Read / Write
;;;
;;; Style Properties
;;;
;;;         gint    slider-height    Read
;;;         gint    slider-width     Read
;;;
;;; Signals
;;;
;;;         void    activate         Action
;;;     gboolean    state-set        Run Last
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkSwitch
;;;
;;; Implemented Interfaces
;;;
;;;     GtkSwitch implements AtkImplementorIface, GtkBuildable, GtkActionable
;;;     and GtkActivatable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkSwitch
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkSwitch" switch
  (:superclass widget
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkActionable"
                "GtkActivatable")
   :type-initializer "gtk_switch_get_type")
  ((active
    switch-active
    "active" "gboolean" t t)
   (state
    switch-state
    "state" "gboolean" t t)))

#+liber-documentation
(setf (documentation 'switch 'type)
 "@version{#2021-12-23}
  @begin{short}
    The @sym{gtk:switch} widget is a widget that has two states: on or off.
  @end{short}

  @image[switch]{}

  The user can control which state should be active by clicking the switch,
  or by dragging the handle.
  @begin[CSS nodes]{dictionary}
    @begin{pre}
 switch
 ╰── slider
    @end{pre}
    The @sym{gtk:switch} implementation has two CSS nodes, the main node with
    the name @code{switch} and a subnode named @code{slider}. Neither of them
    is using any style classes.
  @end{dictionary}
  @begin[Style Property Details]{dictionary}
    @begin[code]{table}
      @begin[slider-height]{entry}
        The @code{slider-height} style property of type @code{:int} (Read) @br{}
        The minimum height of the switch handle, in pixels. @br{}
        @em{Warning:} The @code{slider-height} style property has been
        deprecated since version 3.20 and should not be used in newly written
        code. Use the CSS @code{min-height} property instead. @br{}
        Allowed values: >= 22 @br{}
        Default value: 22
      @end{entry}
      @begin[slider-width]{entry}
        The @code{slider-width} style property of type @code{:int} (Read) @br{}
        The minimum width of the switch handle, in pixels. @br{}
        @em{Warning:} The @code{slider-width} style property has been deprecated
        since version 3.20 and should not be used in newly written code. Use the
        CSS @code{min-height} property instead. @br{}
        Allowed values: >= 36 @br{}
        Default value: 36
      @end{entry}
    @end{table}
  @end{dictionary}
  @begin[Signal Details]{dictionary}
    @subheading{The \"activate\" signal}
      @begin{pre}
 lambda (widget)    :action
      @end{pre}
      The signal on the switch is an action signal and emitting it causes the
      switch to animate. Applications should never connect to this signal, but
      use the \"notify::active\" signal.
      @begin[code]{table}
        @entry[widget]{The @class{gtk:switch} widget which received the signal.}
      @end{table}
    @subheading{The \"state-set\" signal}
      @begin{pre}
 lambda (widget state)    :run-last
      @end{pre}
      The signal on the switch is emitted to change the underlying state. It is
      emitted when the user changes the switch position. The default handler
      keeps the state in sync with the @code{active} property.

      To implement delayed state change, applications can connect to this
      signal, initiate the change of the underlying state, and call the
      @fun{gtk:switch-state} function when the underlying state change is
      complete. The signal handler should return @em{true} to prevent the
      default handler from running.

      Visually, the underlying state is represented by the trough color of the
      switch, while the @code{active} property is represented by the position
      of the switch.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:switch} widget which received the signal.}
        @entry[state]{A boolean with the state of the switch.}
        @entry[Returns]{@em{True} to stop the signal emission.}
      @end{table}
  @end{dictionary}
  @see-slot{gtk:switch-active}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- switch-active ------------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "active" 'switch) t)
 "The @code{active} property of type @code{:boolean} (Read / Write) @br{}
  Whether the switch is in its on or off state. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'switch-active)
      "Accessor"
      (documentation 'switch-active 'function)
 "@version{#2021-12-23}
  @syntax[]{(gtk:switch-active object) => is-active)}
  @syntax[]{(setf (gtk:switch-active object) is-active)}
  @argument[object]{a @class{gtk:switch} widget}
  @argument[is-active]{@em{true} if the switch should be active,
    and @em{false} otherwise}
  @begin{short}
    Accessor of the @slot[gtk:switch]{active} slot of the @class{gtk:switch}
    class.
  @end{short}

  The @sym{gtk:switch-active} slot access function gets whether the switch is
  in its \"on\" or \"off\" state. The @sym{(setf gtk:switch-active)} slot
  access function changes the state of the switch to the desired one.
  @see-class{gtk:switch}")

;;; --- switch-state -------------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "state" 'switch) t)
 "The @code{state} property of type @code{:boolean} (Read / Write) @br{}
  The backend state that is controlled by the switch. See the \"state-set\"
  signal for details. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'switch-state)
      "Accessor"
      (documentation 'switch-state 'function)
 "@version{#2021-12-23}
  @syntax[]{(gtk:switch-state object) => state)}
  @syntax[]{(setf (gtk:switch-state object) state)}
  @argument[object]{a @class{gtk:switch} widget}
  @argument[state]{a boolean with the state}
  @begin{short}
    Accessor of the @slot[gtk:switch]{state} slot of the @class{gtk:switch}
    class.
  @end{short}

  The @sym{gtk:switch-active} slot access function gets the underlying state of
  the switch. The @sym{(setf gtk:switch-active)} slot access function sets the
  underlying state of the switch.

  Normally, this is the same as the @slot[gtk:switch]{active} property, unless
  the switch is set up for delayed state changes. This function is typically
  called from a \"state-set\" signal handler. See the \"state-set\" signal for
  details.
  @see-class{gtk:switch}
  @see-function{gtk:switch-active}")

;;; ----------------------------------------------------------------------------
;;; gtk_switch_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline switch-new))

(defun switch-new ()
 #+liber-documentation
 "@version{#2021-12-23}
  @return{The newly created @class{gtk:switch} widget.}
  @short{Creates a new switch.}
  @see-class{gtk:switch}"
  (make-instance 'switch))

(export 'switch-new)

;;; --- End of file gtk.switch.lisp --------------------------------------------
