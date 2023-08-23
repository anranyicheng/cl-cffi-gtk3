;;; ----------------------------------------------------------------------------
;;; gdk3.general.lisp
;;;
;;; The documentation of this file is taken from the GDK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GDK library.
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
;;; General
;;;
;;;     Library initialization and miscellaneous functions
;;;
;;; Types and Values
;;;
;;;     GdkGrabStatus                            -> gdk.device.lisp
;;;
;;;     GDK_WINDOWING_X11
;;;     GDK_WINDOWING_WIN32
;;;     GDK_WINDOWING_QUARTZ
;;;     GDK_WINDOWING_WAYLAND
;;;     GDK_VERSION_3_0
;;;     GDK_VERSION_3_2
;;;     GDK_VERSION_3_4
;;;     GDK_VERSION_3_6
;;;     GDK_VERSION_3_8
;;;     GDK_VERSION_3_10
;;;     GDK_VERSION_3_12
;;;     GDK_VERSION_3_14
;;;     GDK_VERSION_MIN_REQUIRED
;;;     GDK_VERSION_MAX_ALLOWED
;;;     GDK_DISABLE_DEPRECATION_WARNINGS
;;;
;;; Functions
;;;
;;;     gdk_init                                   not implemented
;;;     gdk_init_check                             not implemented
;;;     gdk_parse_args                             not implemented
;;;     gdk_get_display_arg_name
;;;     gdk_notify_startup_complete
;;;     gdk_notify_startup_complete_with_id
;;;     gdk_set_allowed_backends
;;;     gdk_get_program_class
;;;     gdk_set_program_class
;;;
;;;     gdk_get_display                            deprecated, not exported
;;;     gdk_flush                                  deprecated, not exported
;;;     gdk_screen_width                           deprecated -> gdk.screen.lisp
;;;     gdk_screen_height                          deprecated -> gdk.screen.lisp
;;;     gdk_screen_width_mm                        deprecated -> gdk.screen.lisp
;;;     gdk_screen_height_mm                       dprecateed -> gdk.screen.lisp
;;;     gdk_pointer_grab                           deprecated, not exported
;;;     gdk_pointer_ungrab                         deprecated, not exported
;;;     gdk_pointer_is_grabbed                     deprecated, not exported
;;;     gdk_set_double_click_time                  deprecated, not exported
;;;     gdk_keyboard_grab                          deprecated, not exported
;;;     gdk_keyboard_ungrab                        deprecated, not exported
;;;     gdk_beep                                   deprecated, not exported
;;;     gdk_error_trap_push                        deprecated, not exported
;;;     gdk_error_trap_pop                         deprecated, not exported
;;;     gdk_error_trap_pop_ignored                 deprecated, not exported
;;; ----------------------------------------------------------------------------

;; TODO: Remove the implementation of all deprecated funtions.

(in-package :gdk)

;;; ----------------------------------------------------------------------------
;;; gdk_init ()
;;;
;;; void gdk_init (gint *argc, gchar ***argv);
;;;
;;; Initializes the GDK library and connects to the windowing system. If
;;; initialization fails, a warning message is output and the application
;;; terminates with a call to exit(1).
;;;
;;; Any arguments used by GDK are removed from the array and argc and argv are
;;; updated accordingly.
;;;
;;; GTK initializes GDK in gtk_init() and so this function is not usually
;;; needed by GTK applications.
;;;
;;; argc :
;;;     the number of command line arguments
;;;
;;; argv :
;;;     the array of command line arguments
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gdk_init_check ()
;;;
;;; gboolean gdk_init_check (gint *argc, gchar ***argv);
;;;
;;; Initializes the GDK library and connects to the windowing system, returning
;;; TRUE on success.
;;;
;;; Any arguments used by GDK are removed from the array and argc and argv are
;;; updated accordingly.
;;;
;;; GTK initializes GDK in gtk_init() and so this function is not usually
;;; needed by GTK applications.
;;;
;;; argc :
;;;     the number of command line arguments
;;;
;;; argv :
;;;     the array of command line arguments
;;;
;;; Returns :
;;;     TRUE if initialization succeeded.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gdk_parse_args ()
;;;
;;; void gdk_parse_args (gint *argc, gchar ***argv);
;;;
;;; Parse command line arguments, and store for future use by calls to
;;; gdk_display_open().
;;;
;;; Any arguments used by GDK are removed from the array and argc and argv are
;;; updated accordingly.
;;;
;;; You shouldn't call this function explicitely if you are using gtk_init(),
;;; gtk_init_check(), gdk_init(), or gdk_init_check().
;;;
;;; argc :
;;;     the number of command line arguments.
;;;
;;; argv :
;;;     the array of command line arguments
;;;
;;; Since 2.2
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gdk_get_display_arg_name ()
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_get_display_arg_name" get-display-arg-name)
    (:string :free-from-foreign nil)
 #+liber-documentation
 "@version{#2023-3-4}
  @return{A string with the display name, if specified explicitely, otherwise
    @code{nil}.}
  @begin{short}
    Gets the display name specified in the command line arguments passed to
    the @code{gdk_init} or @code{gdk_parse_args} functions, if any.
  @end{short}")

(export 'get-display-arg-name)

;;; ----------------------------------------------------------------------------
;;; gdk_notify_startup_complete ()
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_notify_startup_complete" notify-startup-complete) :void
 #+liber-documentation
 "@version{#2023-3-4}
  @begin{short}
    Indicates to the GUI environment that the application has finished loading.
  @end{short}
  If the application open windows, this function is normally called after
  opening the initial set of windows of the application.

  GTK will call this function automatically after opening the first
  @class{gtk:window} widget unless the
  @fun{gtk:window-set-auto-startup-notification} function is called to disable
  that feature.
  @see-class{gtk:window}
  @see-function{gdk:notify-startup-complete-with-id}
  @see-function{gtk:window-set-auto-startup-notification}")

(export 'notify-startup-complete)

;;; ----------------------------------------------------------------------------
;;; gdk_notify_startup_complete_with_id ()
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_notify_startup_complete_with_id" notify-startup-complete-with-id)
    :void
 #+liber-documentation
 "@version{#2023-3-4}
  @argument[startup]{a string with the startup notification identifier}
  @begin{short}
    Indicates to the GUI environment that the application has finished loading,
    using a given startup notification identifier.
  @end{short}

  GTK will call this function automatically for a @class{gtk:window} widget
  with custom startup notification identifier unless the
  @fun{gtk:window-set-auto-startup-notification} function is called to disable
  that feature.
  @see-class{gtk:window}
  @see-function{gdk:notify-startup-complete}
  @see-function{gtk:window-set-auto-startup-notification}"
  (startup :string))

(export 'notify-startup-complete-with-id)

;;; ----------------------------------------------------------------------------
;;; gdk_set_allowed_backends ()
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_set_allowed_backends" set-allowed-backends) :void
 #+liber-documentation
 "@version{#2023-3-4}
  @argument[backends]{a string with a comma-separated list of backends}
  @begin{short}
    Sets a list of backends that GDK should try to use.
  @end{short}
  This can be be useful if your application does not work with certain GDK
  backends. By default, GDK tries all included backends.

  For example,
  @begin{pre}
(gdk:set-allowed-backends \"wayland,quartz,*\)
  @end{pre}
  instructs GDK to try the Wayland backend first, followed by the Quartz
  backend, and then all others.

  If the @code{GDK_BACKEND} environment variable is set, it determines what
  backends are tried in what order, while still respecting the set of allowed
  backends that are specified by this function.

  The possible backend names are x11, win32, quartz, broadway, wayland. You
  can also include a * in the list to try all remaining backends.

  This call must happen prior to the @fun{gdk:display-open}, @code{gtk_init()},
  @code{gtk_init_with_args()} or @code{gtk_init_check()} functions in order to
  take effect.
  @see-function{gdk:display-open}"
  (backends :string))

(export 'set-allowed-backends)

;;; ----------------------------------------------------------------------------
;;; gdk_get_program_class ()
;;; gdk_set_program_class () -> program-class
;;; ----------------------------------------------------------------------------

(defun (setf program-class) (program-class)
  (cffi:foreign-funcall "gdk_set_program_class"
                        :string program-class
                        :void)
  program-class)

(defcfun ("gdk_get_program_class" program-class)
    (:string :free-from-foreign nil)
 #+liber-documentation
 "@version{#2021-12-13}
  @syntax[]{(gdk:program-class) => program-class}
  @syntax[]{(setf (gdk:program-class) program-class)}
  @argument[program-class]{a string with the program class}
  @begin{short}
    Accessor of the program class.
  @end{short}

  The @sym{gdk:program-class} function gets the program class. The
  @sym{(setf gdk:program-class)} function sets the program class.

  Unless the program class has explicitly been set with the
  @sym{(setf gdk:program-class)} function or with the @code{--class} command
  line option, the default value is the program name determined with the
  @fun{g:prgname} function and with the first character converted to uppercase.

  The X11 backend uses the program class to set the class name part of the
  @code{WM_CLASS} property on toplevel windows. See the Inter-Client
  Communication Conventions Manual (ICCCM).
  @see-function{g:prgname}")

(export 'program-class)

;;; ----------------------------------------------------------------------------
;;; gdk_get_display ()                                     not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_get_display" get-display) (:string :free-from-foreign nil)
 #+liber-documentation
 "@version{#2015-12-30}
  @return{The name of the display of type @code{:string}.}
  @begin{short}
    Gets the name of the display, which usually comes from the @code{DISPLAY}
    environment variable or the @code{--display} command line option.
  @end{short}
  @begin[Warning]{dictionary}
    The @sym{gdk:get-display} function has been deprecated since version 3.8
    and should not be used in newly written code. Call
    @code{(gdk:display-name (gdk:display-default))} instead.
  @end{dictionary}
  @see-function{gdk:display-name}
  @see-function{gdk:display-default}")

;;; ----------------------------------------------------------------------------
;;; gdk_flush ()                                           not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_flush" flush) :void
 #+liber-documentation
 "@version{#2019-3-25}
  @begin{short}
    Flushes the output buffers of all display connections and waits until all
    requests have been processed.
  @end{short}
  This is rarely needed by applications.
  @begin[Warning]{dictionary}
    The @sym{gdk:flush} function is deprecated and should not be used in
    newly written code.
  @end{dictionary}")

;;; ----------------------------------------------------------------------------
;;; gdk_screen_width ()
;;; ----------------------------------------------------------------------------

;; Implemented in gdk.screen.lisp

;;; ----------------------------------------------------------------------------
;;; gdk_screen_height ()
;;; ----------------------------------------------------------------------------

;; Implemented in gdk.screen.lisp

;;; ----------------------------------------------------------------------------
;;; gdk_screen_width_mm ()
;;; ----------------------------------------------------------------------------

;; Implemented in gdk.screen.lisp

;;; ----------------------------------------------------------------------------
;;; gdk_screen_height_mm ()
;;; ----------------------------------------------------------------------------

;; Implemented in gdk.screen.lisp

;;; ----------------------------------------------------------------------------
;;; gdk_pointer_grab ()                                    not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_pointer_grab" pointer-grab) grab-status
 #+liber-documentation
 "@version{#2013-4-3}
  @argument[window]{the @class{gdk:window} which will own the grab}
  @argument[owner-events]{if @code{nil} then all pointer events are reported
    with respect to @arg{window} and are only reported if selected by
    @arg{event-mask}. If @em{true} then pointer events for this application are
    reported as normal, but pointer events outside this application are
    reported with respect to @arg{window} and only if selected by
    @arg{event-mask}. In either mode, unreported events are discarded.}
  @argument[event-mask]{specifies the event mask of type
    @symbol{gdk:event-mask}, which is used in accordance with
    @arg{owner-events}. Note that only pointer events (i.e. button and motion
    events) may be selected.}
  @argument[confine-to]{a @class{gdk:window} object, if non-@code{nil}, the
    pointer will be confined to this window during the grab. If the pointer is
    outside @arg{confine-to}, it will automatically be moved to the closest
    edge of @arg{confine-to} and enter and leave events will be generated as
    necessary.}
  @argument[cursor]{the @class{gdk:cursor} object to display while the grab is
    active. If this is @code{nil} then the normal cursors are used for
    @arg{window} and its descendants, and the cursor for @arg{window} is used
    for all other windows.}
  @argument[time]{the timestamp of type @code{:uint32} of the event which led
    to this pointer grab. This usually comes from a @class{gdk:event-button}
    struct, though @var{+gdk:current-time+} can be used if the time isn't
    known.}
  @return{The value @code{:success} of the @symbol{gdk:grab-status} enumeration
    if the grab was successful.}
  @begin{short}
    Grabs the pointer (usually a mouse) so that all events are passed to this
    application until the pointer is ungrabbed with the function
    @fun{gdk:pointer-ungrab}, or the grab window becomes unviewable.
  @end{short}
  This overrides any previous pointer grab by this client.

  Pointer grabs are used for operations which need complete control over mouse
  events, even if the mouse leaves the application. For example in GTK it is
  used for drag and drop, for dragging the handle in the @class{gtk-paned}
  widgets.

  Note that if the event mask of an X window has selected both button press
  and button release events, then a button press event will cause an automatic
  pointer grab until the button is released. X does this automatically since
  most applications expect to receive button press and release events in
  pairs. It is equivalent to a pointer grab on the window with
  @arg{owner-events} set to @em{true}.

  If you set up anything at the time you take the grab that needs to be
  cleaned up when the grab ends, you should handle the
  @class{gdk:event-grab-broken} events that are emitted when the grab ends
  unvoluntarily.
  @begin[Warning]{dictionary}
    The @sym{gdk:pointer-grab} function has been deprecated since version 3.0
    and should not be used in newly written code. Use the @fun{gdk:seat-grab}
    function instead.
  @end{dictionary}
  @see-symbol{gdk:grab-status}
  @see-class{gdk:event-grab-broken}
  @see-function{gdk:seat-grab}"
  (window (g:object window))
  (owner-events :boolean)
  (event-mask event-mask)
  (confine-to (g:object window))
  (cursor (g:object cursor))
  (time :uint32))

;;; ----------------------------------------------------------------------------
;;; gdk_pointer_ungrab ()                                  not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_pointer_ungrab" pointer-ungrab) :void
 #+liber-documentation
 "@version{#2013-4-3}
  @argument[time]{a timestamp of type @code{:uint32} from a @class{gdk:event},
    or @var{+gdk-current-time+} if no timestamp is available}
  @begin{short}
    Ungrabs the pointer on the default display, if it is grabbed by this
    application.
  @end{short}
  @begin[Warning]{dictionary}
    The function @sym{gdk:pointer-ungrab} has been deprecated since version 3.0
    and should not be used in newly written code. Use the function
    @fun{gdk:seat-ungrab}, together with the function @fun{gdk:seat-grab}
    instead.
  @end{dictionary}
  @see-function{gdk:seat-grab}
  @see-function{gdk:seat-ungrab}"
  (time :uint32))

;;; ----------------------------------------------------------------------------
;;; gdk_pointer_is_grabbed ()                              not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_pointer_is_grabbed" pointer-is-grabbed) :boolean
 #+liber-documentation
 "@version{#2013-4-3}
  @return{a boolean that is @em{true} if the pointer is currently grabbed by
    this application.}
  @begin{short}
    Returns @em{true} if the pointer on the default display is currently
    grabbed by this application.
  @end{short}

  Note that this does not take the inmplicit pointer grab on button presses
  into account.
  @begin[Warning]{dictionary}
    The function @sym{gdk:pointer-is-grabbed} has been deprecated since version
    3.0 and should not be used in newly written code. Use the function
    @fun{gdk:display-device-is-grabbed} instead.
  @end{dictionary}
  @see-function{gdk:display-device-is-grabbed}")

;;; ----------------------------------------------------------------------------
;;; gdk_set_double_click_time ()                           not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_set_double_click_time" set-double-click-time) :void
 #+liber-documentation
 "@version{#2019-3-26}
  @argument[msec]{double click time in milliseconds of type @code{:uint}}
  @begin{short}
    Set the double click time for the default display.
  @end{short}
  See the function @fun{gdk:display-set-double-click-time}. See also the
  function @fun{gdk:display-set-double-click-distance}. Applications should not
  set this, it is a global user-configured setting.
  @begin[Warning]{dictionary}
    The @sym{gdk:set-double-click-time} function is deprecated and should not
    be used in newly written code.
  @end{dictionary}
  @see-function{gdk:display-set-double-click-time}
  @see-function{gdk:display-set-double-click-distance}"
  (msec :uint))

;;; ----------------------------------------------------------------------------
;;; gdk_keyboard_grab ()                                   not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_keyboard_grab" keyboard-grab) grab-status
 #+liber-documentation
 "@version{#2013-4-3}
  @argument[window]{the @class{gdk:window} which will own the grab}
  @argument[owner-events]{a boolean, if @code{nil} then all keyboard events are
    reported with respect to @arg{window}. If @em{true} then keyboard events
    for this application are reported as normal, but keyboard events outside
    this application are reported with respect to @arg{window}. Both key press
    and key release events are always reported, independant of the event mask
    set by the application.}
  @argument[time]{a timestamp of type @code{:uint32} from a @class{gdk:event},
    or @var{+gdk-current-time+} if no timestamp is available.}
  @return{The value @code{:success} of the @symbol{gdk:grab-status} enumeration
   if the grab was successful.}
  @begin{short}
    Grabs the keyboard so that all events are passed to this application until
    the keyboard is ungrabbed with the function @fun{gdk:keyboard-ungrab}.
  @end{short}
  This overrides any previous keyboard grab by this client.

  If you set up anything at the time you take the grab that needs to be
  cleaned up when the grab ends, you should handle the
  @class{gdk:event-grab-broken} events that are emitted when the grab ends
  unvoluntarily.
  @begin[Warning]{dictionary}
    The @sym{gdk:keyboard-grab} function has been deprecated since version 3.0
    and should not be used in newly written code. Use the @fun{gdk:seat-grab}
    function instead.
  @end{dictionary}
  @see-function{gdk:seat-grab}"
  (window (g:object window))
  (owner-events :boolean)
  (time :uint32))

;;; ----------------------------------------------------------------------------
;;; gdk_keyboard_ungrab ()                                 not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_keyboard_ungrab" keyboard-ungrab) :void
 #+liber-documentation
 "@version{#2013-4-3}
  @argument[time]{a timestamp of type @code{:uint32} from a @class{gdk:event},
    or @var{+gdk-current-time+} if no timestamp is available}
  @begin{short}
    Ungrabs the keyboard on the default display, if it is grabbed by this
    application.
  @end{short}
  @begin[Warning]{dictionary}
    The function @sym{gdk:keyboard-ungrab} has been deprecated since version
    3.0 and should not be used in newly written code. Use the function
    @fun{gdk:seat-ungrab}, together with the function @fun{gdk:seat-grab}
    instead.
  @end{dictionary}
  @see-function{gdk:seat-grab}
  @see-function{gdk:seat-ungrab}"
  (time :uint32))

;;; ----------------------------------------------------------------------------
;;; gdk_beep ()                                            not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_beep" beep) :void
 #+liber-documentation
 "@version{#2019-3-25}
  @short{Emits a short beep on the default display.}
  @begin[Warning]{dictionary}
    The @sym{gdk:beep} function is deprecated and should not be used in newly
    written code.
  @end{dictionary}")

;;; ----------------------------------------------------------------------------
;;; gdk_error_trap_push ()                                 not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_error_trap_push" error-trap-push) :void
 #+liber-documentation
 "@version{#2013-7-30}
  @begin{short}
    This function allows X errors to be trapped instead of the normal behavior
    of exiting the application.
  @end{short}
  It should only be used if it is not possible to avoid the X error in any
  other way. Errors are ignored on all @class{gdk:display} currently known to
  the @class{gdk:display-manager}. If you do not care which error happens and
  just want to ignore everything, pop with the function
  @fun{gdk:error-trap-pop-ignored}. If you need the error code, use the
  function @fun{gdk:error-trap-pop} which may have to block and wait for the
  error to arrive from the X server.

  This API exists on all platforms but only does anything on X.

  You can use the function @code{gdk:x11-display-error-trap-push} to ignore
  errors on only a single display.
  @begin[Example]{dictionary}
    Trapping an X error
    @begin{pre}
   gdk_error_trap_push ();

    // ... Call the X function which may cause an error here ...


   if (gdk_error_trap_pop ())
    {
      // ... Handle the error here ...
    @}
    @end{pre}
  @end{dictionary}
  @begin[Warning]{dictionary}
    The @sym{gdk:error-trap-push} function is deprecated and should not be used
    in newly written code.
  @end{dictionary}
  @see-class{gdk:display}
  @see-class{gdk:display-manager}")

;;; ----------------------------------------------------------------------------
;;; gdk_error_trap_pop ()                                  not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_error_trap_pop" error-trap-pop) :int
 #+liber-documentation
 "@version{#2013-7-30}
  @return{X error code of type @code{:int} or 0 on success.}
  @begin{short}
    Removes an error trap pushed with the function @fun{gdk:error-trap-push}.
  @end{short}
  May block until an error has been definitively received or not received from
  the X server. The function @fun{gdk:error-trap-pop-ignored} is preferred if
  you do not need to know whether an error occurred, because it never has to
  block. If you do not need the return value of the functon
  @sym{gdk:error-trap-pop}, use the function @fun{gdk:error-trap-pop-ignored}.

  Prior to GDK 3.0, this function would not automatically sync for you, so you
  had to call the function @fun{gdk:flush} if your last call to Xlib was not a
  blocking round trip.
  @begin[Warning]{dictionary}
    The @sym{gdk:error-trap-pop} function is deprecated and should not be used
    in newly written code.
  @end{dictionary}
  @see-function{gdk:error-trap-push}
  @see-function{gdk:error-trap-pop-ignored}
  @see-function{gdk:flush}")

;;; ----------------------------------------------------------------------------
;;; gdk_error_trap_pop_ignored ()                          not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_error_trap_pop_ignored" error-trap-pop-ignored) :void
 #+liber-documentation
 "@version{#2013-7-30}
  @begin{short}
    Removes an error trap pushed with the function @fun{gdk:error-trap-push},
    but without bothering to wait and see whether an error occurred.
  @end{short}
  If an error arrives later asynchronously that was triggered while the trap
  was pushed, that error will be ignored.

  Since 3.0
  @begin[Warning]{dictionary}
    The @sym{gdk:error-trap-pop-ignored} function is deprecated and should not
    be used in newly written code.
  @end{dictionary}
  @see-function{gdk:error-trap-push}")

;;; --- End of file gdk3.general.lisp ------------------------------------------
