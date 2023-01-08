;;; ----------------------------------------------------------------------------
;;; gtk.init.lisp
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
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

(in-package :gtk)

(defun finalize-subclasses (class)
  (c2mop:ensure-finalized class)
  (iter (for subclass in (c2mop:class-direct-subclasses class))
        (finalize-subclasses subclass)))

(defun finalize-gtk-classes ()
  (finalize-subclasses (find-class 'g:object)))

(finalize-gtk-classes)

;;; ----------------------------------------------------------------------------

#+thread-support
(progn
  (defvar *main-thread* nil)
  (defvar *main-thread-level* 0)
  (defvar *main-thread-lock* (bt:make-lock "*main-thread* lock"))

  (glib-init:at-finalize ()
    (when (and *main-thread* (bt:thread-alive-p *main-thread*))
      (bt:destroy-thread *main-thread*)
      (setf *main-thread* nil)))

  (defun ensure-gtk-main ()
    (bt:with-lock-held (*main-thread-lock*)
      (when (and *main-thread* (not (bt:thread-alive-p *main-thread*)))
        (setf *main-thread* nil))
      (unless *main-thread*
        (setf *main-thread*
              (bt:make-thread (lambda ()
                                ;; On Windows it is necessary to use the
                                ;; version gtk-main which puts the C function
                                ;; %main between gdk-thread-enter und
                                ;; gdk-thread-leave
                                (unless (find :win32 *features*)
                                  ;; Calling on win32 will deadlock
                                  (gdk::gdk-threads-init)
                                  (gdk::gdk-threads-enter))
                                (unwind-protect
                                  (progn
;                                   (%gtk-init)
                                    (%main))
                                  (unless (find :win32 *features*)
                                    ;; Calling on win32 will deadlock
                                    (gdk::gdk-threads-leave))
                                  ))
                              :name "cl-cffi-gtk main thread")
              *main-thread-level* 0))
      (incf *main-thread-level*))
    (values *main-thread* *main-thread-level*))

  (defun join-gtk-main ()
   #+liber-documentation
   "@version{#2021-11-13}
    @begin{short}
      Wait until the GTK program terminates.
    @end{short}
    @see-function{within-main-loop}
    @see-function{leave-gtk-main}"
    (when *main-thread*
      (bt:join-thread *main-thread*)))

  (defun leave-gtk-main ()
   #+liber-documentation
   "@version{#2021-11-13}
    @begin{short}
      Makes the innermost invocation of the main loop return when it regains
      control.
    @end{short}

    In the Lisp binding to GTK the @fun{gtk:main-quit} function is not called,
    but the @sym{leave-gtk-main} function. The @sym{leave-gtk-main} function
    does some additional bookkeeping, which is necessary to stop a Lisp program
    safely. See the @fun{within-main-loop} documentation for an example.
    @see-function{within-main-loop}
    @see-function{gtk:main-quit}"
    (bt:with-lock-held (*main-thread-lock*)
      (decf *main-thread-level*)
      (when (<= *main-thread-level* 0)
        (main-quit)
        (setf *main-thread-level* 0)))
    (values *main-thread* *main-thread-level*)))

#-thread-support
(progn
  (defun ensure-gtk-main ()
    (gtk-main)
    (values))

  (defun leave-gtk-main ()
    (main-quit))

  (defun join-gtk-main ()))

(export 'ensure-gtk-main)
(export 'leave-gtk-main)
(export 'join-gtk-main)

;;; ----------------------------------------------------------------------------

(defcallback call-from-main-loop-callback :boolean
    ((data :pointer))
  (restart-case
      (progn (funcall (glib:get-stable-pointer-value data))
             nil)
    (return-from-callback () nil)))

(defun call-from-gtk-main-loop (func &key (priority +g-priority-default-idle+))
  (glib::%idle-add-full priority
                        (cffi:callback call-from-main-loop-callback)
                        (glib:allocate-stable-pointer func)
                        (cffi:callback glib:stable-pointer-destroy-notify))
  (ensure-gtk-main))

(defmacro within-main-loop (&body body)
 #+liber-documentation
 "@version{#2021-11-13}
  @begin{short}
    The @sym{within-main-loop} macro is a wrapper around a GTK program.
  @end{short}
  The functionality of the macro corresponds to the @code{gtk_init()} and
  @code{gtk_main()} C functions which initialize and start a GTK program. Both
  functions have corresponding Lisp functions. The @code{gtk_main()} function is
  exported as the @fun{gtk-main} Lisp function. The corresponding Lisp function
  to the @code{gtk_init()} function is called internally when loading the
  library, but is not exported.

  To stop the execution of the main loop the @fun{leave-gtk-main} function is
  called.
  @begin[Example]{dictionary}
    An example with a simple window from the
    @url[http://www.crategus.com/books/cl-gtk/gtk-tutorial.html#example-simple-window]{GTK Lisp tutorial}
    which shows the usage of the @sym{within-main-loop} macro:
    @begin{pre}
(defun example-simple-window ()
  (within-main-loop
    (let (;; Create a toplevel window.
          (window (gtk-window-new :toplevel)))
      ;; Signal handler for the window to handle the signal \"destroy\".
      (g:signal-connect window \"destroy\"
                        (lambda (widget)
                          (declare (ignore widget))
                          (leave-gtk-main)))
      ;; Show the window.
      (gtk-widget-show-all window))))
    @end{pre}
  @end{dictionary}
  @see-function{gtk-main}
  @see-function{leave-gtk-main}"
  `(call-from-gtk-main-loop (lambda () ,@body)))

(export 'within-main-loop)

#+thread-support
(defmacro with-main-loop (&body body)
  `(progn
     (ensure-gtk-main)
     (within-main-loop ,@body)))

#-thread-support
(defmacro with-main-loop (&body body)
  `(progn
     ,@body
     (ensure-gtk-main)))

;;; ----------------------------------------------------------------------------

(glib-init:at-init () (%gtk-init))

;;; --- End of file gtk.init.lisp ----------------------------------------------
