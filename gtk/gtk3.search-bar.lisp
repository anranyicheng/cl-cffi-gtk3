;;; ----------------------------------------------------------------------------
;;; gtk3.search-bar.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK+ library.
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
;;; GtkSearchBar
;;;
;;;     A toolbar to integrate a search entry with
;;;
;;; Types and Values
;;;
;;;     GtkSearchBar
;;;
;;; Functions
;;;
;;;     gtk_search_bar_new
;;;     gtk_search_bar_connect_entry
;;;     gtk_search_bar_get_search_mode                     Accessor
;;;     gtk_search_bar_set_search_mode                     Accessor
;;;     gtk_search_bar_get_show_close_button               Accessor
;;;     gtk_search_bar_set_show_close_button               Accessor
;;;     gtk_search_bar_handle_event
;;;
;;; Properties
;;;
;;;     search-mode-enabled
;;;     show-close-button
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkBin
;;;                     ╰── GtkSearchBar
;;;
;;; Implemented Interfaces
;;;
;;;     GtkSearchBar implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkSearchBar
;;; ----------------------------------------------------------------------------

;; TODO: Replace the example with Lisp code

(define-g-object-class "GtkSearchBar" search-bar
  (:superclass bin
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable")
   :type-initializer "gtk_search_bar_get_type")
  ((search-mode-enabled
    search-bar-search-mode-enabled
    "search-mode-enabled" "gboolean" t t)
   (show-close-button
    search-bar-show-close-button
    "show-close-button" "gboolean" t t)))

#+liber-documentation
(setf (documentation 'search-bar 'type)
 "@version{#2023-2-16}
  @begin{short}
    The @sym{gtk:search-bar} widget is a container made to have a search entry 
    built-in, possibly with additional connex widgets, such as drop-down menus, 
    or buttons.
  @end{short}
  The search bar would appear when a search is started through typing on the
  keyboard, or the application’s search mode is toggled on.

  @image[search-bar]{}

  For keyboard presses to start a search, events will need to be forwarded from
  the toplevel window that contains the search bar. See the
  @func{gtk:search-bar-handle-event} function for example code. Common shortcuts
  such as the @kbd{Ctrl+F} key should be handled as an application action, or
  through the menu items.

  You will also need to tell the search bar about which entry you are using as
  your search entry using the @fun{gtk:search-bar-connect-entry} function. The
  following example shows you how to create a more complex search entry.
  @begin[CSS nodes]{dictionary}
    The @sym{gtk:search-bar} implementation has a single CSS node with name 
    @code{searchbar}.
  @end{dictionary}
  @begin[Example]{dictionary}
    Creating a search bar.
    @begin{pre}
#include <gtk/gtk.h>

static gboolean
window_key_press_event_cb (GtkWidget *window,
    GdkEvent *event,
    GtkSearchBar *search_bar)
{
  return gtk_search_bar_handle_event (search_bar, event);
@}

static void
activate_cb (GtkApplication *app,
    gpointer user_data)
{
  GtkWidget *window;
  GtkWidget *search_bar;
  GtkWidget *box;
  GtkWidget *entry;
  GtkWidget *menu_button;

  window = gtk_application_window_new (app);
  gtk_widget_show (window);

  search_bar = gtk_search_bar_new ();
  gtk_container_add (GTK_CONTAINER (window), search_bar);
  gtk_widget_show (search_bar);

  box = gtk_box_new (GTK_ORIENTATION_HORIZONTAL, 6);
  gtk_container_add (GTK_CONTAINER (search_bar), box);
  gtk_widget_show (box);

  entry = gtk_search_entry_new ();
  gtk_box_pack_start (GTK_BOX (box), entry, TRUE, TRUE, 0);
  gtk_widget_show (entry);

  menu_button = gtk_menu_button_new ();
  gtk_box_pack_start (GTK_BOX (box), menu_button, FALSE, FALSE, 0);
  gtk_widget_show (menu_button);

  gtk_search_bar_connect_entry (GTK_SEARCH_BAR (search_bar), GTK_ENTRY (entry));

  g_signal_connect (window, \"key-press-event\",
      G_CALLBACK (window_key_press_event_cb), search_bar);
@}

gint
main (gint argc,
    gchar *argv[@])
{
  GtkApplication *app;

  app = gtk_application_new (\"org.gtk.Example.GtkSearchBar\",
      G_APPLICATION_FLAGS_NONE);
  g_signal_connect (app, \"activate\",
      G_CALLBACK (activate_cb), NULL);

  return g_application_run (G_APPLICATION (app), argc, argv);
@}
    @end{pre}
  @end{dictionary}
  @see-constructor{gtk:search-bar-new}
  @see-slot{gtk:search-bar-search-mode-enabled}
  @see-slot{gtk:search-bar-show-close-button}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- search-bar-search-mode-enabled -----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "search-mode-enabled"
                                               'search-bar) t)
 "The @code{search-mode-enabled} property of type @code{:boolean}
  (Read / Write / Construct) @br{}
  Whether the search mode is on and the search bar shown. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'search-bar-search-mode-enabled)
      "Accessor"
      (documentation 'search-bar-search-mode-enabled 'function)
 "@version{#2023-2-16}
  @syntax[]{(gtk:search-bar-search-mode-enabled object) => search-mode}
  @syntax[]{(setf (gtk:search-bar-search-mode-enabled object) search-mode)}
  @argument[object]{a @class{gtk:search-bar} widget}
  @argument[search-mode]{a boolean with the state of the search mode}
  @begin{short}
    Accessor of the @slot[gtk:search-bar]{search-mode-enabled} slot of the
    @class{gtk:search-bar} class.
  @end{short}
  Switches the search mode on or off.
  @see-class{gtk:search-bar}")

;;; --- search-bar-show-close-button -------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "show-close-button"
                                               'search-bar) t)
 "The @code{show-close-button} property of type @code{:boolean}
  (Read / Write / Construct) @br{}
  Whether to show the Close button in the toolbar. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'search-bar-show-close-button)
      "Accessor"
      (documentation 'search-bar-show-close-button 'function)
 "@version{#2023-2-16}
  @syntax[]{(gtk:search-bar-show-close-button object) => visible}
  @syntax[]{(setf (gtk:search-bar-show-close-button object) visible)}
  @argument[object]{a @class{gtk:search-bar} widget}
  @argument[visible]{a boolean whether the Close button will be shown or not}
  @begin{short}
    Accessor of the @slot[gtk:search-bar]{show-close-button} slot of the
    @class{gtk:search-bar} class.
  @end{short}
  The @sym{gtk:search-bar-show-close-button} function returns whether the Close
  button is shown. The @sym{(setf gtk:search-bar-show-close-button} function
  shows or hides the Close button. Applications that already have a \"search\" 
  toggle button should not show a Close button in their search bar, as it 
  duplicates the role of the toggle button.
  @see-class{gtk:search-bar}")

;;; ----------------------------------------------------------------------------
;;; gtk_search_bar_new ()
;;; ----------------------------------------------------------------------------

(defun search-bar-new ()
 #+liber-documentation
 "@version{#2023-2-16}
  @return{A new @class{gtk:search-bar} widget.}
  @begin{short}
    Creates a search bar.
  @end{short}
  You will need to tell it about which widget is going to be your text entry
  using the @fun{gtk:search-bar-connect-entry} function.
  @see-class{gtk:search-bar}
  @see-function{gtk:search-bar-connect-entry}"
  (make-instance 'search-bar))

(export 'search-bar-new)

;;; ----------------------------------------------------------------------------
;;; gtk_search_bar_connect_entry ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_search_bar_connect_entry" search-bar-connect-entry) :void
 #+liber-documentation
 "@version{#2023-2-16}
  @argument[search-bar]{a @class{gtk:search-bar} widget}
  @argument[entry]{a @class{gtk:entry} widget}
  @begin{short}
    Connects the entry widget passed as the one to be used in this search bar.
  @end{short}
  The entry should be a descendant of the search bar. This is only required if
  the entry is not the direct child of the search bar.
  @see-class{gtk:search-bar}
  @see-class{gtk:entry}"
  (search-bar (g:object search-bar))
  (entry (g:object entry)))

(export 'search-bar-connect-entry)

;;; ----------------------------------------------------------------------------
;;; gtk_search_bar_get_search_mode ()
;;; ----------------------------------------------------------------------------

;; Implemented as the accessor search-bar-search-mode-enabled

;;; ----------------------------------------------------------------------------
;;; gtk_search_bar_set_search_mode ()
;;; ----------------------------------------------------------------------------

;; Implemented as the accessor search-bar-search-mode-enabled

;;; ----------------------------------------------------------------------------
;;; gtk_search_bar_handle_event ()
;;; ----------------------------------------------------------------------------

;; TODO: Replace the example with Lisp code

(defcfun ("gtk_search_bar_handle_event" search-bar-handle-event) :boolean

 #+liber-documentation
 "@version{#2023-2-16}
  @argument[search-bar]{a @class{gtk:search-bar} widget}
  @argument[event]{a @class{gdk:event} event containing key press events}
  @return{@var{+gdk-event-stop+} if the key press event resulted in text being
    entered in the search entry, and revealing the search bar if necessary,
    @var{+gdk-event-propagate+} otherwise.}
  @begin{short}
    This function should be called when the toplevel window which contains the
    search bar received a key event.
  @end{short}
  If the key event is handled by the search bar, the bar will be shown, the
  entry populated with the entered text and @var{+gdk-event-stop+} will be
  returned. The caller should ensure that events are not propagated further.

  If no entry has been connected to the search bar, using the
  @fun{gtk:search-bar-connect-entry} function, this function will return 
  immediately with a warning.
  @begin[Example]{dictionary}
    Showing the search bar on key presses
    @begin{pre}
static gboolean
on_key_press_event (GtkWidget *widget,
                    GdkEvent  *event,
                    gpointer   user_data)
{
  GtkSearchBar *bar = GTK_SEARCH_BAR (user_data);
  return gtk_search_bar_handle_event (bar, event);
@}

static void
create_toplevel (void)
{
  GtkWidget *window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
  GtkWindow *search_bar = gtk_search_bar_new ();

 // Add more widgets to the window...

  g_signal_connect (window,
                   \"key-press-event\",
                    G_CALLBACK (on_key_press_event),
                    search_bar);
@}
    @end{pre}
  @end{dictionary}
  @see-class{gtk:search-bar}
  @see-function{gtk:search-bar-connect-entry}"
  (search-bar (g:object search-bar))
  (event (g:boxed gdk:event)))

(export 'search-bar-handle-event)

;;; --- End of file gtk3.search-bar.lisp ---------------------------------------
