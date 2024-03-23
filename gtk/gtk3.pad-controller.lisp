;;; ----------------------------------------------------------------------------
;;; gtk3.pad-controller.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk3/>.
;;;
;;; Copyright (C) 2019 - 2024 Dieter Kaiser
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
;;; GtkPadController
;;;
;;;     Controller for drawing tablet pads
;;;
;;; Types and Values
;;;
;;;     GtkPadController
;;;     GtkPadActionType
;;;     GtkPadActionEntry
;;;
;;; Functions
;;;
;;;     gtk_pad_controller_new
;;;     gtk_pad_controller_set_action_entries
;;;     gtk_pad_controller_set_action
;;;
;;; Properties
;;;
;;;     action-group
;;;     pad
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GtkEventController
;;;         ╰── GtkPadController
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkPadActionType
;;; ----------------------------------------------------------------------------

(gobject:define-g-enum "GtkPadActionType" pad-action-type
  (:export t
   :type-initializer "gtk_pad_action_type_get_type")
  :button
  :ring
  :strip)

#+liber-documentation
(setf (liber:alias-for-symbol 'pad-action-type)
      "GEnum"
      (liber:symbol-documentation 'pad-action-type)
 "@version{2024-3-22}
  @begin{declaration}
    @begin{pre}
(gobject:define-g-enum \"GtkPadActionType\" pad-action-type
  (:export t
   :type-initializer \"gtk_pad_action_type_get_type\")
  :button
  :ring
  :strip)
    @end{pre}
  @end{declaration}
  @begin{values}
    @begin[code]{table}
      @entry[:button]{Action is triggered by a pad button.}
      @entry[:ring]{Action is triggered by a pad ring.}
      @entry[:strip]{Action is triggered by a pad strip.}
    @end{table}
  @end{values}
  @begin{short}
    The type of a pad action.
  @end{short}
  @see-class{gtk:pad-controller}")

;;; ----------------------------------------------------------------------------
;;; struct GtkPadActionEntry                               not exported
;;; ----------------------------------------------------------------------------

;; We pass the entries as Lisp lists. This structure is not needed.

(cffi:defcstruct pad-action-entry
  (type pad-action-type)
  (index :int)
  (mode :int)
  (label :string)
  (action-name :string))

#+liber-documentation
(setf (liber:alias-for-symbol 'pad-action-entry)
      "CStruct"
      (liber:symbol-documentation 'pad-action-entry)
 "@version{2023-3-11}
  @begin{short}
    Structure defining a pad action entry.
  @end{short}
  @begin{pre}
(cffi:defcstruct pad-action-entry
  (type pad-action-type)
  (index :int)
  (mode :int)
  (label :string)
  (action-name :string))
  @end{pre}
  @begin[code]{table}
    @entry[type]{The type of pad feature that will trigger this action entry.}
    @entry[index]{The 0-indexed button/ring/strip number that will trigger this
      action entry.}
    @entry[mode]{The mode that will trigger this action entry, or -1 for all
      modes.}
    @entry[label]{Human readable description of this action entry, this string
      should be deemed user visible.}
    @entry[action-name]{Action name that will be activated in the
      @class{g:action-group}.}
  @end{table}
  @see-class{gtk:pad-controller}
  @see-class{g:action-group}
  @see-symbol{gtk:pad-action-type}")

;;; ----------------------------------------------------------------------------
;;; struct GtkPadController
;;; ----------------------------------------------------------------------------

(gobject:define-g-object-class "GtkPadController" pad-controller
  (:superclass event-controller
   :export t
   :interfaces nil
   :type-initializer "gtk_pad_controller_get_type")
  ((action-group
    pad-controller-action-group
    "action-group" "GActionGroup" t t)
   (pad
    pad-controller-pad
    "pad" "GdkDevice" t t)))

#+liber-documentation
(setf (documentation 'pad-controller 'type)
 "@version{2023-3-11}
  @begin{short}
    The @class{gtk:pad-controller} object is an event controller for the pads
    found in drawing tablets.
  @end{short}
  Pads are the collection of buttons and tactile sensors often found around the
  stylus-sensitive area.

  These buttons and sensors have no implicit meaning, and by default they
  perform no action, this event controller is provided to map those to
  @class{g:action} objects, thus letting the application give those a more
  semantic meaning.

  Buttons and sensors are not constrained to triggering a single action, some
  @code{:tablet-pad} devices feature multiple \"modes\", all these input
  elements have one current mode, which may determine the final action being
  triggered. Pad devices often divide buttons and sensors into groups, all
  elements in a group share the same current mode, but different groups may
  have different modes. See the @fun{gdk:device-pad-n-groups} and
  @fun{gdk:device-pad-group-n-modes} functions.

  Each of the actions that a given button/strip/ring performs for a given mode
  is defined by the arguments of the @fun{gtk:pad-controller-set-action}
  function, it contains an action name that will be looked up in the given
  @class{g:action-group} object and activated whenever the specified input
  element and mode are triggered.

  A simple example of the @class{gtk:pad-controller} object usage, assigning
  button 1 in all modes and pad devices to an \"invert-selection\" action:
  @begin{pre}
GtkPadActionEntry *pad_actions = {
  { GTK_PAD_ACTION_BUTTON, 1, -1, \"Invert selection\", \"pad-actions.invert-selection\" @},
  ...
@};

...
action_group = g_simple_action_group_new ();
action = g_simple_action_new (\"pad-actions.invert-selection\", NULL);
g_signal_connect (action, \"activate\", on_invert_selection_activated, NULL);
g_action_map_add_action (G_ACTION_MAP (action_group), action);
...
pad_controller = gtk_pad_controller_new (window, action_group, NULL);
  @end{pre}
  The actions belonging to rings/strips will be activated with a
  @var{+g-variant-type-double+} parameter bearing the value of the given axis,
  it is required that those are made stateful and accepting this
  @symbol{g:variant-type} type.
  @see-constructor{gtk:pad-controller-new}
  @see-slot{gtk:pad-controller-action-group}
  @see-slot{gtk:pad-controller-pad}
  @see-class{gtk:event-controller}
  @see-class{gdk:device-pad}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- gtk:pad-controller-action-group ----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "action-group"
                                               'pad-controller) t)
 "The @code{action-group} property of type @class{g:action-group}
  (Read / Write / Construct Only) @br{}
  Action group to launch actions from.")

#+liber-documentation
(setf (liber:alias-for-function 'pad-controller-action-group)
      "Accessor"
      (documentation 'pad-controller-action-group 'function)
 "@version{2023-3-11}
  @syntax{(gtk:pad-controller-action-group object) => group)}
  @syntax{(setf (gtk:pad-controller-action-group object) group)}
  @argument[object]{a @class{gtk:pad-controller} object}
  @argument[group]{a @class{g:action-group} object}
  @begin{short}
    Accessor of the @slot[gtk:pad-controller]{action-group} slot of the
    @class{gtk:pad-controller} class.
  @end{short}
  @see-class{gtk:pad-controller}
  @see-class{g:action-group}")

;;; --- gtk:pad-controller-pad -------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "pad" 'pad-controller) t)
 "The @code{pad} property of type @class{gdk:device}
  (Read / Write / Construct Only) @br{}
  Pad device to control.")

#+liber-documentation
(setf (liber:alias-for-function 'pad-controller-pad)
      "Accessor"
      (documentation 'pad-controller-pad 'function)
 "@version{2023-3-11}
  @syntax{(gtk:pad-controller-pad object) => pad)}
  @syntax{(setf (gtk:pad-controller-pad object) pad)}
  @argument[object]{a @class{gtk:pad-controller} object}
  @argument[pad]{a @class{gdk:device} object}
  @begin{short}
    Accessor of the @slot[gtk:pad-controller]{pad} slot of the
    @class{gtk:pad-controller} class.
  @end{short}
  @see-class{gtk:pad-controller}
  @see-class{gdk:device}")

;;; ----------------------------------------------------------------------------
;;; gtk_pad_controller_new ()
;;; ----------------------------------------------------------------------------

(cffi:defcfun ("gtk_pad_controller_new" pad-controller-new)
    (g:object padd-controller :already-referenced)
 #+liber-documentation
 "@version{2023-3-11}
  @argument[window]{a @class{gtk:window} widget}
  @argument[group]{a @class{g:action-group} object to trigger actions from}
  @argument[pad]{a @class{gdk:device} object of @code{:tablet-pad} type, or
    @code{nil} to handle all pads}
  @return{A newly created @class{gtk:pad-controller} object.}
  @begin{short}
    Creates a new @class{gtk:pad-controller} object that will associate events
    from @arg{pad} to actions.
  @end{short}
  A @code{NULL} pad may be provided so the controller manages all pad devices
  generically, it is discouraged to mix @class{gtk:pad-controller} objects with
  @code{NULL} and non-@code{NULL} pad argument on the same window , as
  execution order is not guaranteed.

  The @class{gtk:pad-controller} object is created with no mapped actions. In
  order to map pad events to actions, use the
  @fun{gtk:pad-controller-set-action-entries} or
  @fun{gtk:pad-controller-set-action} functions.
  @see-class{gtk:pad-controller}
  @see-class{gtk:window}
  @see-class{g:action-group}
  @see-function{gtk:pad-controller-set-action-entries}
  @see-function{gtk:pad-controller-set-action}"
  (window (g:object window))
  (group (g:object g:action-group))
  (pad (g:object gdk:device)))

(export 'pad-controller-new)

;;; ----------------------------------------------------------------------------
;;; gtk_pad_controller_set_action_entries ()
;;; ----------------------------------------------------------------------------

(defun pad-controller-set-action-entries (controller entries)
 #+liber-documentation
 "@version{2023-3-11}
  @argument[controller]{a @class{gtk:pad-controller} object}
  @argument[entries]{a list of the action entries to set on @arg{controller}}
  @begin{short}
    This is a convenience function to add a group of action entries on
    @arg{controller}.
  @end{short}
  See the @fun{gtk:pad-controller-set-action} function.
  @see-class{gtk:pad-controller}
  @see-function{gtk:pad-controller-set-action}"
  (dolist (entry entries)
    (apply #'pad-controller-set-action controller entry)))

(export 'pad-controller-set-action-entries)

;;; ----------------------------------------------------------------------------
;;; gtk_pad_controller_set_action ()
;;; ----------------------------------------------------------------------------

(cffi:defcfun ("gtk_pad_controller_set_action" pad-controller-set-action) :void
 #+liber-documentation
 "@version{2023-3-11}
  @argument[controller]{a @class{gtk:pad-controller} object}
  @argument[type]{a @symbol{gtk:pad-action-type} value with the pad feature
    that will trigger the action}
  @argument[index]{an integer with the 0-indexed button/ring/strip number that
    will trigger the action}
  @argument[mode]{an integer with the mode that will trigger the action, or -1
    for all modes}
  @argument[label]{a string with the Human readable description of the action,
    the string should be deemed user visible}
  @argument[name]{a string with the action name that will be activated in the
    @class{g:action-group} object}
  @begin{short}
    Adds an individual action to @arg{controller}.
  @end{short}
  The action will only be activated if the given button/ring/strip number in
  @arg{index} is interacted while the current mode is @arg{mode}. -1 may be
  used for simple cases, so the action is triggered on all modes.

  The given @arg{label} should be considered user visible, so
  internationalization rules apply. Some windowing systems may be able to use
  those for user feedback.
  @see-class{gtk:pad-controller}
  @see-class{g:action-group}
  @see-symbol{gtk:pad-action-type}"
  (controller (g:object pad-controller))
  (type pad-action-type)
  (index :int)
  (mode :int)
  (label :string)
  (name :string))

(export 'pad-controller-set-action)

;;; --- End of file gtk3.pad-controller.lisp -----------------------------------
