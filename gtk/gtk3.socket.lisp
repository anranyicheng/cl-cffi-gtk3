;;; ----------------------------------------------------------------------------
;;; gtk3.socket.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2023 Dieter Kaiser
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
;;; GtkSocket
;;;
;;;     Container for widgets from other processes
;;;
;;; Synopsis
;;;
;;;     GtkSocket
;;;
;;;     gtk_socket_new
;;;     gtk_socket_add_id
;;;     gtk_socket_get_id
;;;     gtk_socket_get_plug_window
;;;
;;; Signals
;;;
;;;     plug-added
;;;     plug-removed
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkSocket
;;;
;;; Implemented Interfaces
;;;
;;;     GtkSocket implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkSocket
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkSocket" socket
  (:superclass container
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable")
   :type-initializer "gtk_socket_get_type")
  nil)

#+liber-documentation
(setf (documentation 'socket 'type)
 "@version{#2023-2-28}
  @begin{short}
    Together with the @class{gtk:plug} widget, the @sym{gtk:socket} widget
    provides the ability to embed widgets from one process into another process
    in a fashion that is transparent to the user.
  @end{short}
  One process creates a @sym{gtk:socket} widget and passes that widget's window
  ID to the other process, which then creates a @class{gtk:plug} widget with
  that window ID. Any widgets contained in the @class{gtk:plug} widget then
  will appear inside the first application's window.

  The socket's window ID is obtained by using the@fun{gtk:socket-id} function.
  Before using this function, the socket must have been realized, and for hence,
  have been added to its parent.

  @b{Example:} Obtaining the window ID of a socket.
  @begin{pre}
GtkWidget *socket = gtk_socket_new ();
gtk_widget_show (socket);
gtk_container_add (GTK_CONTAINER (parent), socket);

/* The following call is only necessary if one of
 * the ancestors of the socket is not yet visible.
 */
gtk_widget_realize (socket);
g_print (\"The ID of the sockets window is
          %<GTKDOCLINK HREF=\"x\">x</GTKDOCLINK>\n\",
         gtk_socket_get_id (socket));
  @end{pre}
  Note that if you pass the window ID of the socket to another process that
  will create a plug in the socket, you must make sure that the socket widget
  is not destroyed until that plug is created. Violating this rule will cause
  unpredictable consequences, the most likely consequence being that the plug
  will appear as a separate toplevel window. You can check if the plug has
  been created by using the @fun{gtk:socket-plug-window} function. If it
  returns a non-@code{nil} value, then the plug has been successfully created
  inside of the socket.

  When GTK is notified that the embedded window has been destroyed, then it
  will destroy the socket as well. You should always, therefore, be prepared
  for your sockets to be destroyed at any time when the main event loop is
  running. To prevent this from happening, you can connect to the
  \"plug-removed\" signal.

  The communication between a @sym{gtk:socket} and a @class{gtk:plug} widget
  follows the XEmbed protocol. This protocol has also been implemented in other
  toolkits, e.g. Qt, allowing the same level of integration when embedding a
  Qt widget in GTK or vice versa.

  The @class{gtk:plug} and @sym{gtk:socket} widgets are only available when GTK
  is compiled for the X11 platform and @code{GDK_WINDOWING_X11} is defined. They
  can only be used on a @code{GdkX11Display} object.
  @begin[Signal Details]{dictionary}
    @subheading{The \"plug-added\" signal}
      @begin{pre}
lambda (socket)    :run-last
      @end{pre}
      The signal is emitted when a client is successfully added to the socket.
      @begin[code]{table}
        @entry[socket]{The @sym{gtk:socket} widget which received the signal.}
      @end{table}
    @subheading{The \"plug-removed\" signal}
      @begin{pre}
lambda (socket)    :run-last
      @end{pre}
      The signal is emitted when a client is removed from the socket. The
      default action is to destroy the @sym{gtk:socket} widget, so if you want
      to reuse it you must add a signal handler that returns @em{true}.
      @begin[code]{table}
        @entry[socket]{The @sym{gtk:socket} widget which received the signal.}
        @entry[Returns]{@em{True} to stop other handlers from being invoked.}
      @end{table}
  @end{dictionary}
  @see-class{gtk:plug}")

;;; ----------------------------------------------------------------------------
;;; gtk_socket_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline socket-new))

(defun socket-new ()
 #+liber-documentation
 "@version{#2023-2-28}
  @return{The new @class{gtk:socket} widget.}
  @short{Create a new empty socket widget.}
  @see-class{gtk:socket}"
  (make-instance 'socket))

(export 'socket-new)

;;; ----------------------------------------------------------------------------
;;; gtk_socket_add_id ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_socket_add_id" socket-add-id) :void
 #+liber-documentation
 "@version{#2023-2-28}
  @argument[socket]{a @class{gtk:socket} widget}
  @argument[window]{a pointer with the window of a client participating in the
    XEMBED protocol}
  @begin{short}
    Adds an XEMBED client, such as a @class{gtk:plug} widget, to the
    @class{gtk:socket}.
  @end{short}
  The client may be in the same process or in a different process. To embed a
  @class{gtk:plug} widget in a @class{gtk:socket} widget, you can either create
  the @class{gtk:plug} widget with the @fun{gtk:plug-new} function, call the
  @fun{gtk:plug-id} function to get the window ID of the plug, and then pass
  that to the @sym{gtk:socket-add-id} function, or you can call the
  @fun{gtk:socket-id} function to get the window ID for the socket, and call
  the @fun{gtk:plug-new} function passing in that ID.

  The @class{gtk:socket} widget must have already be added into a toplevel
  window before you can make this call.
  @see-class{gtk:socket}
  @see-class{gtk:plug}
  @see-function{gtk:plug-new}
  @see-function{gtk:plug-id}
  @see-function{gtk:socket-id}"
  (socket (g:object socket))
  (window :pointer))

(export 'socket-add-id)

;;; ----------------------------------------------------------------------------
;;; gtk_socket_get_id () -> socket-id
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_socket_get_id" socket-id) :pointer
 #+liber-documentation
 "@version{#2023-2-28}
  @argument[socket]{a @class{gtk:socket} widget}
  @return{A pointer with the window ID for the socket.}
  @begin{short}
    Gets the window ID of a @class{gtk:socket} widget, which can then be used
    to create a client embedded inside the socket, for instance with the
    @fun{gtk:plug-new} function.
  @end{short}

  The @class{gtk:socket} widget must have already be added into a toplevel
  window before you can make this call.
  @see-class{gtk:socket}
  @see-function{gtk:plug-new}"
  (socket (g:object socket)))

(export 'socket-id)

;;; ----------------------------------------------------------------------------
;;; gtk_socket_get_plug_window () -> socket-plug-window
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_socket_get_plug_window" socket-plug-window) (g:object gdk:window)
 #+liber-documentation
 "@version{#2023-2-28}
  @argument[socket]{a @class{gtk:socket} widget}
  @return{A @class{gdk:window} object of the plug if available, or @code{nil}.}
  @begin{short}
    Retrieves the window of the plug.
  @end{short}
  Use this to check if the plug has been created inside of the socket.
  @see-class{gtk:socket}
  @see-class{gdk:window}"
  (socket (g:object socket)))

(export 'socket-plug-window)

;;; --- End of file gtk3.socket.lisp -------------------------------------------
