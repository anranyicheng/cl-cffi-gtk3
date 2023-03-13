;;; ----------------------------------------------------------------------------
;;; gtk3.event-controller-key.lisp
;;;
;;; The documentation of this file is taken from the GTK Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2019 - 2023 Dieter Kaiser
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
;;; GtkEventControllerKey
;;;
;;;     Event controller for key events
;;;
;;; Types and Values
;;;
;;;     GtkEventControllerKey
;;;
;;; Functions
;;;
;;;     gtk_event_controller_key_new
;;;
;;; Signals
;;;
;;;     focus-in
;;;     focus-out
;;;     im-update
;;;     key-pressed
;;;     key-released
;;;     modifiers
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GtkEventController
;;;         ╰── GtkEventControllerKey
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkEventControllerKey
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkEventControllerKey" event-controller-key
  (:superclass event-controller
   :export t
   :interfaces nil
   :type-initializer "gtk_event_controller_key_get_type")
  nil)

#+liber-documentation
(setf (documentation 'event-controller-key 'type)
 "@version{#2023-3-1}
  @begin{short}
    The @sym{gtk:event-controller-key} object is an event controller meant for
    situations where you need access to key events.
  @end{short}

  This object was added in GTK 3.24.
  @begin[Signal Details]{dictionary}
    @subheading{The \"focus-in\" signal}
      @begin{pre}
lambda (controller)    :run-last
      @end{pre}
      @begin[code]{table}
        @entry[controller]{The @sym{gtk:event-controller-key} object on which
          the signal is emitted.}
      @end{table}
    @subheading{The \"focus-out\" signal}
      @begin{pre}
lambda (controller)    :run-last
      @end{pre}
      @begin[code]{table}
        @entry[controller]{The @sym{gtk:event-controller-key} object on
          which the signal is emitted.}
      @end{table}
    @subheading{The \"im-update\" signal}
      @begin{pre}
lambda (controller)    :run-last
      @end{pre}
      @begin[code]{table}
        @entry[controller]{The @sym{gtk:event-controller-key} object on
          which the signal is emitted.}
      @end{table}
    @subheading{The \"key-pressed\" signal}
      @begin{pre}
lambda (controller keyval keycode state)    :run-last
      @end{pre}
      The signal is emitted whenever a key is pressed.
      @begin[code]{table}
        @entry[controller]{The @sym{gtk:event-controller-key} object on
          which received the signal.}
        @entry[keyval]{An unsigned integer with the pressed key.}
        @entry[keycode]{An unsigned integer with the raw code of the pressed
          key.}
        @entry[state]{The @symbol{gdk:modifier-type} bitmask representing the
          state of modifier keys and pointer buttons.}
        @entry[Returns]{@em{True} if the key press was handled, @em{false}
          otherwise.}
      @end{table}
    @subheading{The \"key-released\" signal}
      @begin{pre}
lambda (controller keyval keycode state)    :run-last
      @end{pre}
      The signal is emitted whenever a key is released.
      @begin[code]{table}
        @entry[controller]{The @sym{gtk:event-controller-key} object on
          which received the signal.}
        @entry[keyval]{An unsigned integer with the released key.}
        @entry[keycode]{An unsigned integer with the raw code of the released
          key.}
        @entry[state]{The @symbol{gdk:modifier-type} bitmask representing the
          state of modifier keys and pointer buttons.}
      @end{table}
    @subheading{The \"modifiers\" signal}
      @begin{pre}
lambda (controller state)    :run-last
      @end{pre}
      @begin[code]{table}
        @entry[controller]{The @sym{gtk:event-controller-key} object on
          which received the signal.}
        @entry[state]{The @symbol{gdk:modifier-type} bitmask, representing the
          state of modifier keys and pointer buttons.}
        @entry[Returns]{a not documented boolean}
      @end{table}
  @end{dictionary}
  @see-constructor{gtk:event-controller-key-new}
  @see-class{gtk:event-controller}")

;;; ----------------------------------------------------------------------------
;;; gtk_event_controller_key_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline event-controller-key-new))

(defun event-controller-key-new ()
 #+liber-documentation
 "@version{#2023-3-1}
  @return{The new @class{gtk:event-controller-key} object.}
  @short{Creates a new event controller.}
  @see-class{gtk:event-controller-key}"
  (make-instance 'event-controller-key))

(export 'event-controller-key-new)

;;; --- End of File gtk3.event-controller-key.lisp -----------------------------
