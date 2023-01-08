;;; ----------------------------------------------------------------------------
;;; gtk.recent-chooser-dialog.lisp
;;;
;;; The documentation of this file is taken from the GTK+ 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK+ library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2009 - 2011 Kalyanov Dmitry
;;; Copyright (C) 2011 - 2022 Dieter Kaiser
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
;;; GtkRecentChooserDialog
;;;
;;;     Displays recently used files in a dialog
;;;
;;; Types and Values
;;;
;;;     GtkRecentChooserDialog
;;;
;;; Functions
;;;
;;;     gtk_recent_chooser_dialog_new
;;;     gtk_recent_chooser_dialog_new_for_manager
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
;;;                             ╰── GtkRecentChooserDialog
;;;
;;; Implemented Interfaces
;;;
;;;     GtkRecentChooserDialog implements AtkImplementorIface, GtkBuildable
;;;     and GtkRecentChooser.
;;;
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; struct GtkRecentChooserDialog
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkRecentChooserDialog" recent-chooser-dialog
  (:superclass dialog
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkRecentChooser")
   :type-initializer "gtk_recent_chooser_dialog_get_type")
  nil)

#+liber-documentation
(setf (documentation 'recent-chooser-dialog 'type)
 "@version{#2020-9-13}
  @image[recentchooserdialog]{}
  @begin{short}
    @sym{gtk:recent-chooser-dialog} is a dialog box suitable for displaying the
    recently used documents.
  @end{short}
  This widgets works by putting a @class{gtk:recent-chooser-widget} inside a
  @class{gtk:dialog}. It exposes the @class{gtk:recent-chooser} interface, so
  you can use all the @class{gtk:recent-chooser} functions on the recent chooser
  dialog as well as those for @class{gtk:dialog}.

  Note that @sym{gtk:recent-chooser-dialog} does not have any methods of its
  own. Instead, you should use the functions that work on a
  @class{gtk:recent-chooser}.
  @begin[Example]{dictionary}
    In the simplest of cases, you can use the following code to use a
    @sym{gtk:recent-chooser-dialog} to select a recently used file:
    @begin{pre}
GtkWidget *dialog;

dialog = gtk_recent_chooser_dialog_new (\"Recent Documents\",
                                        parent_window,
                                        GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL,
                                        GTK_STOCK_OPEN, GTK_RESPONSE_ACCEPT,
                                        NULL);

if (gtk_dialog_run (GTK_DIALOG (dialog)) == GTK_RESPONSE_ACCEPT)
  {
    GtkRecentInfo *info;

    info= gtk_recent_chooser_get_current_item (GTK_RECENT_CHOOSER (dialog));
    open_file (gtk_recent_info_get_uri (info));
    gtk_recent_info_unref (info);
  @}

gtk_widget_destroy (dialog);
    @end{pre}
  @end{dictionary}
  @see-class{gtk:recent-chooser}
  @see-class{gtk:dialog}")

;;; ----------------------------------------------------------------------------
;;; gtk_recent_chooser_dialog_new ()
;;; ----------------------------------------------------------------------------

(defun recent-chooser-dialog-new (title parent &rest buttons)
 #+liber-documentation
 "@version{#2020-9-13}
  @argument[title]{a @code{:string} with the title of the dialog, or @code{nil}}
  @argument[parent]{transient @class{gtk:window} parent of the dialog, or
    @code{nil}}
  @argument[buttons]{pairs with a button text or stock ID and the response ID
    for the button of type @symbol{gtk:response-type}}
  @return{A new @class{gtk:recent-chooser-dialog} object.}
  @begin{short}
    Creates a new @class{gtk:recent-chooser-dialog}.
  @end{short}
  This function is analogous to the function @fun{gtk:dialog-new-with-buttons}.
  @see-class{gtk:recent-chooser-dialog}
  @see-class{gtk:window}
  @see-function{gtk:dialog-new-with-buttons}"
  (let ((dialog (make-instance 'recent-chooser-dialog)))
    (when title
      (setf (window-title dialog) title))
    (when parent
      (setf (window-transient-for dialog) parent))
    (when buttons
      (apply #'dialog-add-buttons (cons dialog buttons)))
    dialog))

(export 'recent-chooser-dialog-new)

;;; ----------------------------------------------------------------------------
;;; gtk_recent_chooser_dialog_new_for_manager ()
;;; ----------------------------------------------------------------------------

(defun recent-chooser-dialog-new-for-manager (title parent manager
                                                  &rest buttons)
 #+liber-documentation
 "@version{#2020-9-13}
  @argument[title]{a @code{:string} with the title of the dialog, or @code{nil}}
  @argument[parent]{transient @class{gtk:window} parent of the dialog, or
    @code{nil}}
  @argument[manager]{a @class{gtk:recent-manager} object}
  @argument[buttons]{pairs with a button text or stock ID and the response ID
    for the button of type @symbol{gtk:response-type}}
  @return{A new @class{gtk:recent-chooser-dialog} object.}
  @begin{short}
    Creates a new @class{gtk:recent-chooser-dialog} with a specified recent
    manager.
  @end{short}

  This is useful if you have implemented your own recent manager, or if you
  have a customized instance of a @class{gtk:recent-manager} object.
  @see-class{gtk:recent-chooser-dialog}
  @see-class{gtk:recent-manager}
  @see-function{gtk:recent-chooser-dialog-new}"
  (let ((dialog (make-instance 'recent-chooser-dialog)))
    (when title
      (setf (window-title dialog) title))
    (when parent
      (setf (window-transient-for dialog) parent))
    (when manager
      (setf (recent-chooser-recent-manager dialog) manager))
    (when buttons
      (apply #'dialog-add-buttons (cons dialog buttons)))
    dialog))

(export 'recent-chooser-dialog-new-for-manager)

;;; --- End of file gkt.recent-chooser-dialog.lisp -----------------------------
