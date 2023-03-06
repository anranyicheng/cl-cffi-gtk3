;;; ----------------------------------------------------------------------------
;;; gtk3.shortcuts-window.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
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
;;; GtkShortcutsWindow
;;;
;;;     Toplevel which shows help for shortcuts
;;;
;;; Types and Values
;;;
;;;     GtkShortcutsWindow
;;;
;;; Properties
;;;
;;;     section-name
;;;     view-name
;;;
;;; Signals
;;;
;;;     close
;;;     search
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkBin
;;;                     ╰── GtkWindow
;;;                         ╰── GtkShortcutsWindow
;;;
;;; Implemented Interfaces
;;;
;;;     GtkShortcutsWindow implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkShortcutsWindow
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkShortcutsWindow" shortcuts-window
  (:superclass window
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable")
   :type-initializer "gtk_shortcuts_window_get_type")
   ((section-name
    shortcuts-window-section-name
    "section-name" "gchararray" t t)
   (view-name
    shortcuts-window-view-name
    "view-name" "gchararray" t t)))

#+liber-documentation
(setf (documentation 'shortcuts-window 'type)
 "@version{#2023-2-28}
  @begin{short}
    A @sym{gtk:shortcuts-window} widget shows brief information about the
    keyboard shortcuts and gestures of an application.
  @end{short}
  The shortcuts can be grouped, and you can have multiple sections in this
  window, corresponding to the major modes of your application.

  Additionally, the shortcuts can be filtered by the current view, to avoid
  showing information that is not relevant in the current application context.

  The recommended way to construct a @sym{gtkshortcuts-window} widget is with
  the @class{gtk:builder} object, by populating a @sym{gtk:shortcuts-window} 
  widget with one or more @class{gtk:shortcuts-section} widgets, which contain
  @class{gtk:shortcuts-groups} widgets that in turn contain
  @class{gtk:shortcuts-shortcut} widgets.
  @begin[Example]{dictionary}
    A simple example:
    This example has as single section. As you can see, the shortcut groups are
    arranged in columns, and spread across several pages if there are too many
    to find on a single page. The @file{.ui} file for this example can be found
    @url[https://gitlab.gnome.org/GNOME/gtk/-/blob/master/demos/gtk-demo/shortcuts-gedit.ui]{here}.

    @image[gedit-shortcuts]{}

    An example with multiple views:
    This example shows a @sym{gtk:shortcuts-window} widget that has been
    configured to show only the shortcuts relevant to the \"stopwatch\" view.
    The @file{.ui} file for this example can be found
    @url[https://gitlab.gnome.org/GNOME/gtk/-/blob/master/demos/gtk-demo/shortcuts-clocks.ui]{here}.

    @image[clocks-shortcuts]{}

    An example with multiple sections:
    This example shows a @sym{gtk:shortcuts-window} widget with two sections,
    \"Editor Shortcuts\" and \"Terminal Shortcuts\". The @file{.ui} file for
    this example can be found
    @url[https://gitlab.gnome.org/GNOME/gtk/-/blob/master/demos/gtk-demo/shortcuts-builder.ui]{here}.

    @image[builder-shortcuts]{}
  @end{dictionary}
  @begin[Signal Details]{dictionary}
    @subheading{The \"close\" signal}
      @begin{pre}
lambda (shortcutswindow)    :action
      @end{pre}
      The signal is a keybinding signal which gets emitted when the user uses a
      keybinding to close the window. The default binding for this signal is the
      @kbd{Escape} key.
      @begin[code]{table}
        @entry[shortcutswindow]{The @sym{gtk:shortcuts-window} widget.}
      @end{table}
    @subheading{The \"search\" signal}
      @begin{pre}
lambda (shortcutswindow)    :action
      @end{pre}
      The signal is a keybinding signal which gets emitted when the user uses a 
      keybinding to start a search. The default binding for this signal is 
      @kbd{Control-F}.
      @begin[code]{table}
        @entry[shortcutswindow]{The @sym{gtk:shortcuts-window} widget.}
      @end{table}
  @end{dictionary}
  @see-slot{gtk:shortcuts-window-section-name}
  @see-slot{gtk:shortcuts-window-view-name}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- shortcuts-window-section-name ------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "section-name" 
                                               'shortcuts-window) t)
 "The @code{section-name} property of type @code{:string} (Read / Write) @br{}
  The name of the section to show. This should be the section name of one of the
  @class{gtk:shortcuts-section} widgets that are in this shortcuts window. @br{}
  Default value: \"internal-search\"")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-window-section-name)
      "Accessor"
      (documentation 'shortcuts-window-section-name 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-window-section-name object) => section-name}
  @syntax[]{(setf (gtk:shortcuts-window-section-name object) section-name)}
  @argument[object]{a @class{gtk:shortcuts-window} widget}
  @argument[section-name]{a string with a name of the section to show}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-window]{section-name} slot of the
    @class{gtk:shortcuts-window} class.
  @end{short}
  The name of the section to show. This should be the section name of one of 
  the @class{gtk:shortcuts-section} widgets that are in this shortcuts window.
  @see-class{gtk:shortcuts-window}
  @see-class{gtk:shortcuts-section}")

;;; --- shortcuts-window-view-name ---------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "view-name"
                      'shortcuts-window) t)
 "The @code{view-name} property of type @code{:string} (Read / Write) @br{}
  The view name by which to filter the contents. This should correspond to the
  @code{view} property of some of the @class{gtk:shortcuts-group} widgets that
  are inside this shortcuts window. Set this to @code{nil} to show all groups.
  @br{}
  Default value: @code{nil}")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-window-view-name)
      "Accessor"
      (documentation 'shortcuts-window-view-name 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-window-view-name object) => view-name}
  @syntax[]{(setf (gtk:shortcuts-window-view-name object) view-name)}
  @argument[object]{a @class{gtk:shortcuts-window} widget}
  @argument[view-name]{a string with the view name by which to filter the 
    contents}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-window]{view-name} slot of the
    @class{gtk:shortcuts-window} class.
  @end{short}
  The view name by which to filter the contents. This should correspond to the
  @code{view} property of some of the @class{gtk:shortcuts-group} widgets that
  are inside this shortcuts window. Set this to @code{nil} to show all groups.
  @see-class{gtk:shortcuts-window}")

;;; --- End of file gtk3.shortcuts-window.lisp ---------------------------------
