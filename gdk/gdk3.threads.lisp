;;; ----------------------------------------------------------------------------
;;; gdk3.threads.lisp
;;;
;;; The documentation of this file is taken from the GDK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GDK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk3/>.
;;;
;;; Copyright (C) 2011 - 2021 Dieter Kaiser
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
;;; Threads
;;;
;;;     Functions for using GDK in multi-threaded programs
;;;
;;; Functions
;;;
;;;     GDK_THREADS_ENTER
;;;     GDK_THREADS_LEAVE
;;;
;;;     gdk_threads_init
;;;     gdk_threads_enter
;;;     gdk_threads_leave
;;;     gdk_threads_set_lock_functions
;;;     gdk_threads_add_idle
;;;     gdk_threads_add_idle_full                          not exported
;;;     gdk_threads_add_timeout
;;;     gdk_threads_add_timeout_full
;;;     gdk_threads_add_timeout_seconds
;;;     gdk_threads_add_timeout_seconds_full               not exported
;;;
;;; Description
;;;
;;; For thread safety, GDK relies on the thread primitives in GLib, and on the
;;; thread-safe GLib main loop.
;;;
;;; GLib is completely thread safe (all global data is automatically locked),
;;; but individual data structure instances are not automatically locked for
;;; performance reasons. So e.g. you must coordinate accesses to the same
;;; GHashTable from multiple threads.
;;;
;;; GLib is completely thread safe (all global data is automatically locked),
;;; but individual data structure instances are not automatically locked for
;;; performance reasons. So e.g. you must coordinate accesses to the same
;;; GHashTable from multiple threads.
;;;
;;; GTK, however, is not thread safe. You should only use GTK and GDK from
;;; the thread gtk_init() and gtk_main() were called on. This is usually
;;; referred to as the "main thread".
;;;
;;; Signals on GTK and GDK types, as well as non-signal callbacks, are emitted
;;; in the main thread.
;;;
;;; You can schedule work in the main thread safely from other threads by using
;;; gdk_threads_add_idle() and gdk_threads_add_timeout():
;;;
;;; static void
;;; worker_thread (void)
;;; {
;;;   ExpensiveData *expensive_data = do_expensive_computation ();
;;;
;;;   gdk_threads_add_idle (got_value, expensive_data);
;;; }
;;;
;;; static gboolean
;;; got_value (gpointer user_data)
;;; {
;;;   ExpensiveData *expensive_data = user_data;
;;;
;;;   my_app->expensive_data = expensive_data;
;;;   gtk_button_set_sensitive (my_app->button, TRUE);
;;;   gtk_button_set_label (my_app->button, expensive_data->result_label);
;;;
;;;   return G_SOURCE_REMOVE;
;;; }
;;;
;;; You should use gdk_threads_add_idle() and gdk_threads_add_timeout() instead
;;; of g_idle_add() and g_timeout_add() since libraries not under your control
;;; might be using the deprecated GDK locking mechanism. If you are sure that
;;; none of the code in your application and libraries use the deprecated
;;; gdk_threads_enter() or gdk_threads_leave() methods, then you can safely use
;;; g_idle_add() and g_timeout_add().
;;;
;;; For more information on this "worker thread" pattern, you should also look
;;; at GTask, which gives you high-level tools to perform expensive tasks from
;;; worker threads, and will handle thread management for you.
;;; ----------------------------------------------------------------------------

(in-package :gdk)

;;; ----------------------------------------------------------------------------

;;; A marco to execute code between gdk-threads-enter and gdk-threads-leave

(defmacro with-gdk-threads-lock (&body body)
 #+liber-documentation
 "@version{#2021-12-13}
  A Lisp macro to execute @arg{body} between the @fun{gdk-threads-enter} and
  @fun{gdk-threads-leave} functions."
  `(progn
     (gdk-threads-enter)
     (unwind-protect
       (progn ,@body)
       (gdk-threads-leave))))

(export 'with-gdk-threads-lock)

;;; ----------------------------------------------------------------------------

;; Callback function for:
;;
;;     gdk-threads-add-idle-full
;;     gdk-threads-add-timeout-full
;;     gdk-threads-add-timeout-seconds-full

;(defcallback source-func-cb :boolean
;    ((data :pointer))
;  (funcall (glib:get-stable-pointer-value data)))

;;; ----------------------------------------------------------------------------
;;; GDK_THREADS_ENTER
;;;
;;; #define GDK_THREADS_ENTER() gdk_threads_enter()
;;;
;;; GDK_THREADS_ENTER has been deprecated since version 3.6 and should not be
;;; used in newly written code. Use g_main_context_invoke(), g_idle_add() and
;;; related functions if you need to schedule GTK calls from other threads.
;;;
;;; This macro marks the beginning of a critical section in which GDK and GTK
;;; functions can be called safely and without causing race conditions. Only one
;;; thread at a time can be in such a critial section. The macro expands to a
;;; no-op if G_THREADS_ENABLED has not been defined. Typically
;;; gdk_threads_enter() should be used instead of this macro.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; GDK_THREADS_LEAVE
;;;
;;; #define GDK_THREADS_LEAVE() gdk_threads_leave()
;;;
;;; GDK_THREADS_LEAVE has been deprecated since version 3.6 and should not be
;;; used in newly written code. Deprecated in 3.6.
;;;
;;; This macro marks the end of a critical section begun with GDK_THREADS_ENTER.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gdk_threads_init ()                                    not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_threads_init" gdk-threads-init) :void
 #+liber-documentation
 "@version{#2013-6-17}
  @begin{short}
    Initializes GDK so that it can be used from multiple threads in conjunction
    with the functions @fun{gdk-threads-enter} and @fun{gdk-threads-leave}.
  @end{short}

  This call must be made before any use of the main loop from GTK; to be
  safe, call it before the function @code{gtk_init()}.
  @begin[Warning]{dictionary}
    The @sym{gdk-threads-init} function has been deprecated since version 3.6
    and should not be used in newly written code. All GDK and GTK calls should
    be made from the main thread.
  @end{dictionary}
  @see-function{gdk-threads-enter}
  @see-function{gdk-threads-leave}")

;;; ----------------------------------------------------------------------------
;;; gdk_threads_enter ()                                   not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_threads_enter" gdk-threads-enter) :void
 #+liber-documentation
 "@version{#2013-6-17}
  @begin{short}
    This function marks the beginning of a critical section in which GDK and
    GTK functions can be called safely and without causing race conditions.
    Only one thread at a time can be in such a critial section.
  @end{short}
  @begin[Warning]{dictionary}
    The @sym{gdk-threads-enter} function has been deprecated since version 3.6
    and should not be used in newly written code. All GDK and GTK calls should
    be made from the main thread.
  @end{dictionary}")

;;; ----------------------------------------------------------------------------
;;; gdk_threads_leave ()                                   not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_threads_leave" gdk-threads-leave) :void
 #+liber-documentation
 "@version{#2013-6-17}
  @begin{short}
    Leaves a critical region begun with the function @fun{gdk-threads-enter}.
  @end{short}
  @begin[Warning]{dictionary}
    The @sym{gdk-threads-leave} function has been deprecated since version 3.6
    and should not be used in newly written code. All GDK and GTK calls should
    be made from the main thread.
  @end{dictionary}
  @see-function{gdk-threads-enter}")

;;; ----------------------------------------------------------------------------
;;; gdk_threads_set_lock_functions ()
;;;
;;; void gdk_threads_set_lock_functions (GCallback enter_fn, GCallback leave_fn)
;;;
;;; Warning
;;;
;;; gdk_threads_set_lock_functions has been deprecated since version 3.6 and
;;; should not be used in newly written code. All GDK and GTK calls should be
;;; made from the main thread
;;;
;;; Allows the application to replace the standard method that GDK uses to
;;; protect its data structures. Normally, GDK creates a single GMutex that is
;;; locked by gdk_threads_enter(), and released by gdk_threads_leave(); using
;;; this function an application provides, instead, a function enter_fn that is
;;; called by gdk_threads_enter() and a function leave_fn that is called by
;;; gdk_threads_leave().
;;;
;;; The functions must provide at least same locking functionality as the
;;; default implementation, but can also do extra application specific
;;; processing.
;;;
;;; As an example, consider an application that has its own recursive lock that
;;; when held, holds the GTK lock as well. When GTK unlocks the GTK lock when
;;; entering a recursive main loop, the application must temporarily release its
;;; lock as well.
;;;
;;; Most threaded GTK apps won't need to use this method.
;;;
;;; This method must be called before gdk_threads_init(), and cannot be called
;;; multiple times.
;;;
;;; enter_fn :
;;;     function called to guard GDK
;;;
;;; leave_fn :
;;;     function called to release the guard
;;;
;;; Since 2.4
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gdk_threads_add_idle ()
;;; ----------------------------------------------------------------------------

(defun gdk-threads-add-idle (func &key (priority +g-priority-default-idle+))
 #+liber-documentation
 "@version{#2021-12-13}
  @argument[func]{a @symbol{g-source-func} callback function to call}
  @argument[priority]{an integer with the priority of the idle source,
    typically this will be in the range between @var{+g-priority-default-idle+}
    and @var{+g-priority-high-idle+}}
  @return{An unsigned integer ID, greater than 0, of the event source.}
  @begin{short}
    Adds a function to be called whenever there are no higher priority events
    pending.
  @end{short}
  If the function returns @em{false} it is automatically removed from the list
  of event sources and will not be called again. The default for @arg{priority}
  is @var{+g-priority-default-idle+}.

  This variant of the @fun{g-idle-add} function calls the function with
  the GDK lock held. It can be thought of a MT-safe version for GTK widgets.
  @see-symbol{g-source-func}
  @see-function{g-idle-add}"
  (%gdk-threads-add-idle-full
              priority
              (cffi:callback g:source-func)
              (glib:allocate-stable-pointer func)
              (cffi:callback glib:stable-pointer-destroy-notify)))

(export 'gdk-threads-add-idle)

;;; ----------------------------------------------------------------------------
;;; gdk_threads_add_idle_full ()                           not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_threads_add_idle_full" %gdk-threads-add-idle-full) :uint
  (priority :int)
  (func :pointer)
  (data :pointer)
  (notify :pointer))

(defun gdk-threads-add-idle-full (priority func)
 #+liber-documentation
 "@version{#2021-4-3}
  @argument[priority]{an integer with the priority of the idle source,
    typically this will be in the range between @var{+g-priority-default-idle+}
    and @var{+g-priority-high-idle+}}
  @argument[func]{a @symbol{g-source-func} callback function to call}
  @return{An unsigned integer with the ID, greater than 0, of the event source.}
  @begin{short}
    Adds a function to be called whenever there are no higher priority events
    pending.
  @end{short}
  If the function returns @em{false} it is automatically removed from the list
  of event sources and will not be called again.

  This variant of the function @sym{g-idle-add-full} calls the function with
  the GDK lock held. It can be thought of a MT-safe version for GTK widgets
  for the following use case, where you have to worry about
  @code{idle_callback()} running in thread A and accessing self after it has
  been finalized in thread B:
  @begin{pre}
static gboolean
idle_callback (gpointer data)
{
   /* gdk_threads_enter(); would be needed for g_idle_add() */

   SomeWidget *self = data;
   /* do stuff with self */

   self->idle_id = 0;

   /* gdk_threads_leave(); would be needed for g_idle_add() */
   return FALSE;
@}

static void
some_widget_do_stuff_later (SomeWidget *self)
{
   self->idle_id = gdk_threads_add_idle (idle_callback, self)
   /* using g_idle_add() here would require thread protection in the
      callback */
@}

static void
some_widget_finalize (GObject *object)
 {
    SomeWidget *self = SOME_WIDGET (object);
    if (self->idle_id)
      g_source_remove (self->idle_id);
    G_OBJECT_CLASS (parent_class)->finalize (object);
@}
  @end{pre}
  @see-symbol{g-source-func}
  @see-function{gdk-threads-add-idle}"
  (%gdk-threads-add-idle-full
              priority
              (cffi:callback g:source-func)
              (glib:allocate-stable-pointer func)
              (cffi:callback glib:stable-pointer-destroy-notify)))

;;; ----------------------------------------------------------------------------
;;; gdk_threads_add_timeout ()
;;; ----------------------------------------------------------------------------

(defun gdk-threads-add-timeout (interval func
                                &key (priority +g-priority-default+))
 #+liber-documentation
 "@version{#2021-12-13}
  @argument[interval]{an unsigned integer with the time between calls to the
    function, in milliseconds (1/1000ths of a second)}
  @argument[func]{a @symbol{g-source-func} callback function to call}
  @argument[priority]{an integer with the priority of the timeout source,
    typically this will be in the range between @var{+g-priority-default-idle+}
    and @var{+g-priority-high-idle+}}
  @return{An unsigned integer ID, greater than 0, of the event source.}
  @begin{short}
    Sets a function to be called at regular intervals holding the GDK lock,
    with the given priority.
  @end{short}
  The default priority is @var{+g-priority-default+}. The function is called
  repeatedly until it returns @em{false}, at which point the timeout is
  automatically destroyed and the function will not be called again.

  Note that timeout functions may be delayed, due to the processing of other
  event sources. Thus they should not be relied on for precise timing. After
  each call to the timeout function, the time of the next timeout is
  recalculated based on the current time and the given interval It does not
  try to 'catch up' time lost in delays.

  This variant of the @fun{g-timeout-add} function can be thought of a MT-safe
  version for GTK widgets.
  @see-symbol{g-source-func}
  @see-function{g-timeout-add}"
  (%gdk-threads-add-timeout-full
              priority
              interval
              (cffi:callback g:source-func)
              (glib:allocate-stable-pointer func)
              (cffi:callback glib:stable-pointer-destroy-notify)))

(export 'gdk-threads-add-timeout)

;;; ----------------------------------------------------------------------------
;;; gdk_threads_add_timeout_full ()                        not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_threads_add_timeout_full" %gdk-threads-add-timeout-full) :uint
  (priority :int)
  (interval :uint)
  (func :pointer)
  (data :pointer)
  (notify :pointer))

(defun gdk-threads-add-timeout-full (priority interval func)
 #+liber-documentation
 "@version{#2021-4-3}
  @argument[priority]{an integer with the priority of the timeout source,
    typically this will be in the range between @var{+g-priority-default-idle+}
    and @var{+g-priority-high-idle+}}
  @argument[interval]{an unsigned integer with the time between calls to the
    function, in milliseconds (1/1000ths of a second)}
  @argument[func]{a @symbol{g-source-func} callback function to call}
  @return{An unsigned integer ID, greater than 0, of the event source.}
  @begin{short}
    Sets a function to be called at regular intervals holding the GDK lock,
    with the given priority.
  @end{short}
  The function is called repeatedly until it returns @em{false}, at which point
  the timeout is automatically destroyed and the function will not be called
  again. The notify function is called when the timeout is destroyed. The first
  call to the function will be at the end of the first interval.

  Note that timeout functions may be delayed, due to the processing of other
  event sources. Thus they should not be relied on for precise timing. After
  each call to the timeout function, the time of the next timeout is
  recalculated based on the current time and the given interval It does not
  try to 'catch up' time lost in delays.

  This variant of the function @code{g_timeout_add_full()} can be thought of
  a MT-safe version for GTK widgets for the following use case:
  @begin{pre}
static gboolean timeout_callback (gpointer data)
{
   SomeWidget *self = data;

   /* do stuff with self */

   self->timeout_id = 0;

   return G_SOURCE_REMOVE;
@}

static void some_widget_do_stuff_later (SomeWidget *self)
{
   self->timeout_id = g_timeout_add (timeout_callback, self)
@}

static void some_widget_finalize (GObject *object)
{
   SomeWidget *self = SOME_WIDGET (object);

   if (self->timeout_id)
     g_source_remove (self->timeout_id);

   G_OBJECT_CLASS (parent_class)->finalize (object);
@}
  @end{pre}
  @see-symbol{g-source-func}
  @see-function{gdk-threads-add-timeout}"
  (%gdk-threads-add-timeout-full
              priority
              interval
              (cffi:callback g:source-func)
              (glib:allocate-stable-pointer func)
              (cffi:callback glib:stable-pointer-destroy-notify)))

;;; ----------------------------------------------------------------------------
;;; gdk_threads_add_timeout_seconds ()
;;; ----------------------------------------------------------------------------

(defun gdk-threads-add-timeout-seconds (interval func
                                        &key (priority +g-priority-default+))
 #+liber-documentation
 "@version{#2021-12-13}
  @argument[interval]{an unsigned integer with the time between calls to the
    function, in seconds}
  @argument[func]{a @symbol{g-source-func} callback function to call}
  @argument[priority]{an integer with the priority of the timeout source,
    typically this will be in the range between @var{+g-priority-default-idle+}
    and @var{+g-priority-high-idle+}}
  @return{An unsigned integer ID, greater than 0, of the event source.}
  @begin{short}
    A variant of the @fun{gdk-threads-add-timeout} function with second
    granularity.
  @end{short}
  The default priority is @var{+g-priority-default+}. See the
  @fun{g-timeout-add-seconds} function for a discussion of why it is a good
  idea to use this function if you do not need finer granularity.
  @see-symbol{g-source-func}
  @see-function{g-timeout-add-seconds}"
  (%gdk-threads-add-timeout-seconds-full
              priority
              interval
              (cffi:callback g:source-func)
              (glib:allocate-stable-pointer func)
              (cffi:callback glib:stable-pointer-destroy-notify)))

(export 'gdk-threads-add-timeout-seconds)

;;; ----------------------------------------------------------------------------
;;; gdk_threads_add_timeout_seconds_full ()                not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_threads_add_timeout_seconds_full"
          %gdk-threads-add-timeout-seconds-full) :uint
  (priority :int)
  (interval :uint)
  (func :pointer)
  (data :pointer)
  (notify :pointer))

;; The Lisp implementation does not support the arguments data and notify.

(defun gdk-threads-add-timeout-seconds-full (priority interval func)
 #+liber-documentation
 "@version{#2021-12-13}
  @argument[priority]{an integer with the priority of the timeout source,
    typically this will be in the range between @var{+g-priority-default-idle+}
    and @var{+g-priority-high-idle+}}
  @argument[interval]{an unsigned integer with the time between calls to the
    function, in seconds}
  @argument[func]{a @symbol{g-source-func} callback function to call}
  @return{An unsigned integer ID, greater than 0, of the event source.}
  @begin{short}
    A variant of the @fun{gdk-threads-add-timeout-full} function with
    second-granularity.
  @end{short}
  See the @fun{g-timeout-add-seconds} function for a discussion of why it
  is a good idea to use this function if you do not need finer granularity.
  @see-symbol{g-source-func}
  @see-function{gdk-threads-add-timeout-full}"
  (%gdk-threads-add-timeout-seconds-full
          priority
          interval
          (cffi:callback g:source-func)
          (glib:allocate-stable-pointer func)
          (cffi:callback glib:stable-pointer-destroy-notify)))

;;; --- End of file gdk3.threads.lisp ------------------------------------------
