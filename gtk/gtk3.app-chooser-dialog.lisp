;;; ----------------------------------------------------------------------------
;;; gtk3.app-chooser-dialog.lisp
;;;
;;; The documentation of this file is taken from the GTK+ 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK+ library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2013 - 2023 Dieter Kaiser
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
;;; GtkAppChooserDialog
;;;
;;;     An application chooser dialog
;;;
;;; Types and Values
;;;
;;;     GtkAppChooserDialog
;;;
;;; Functions
;;;
;;;     gtk_app_chooser_dialog_new
;;;     gtk_app_chooser_dialog_new_for_content_type
;;;     gtk_app_chooser_dialog_get_widget
;;;     gtk_app_chooser_dialog_set_heading                 Accessor
;;;     gtk_app_chooser_dialog_get_heading                 Accessor
;;;
;;; Properties
;;;
;;;     gfile
;;;     heading
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkBin
;;;                     ╰── GtkWindow
;;;                         ╰── GtkDialog
;;;                             ╰── GtkAppChooserDialog
;;;
;;; Implemented Interfaces
;;;
;;;     GtkAppChooserDialog implements AtkImplementorIface, GtkBuildable and
;;;     GtkAppChooser.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkAppChooserDialog
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkAppChooserDialog" app-chooser-dialog
  (:superclass dialog
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkAppChooser")
   :type-initializer "gtk_app_chooser_dialog_get_type")
  ((gfile
    app-chooser-dialog-gfile
    "gfile" "GFile" t t)
   (heading
    app-chooser-dialog-heading
    "heading" "gchararray" t t)))

#+liber-documentation
(setf (documentation 'app-chooser-dialog 'type)
 "@version{2023-2-18}
  @begin{short}
    The @sym{gtk:app-chooser-dialog} widget shows a
    @class{gtk:app-chooser-widget} widget inside a @class{gtk:dialog} widget.
  @end{short}
  Note that the @sym{gtk:app-chooser-dialog} widget does not have any
  interesting methods of its own. Instead, you should get the embedded
  @class{gtk:app-chooser-widget} widget using the
  @fun{gtk:app-chooser-dialog-widget} function and call its methods if the
  @class{gtk:app-chooser} interface is not sufficient for your needs.

  To set the heading that is shown above the @class{gtk:app-chooser-widget}
  widget, use the @fun{gtk:app-chooser-dialog-heading} function.
  @see-constructor{gtk:app-chooser-dialog-new}
  @see-constructor{gtk:app-chooser-dialog-new-for-content-type}
  @see-slot{gtk:app-chooser-dialog-gfile}
  @see-slot{gtk:app-chooser-dialog-heading}
  @see-class{gtk:dialog}
  @see-class{gtk:app-chooser}
  @see-function{gtk:app-chooser-dialog-widget}
  @see-function{gtk:app-chooser-dialog-heading}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- app-chooser-dialog-gfile -----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "gfile" 'app-chooser-dialog) t)
 "The @code{gfile} property of type @class{g:file}
  (Read / Write / Construct Only) @br{}
  The @class{g:file} object used by the @sym{gtk:app-chooser-dialog} widget.
  The dialog's content type will be guessed from the file, if present.")

#+liber-documentation
(setf (liber:alias-for-function 'app-chooser-dialog-gfile)
      "Accessor"
      (documentation 'app-chooser-dialog-gfile 'function)
 "@version{2023-2-18}
  @begin{short}
    Accessor of the @slot[gtk:app-chooser-dialog]{gfile} slot of the
    @class{gtk:app-chooser-dialog} class.
  @end{short}
  @see-class{gtk:app-chooser-dialog}")

;;; --- app-chooser-dialog-heading ---------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "heading" 'app-chooser-dialog) t)
 "The @code{heading} property of type @code{:string} (Read / Write) @br{}
  The text to show at the top of the dialog. The string may contain Pango
  markup. @br{}
  Default value: @code{nil}")

#+liber-documentation
(setf (liber:alias-for-function 'app-chooser-dialog-heading)
      "Accessor"
      (documentation 'app-chooser-dialog-heading 'function)
 "@version{2023-2-18}
  @syntax[]{gtk:app-chooser-dialog-heading object) => heading}
  @syntax[]{(setf (gtk:app-chooser-dialog-heading object) heading)}
  @argument[object]{a @class{gtk:app-chooser-dialog} widget}
  @argument[heading]{a string containing Pango markup}
  @begin{short}
    Accessor of the @slot[gtk:app-chooser-dialog]{heading} slot of the
    @class{gtk:app-chooser-dialog} class.
  @end{short}
  The @sym{gtk:app-chooser-dialog-heading} function returns the text to display
  at the top of the dialog. The @sym{(setf gtk:app-chooser-dialog-heading)}
  function sets the text to display at the top of the dialog. If the heading is
  not set, the dialog displays a default text.
  @see-class{gtk:app-chooser-dialog}")

;;; ----------------------------------------------------------------------------
;;; gtk_app_chooser_dialog_new ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_app_chooser_dialog_new" app-chooser-dialog-new)
    (g:object widget)
 #+liber-documentation
 "@version{2023-2-18}
  @argument[parent]{a @class{gtk:window} widget, or @code{nil}}
  @argument[flags]{a @symbol{gtk:dialog-flags} value for this dialog}
  @argument[file]{a @class{g:file} object}
  @return{A newly created @class{gtk:app-chooser-dialog} widget.}
  @begin{short}
    Creates a new application chooser dialog for the provided @class{g:file}
    object, to allow the user to select an application for it.
  @end{short}
  @see-class{gtk:app-chooser-dialog}
  @see-class{gtk:window}
  @see-class{g:file}
  @see-symbol{gtk:dialog-flags}"
  (parent (g:object window))
  (flags dialog-flags)
  (file g:object))

(export 'app-chooser-dialog-new)

;;; ----------------------------------------------------------------------------
;;; gtk_app_chooser_dialog_new_for_content_type ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_app_chooser_dialog_new_for_content_type"
           app-chooser-dialog-new-for-content-type) (g:object widget)
 #+liber-documentation
 "@version{2023-2-18}
  @argument[parent]{a @class{gtk:window} widget, or @code{nil}}
  @argument[flags]{a @symbol{gtk:dialog-flags} value for this dialog}
  @argument[content-type]{a content type string}
  @return{A newly created @class{gtk:app-chooser-dialog} widget.}
  @begin{short}
    Creates a new application chooser dialog for the provided content type, to
    allow the user to select an application for it.
  @end{short}
  @see-class{gtk:app-chooser-dialog}
  @see-class{gtk:window}
  @see-symbol{gtk:dialog-flags}"
  (parent (g:object window))
  (flags dialog-flags)
  (content-type :string))

(export 'app-chooser-dialog-new-for-content-type)

;;; ----------------------------------------------------------------------------
;;; gtk_app_chooser_dialog_get_widget () -> app-chooser-dialog-widget
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_app_chooser_dialog_get_widget" app-chooser-dialog-widget)
    (g:object widget)
 #+liber-documentation
 "@version{2023-2-18}
  @argument[dialog]{a @class{gtk:app-chooser-dialog} widget}
  @return{The @class{gtk:app-chooser-widget} widget of @arg{dialog}.}
  @begin{short}
    Returns the application chooser widget of the dialog.
  @end{short}
  @see-class{gtk:app-chooser-dialog}
  @see-class{gtk:app-chooser-widget}"
  (dialog (g:object app-chooser-dialog)))

(export 'app-chooser-dialog-widget)

;;; --- End of file gtk3.app-chooser-dialog.lisp -------------------------------
