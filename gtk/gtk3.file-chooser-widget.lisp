;;; ----------------------------------------------------------------------------
;;; gtk3.file-chooser-widget.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
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
;;; GtkFileChooserWidget
;;;
;;;     File chooser widget that can be embedded in other widgets
;;;
;;; Types and Values
;;;
;;;     GtkFileChooserWidget
;;;
;;; Functions
;;;
;;;     gtk_file_chooser_widget_new
;;;
;;; Properties
;;;
;;;     search-mode
;;;     subtitle
;;;
;;; Signals
;;;
;;;     desktop-folder
;;;     down-folder
;;;     home-folder
;;;     location-popup
;;;     location-popup-on-paste
;;;     location-toggle-popup
;;;     places-shortcut
;;;     quick-bookmark
;;;     recent-shortcut
;;;     search-shortcut
;;;     show-hidden
;;;     up-folder
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkBox
;;;                     ╰── GtkFileChooserWidget
;;;
;;; Implemented Interfaces
;;;
;;;     GtkFileChooserWidget implements AtkImplementorIface, GtkBuildable,
;;;     GtkOrientable, GtkFileChooser and GtkFileChooserEmbed.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkFileChooserWidget
;;; ----------------------------------------------------------------------------

(gobject:define-g-object-class "GtkFileChooserWidget" file-chooser-widget
  (:superclass box
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkOrientable"
                "GtkFileChooser"
;                TODO: This interface is not documented.
;                We have no implementation.
;                "GtkFileChooserEmbed"
               )
   :type-initializer "gtk_file_chooser_widget_get_type")
  ((search-mode
    file-chooser-widget-search-mode
    "search-mode" "gboolean" t t)
   (subtitle
    file-chooser-widget-subtitle
    "subtitle" "gchararray" t nil)))

#+liber-documentation
(setf (documentation 'file-chooser-widget 'type)
 "@version{#2023-3-17}
  @begin{short}
    The @sym{gtk:file-chooser-widget} widget is a widget for choosing files.
  @end{short}
  It exposes the @class{gtk:file-chooser} interface, and you should use the
  methods of this interface to interact with the widget.
  @begin[CSS nodes]{dictionary}
    The @sym{gtk:file-chooser-widget} widget has a single CSS node with name
    @code{filechooser}.
  @end{dictionary}
  @begin[Signal Details]{dictionary}
    @subheading{The \"desktop-folder\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser show the user's Desktop folder in the file
      list. The default binding for this signal is Alt + D.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"down-folder\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser go to a child of the current folder in the
      file hierarchy. The subfolder that will be used is displayed in the path
      bar widget of the file chooser. For example, if the path bar is showing
      \"/foo/bar/baz\", with bar currently displayed, then this will cause the
      file chooser to switch to the \"baz\" subfolder. The default binding for
      this signal is Alt + Down.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"home-folder\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser show the user's home folder in the file
      list. The default binding for this signal is the @kbd{Alt+Home} key.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"location-popup\" signal}
      @begin{pre}
lambda (widget path)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser show a \"Location\" prompt which the user
      can use to manually type the name of the file he wishes to select. The
      default bindings for this signal are Control + L with a path string of
      \"\" (the empty string). It is also bound to / with a path string of
      \"/\" (a slash): this lets you type / and immediately type a path name.
      On Unix systems, this is bound to ~ (tilde) with a path string of \"~\"
      itself for access to home directories.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
        @entry[path]{A string that gets put in the text entry for the file
          name.}
      @end{table}
    @subheading{The \"location-popup-on-paste\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser show a \"Location\" prompt when the user
      pastes into a @sym{gtk:file-chooser-widget} widget. The default binding
      for this signal is Control + V.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"location-toggle-popup\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to toggle the visibility of a \"Location\" prompt which the user can
      use to manually type the name of the file he wishes to select. The default
      binding for this signal is Control + L.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"places-shortcut\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This
      is used to move the focus to the places sidebar. The default binding for
      this signal is Alt + P.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"quick-bookmark\" signal}
      @begin{pre}
lambda (widget bookmark-index)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser switch to the bookmark specified in the
      bookmark_index parameter. For example, if you have three bookmarks, you
      can pass 0, 1, 2 to this signal to switch to each of them, respectively.
      The default binding for this signal is Alt + 1, Alt + 2, etc. until
      Alt + 0. Note that in the default binding, that Alt + 1 is actually
      defined to switch to the bookmark at index 0, and so on successively;
      Alt + 0 is defined to switch to the bookmark at index 10.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
        @entry[bookmark-index]{An integer with the number of the bookmark to
          switch to.}
      @end{table}
    @subheading{The \"recent-shortcut\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser show the Recent location. The default
      binding for this signal is Alt + R.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"search-shortcut\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser show the search entry. The default binding
      for this signal is Alt + S.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"show-hidden\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser display hidden files. The default binding
      for this signal is Control + H.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
    @subheading{The \"up-folder\" signal}
      @begin{pre}
lambda (widget)    :action
      @end{pre}
      A keybinding signal which gets emitted when the user asks for it. This is
      used to make the file chooser go to the parent of the current folder in
      the file hierarchy. The default binding for this signal is Alt + Up.
      @begin[code]{table}
        @entry[widget]{The @sym{gtk:file-chooser-widget} object which received
          the signal.}
      @end{table}
  @end{dictionary}
  @see-constructor{gtk:file-chooser-widget-new}
  @see-class{gtk:file-chooser}
  @see-class{gtk:file-chooser-dialog}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- file-chooser-widget-search-mode ----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "search-mode"
                                               'file-chooser-widget) t)
 "The @code{search-mode} property of type @code{:boolean} (Read / Write) @br{}
  Search mode. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'file-chooser-widget-search-mode)
      "Accessor"
      (documentation 'file-chooser-widget-search-mode 'function)
 "@version{#2023-3-17}
  @syntax{(gtk:file-chooser-widget object) => search-mode}
  @syntax{(setf (gtk:file-chooser-widget object) search-mode)}
  @argument[object]{a @class{gtk:file-chooser-widget} widget}
  @argument[search-mode]{a boolean whether in search mode}
  @begin{short}
    Accessor of the @slot[gtk:file-chooser-widget]{search-mode} slot of the
    @class{gtk:file-chooser-widget} class.
  @end{short}
  @see-class{gtk:file-chooser-widget}")

;;; --- file-chooser-widget-subtitle -------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "subtitle"
                                               'file-chooser-widget) t)
 "The @code{subtitle} property of type @code{:string} (Read) @br{}
  Subtitle. @br{}
  Default value: \"\"")

#+liber-documentation
(setf (liber:alias-for-function 'file-chooser-widget-subtitle)
      "Accessor"
      (documentation 'file-chooser-widget-subtitle 'function)
 "@version{#2023-3-17}
  @syntax{(gtk:file-chooser-widget object) => subtitle}
  @syntax{(setf (gtk:file-chooser-widget object) subtitle)}
  @argument[object]{a @class{gtk:file-chooser-widget} widget}
  @argument[subtitle]{a string with the subtitle}
  @begin{short}
    Accessor of the @slot[gtk:file-chooser-widget]{subtitle} slot of the
    @class{gtk:file-chooser-widget} class.
  @end{short}
  @see-class{gtk:file-chooser-widget}")

;;; ----------------------------------------------------------------------------
;;; gtk_file_chooser_widget_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline file-chooser-widget-new))

(defun file-chooser-widget-new (action)
 #+liber-documentation
 "@version{#2023-3-17}
  @argument[action]{a value of the @symbol{gtk:file-chooser-action} enumeration
    for open or save mode}
  @return{A new @class{gtk:file-chooser-widget} widget.}
  @begin{short}
    Creates a new file chooser widget.
  @end{short}
  This is a file chooser widget that can be embedded in custom windows, and it
  is the same widget that is used by the @class{gtk:file-chooser-dialog} widget.
  @see-class{gtk:file-chooser-widget}
  @see-class{gtk:file-chooser-dialog}
  @see-symbol{gtk:file-chooser-action}"
  (make-instance 'file-chooser-widget
                 :action action))

(export 'file-chooser-widget-new)

;;; --- End of file gtk3.file-chooser-widget.lisp ------------------------------
