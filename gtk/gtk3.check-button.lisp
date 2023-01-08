;;; ----------------------------------------------------------------------------
;;; gtk.check-button.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.14 and modified to document the Lisp binding to the GTK library.
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
;;; GtkCheckButton
;;;
;;;     Create widgets with a discrete toggle button.
;;;
;;; Types and Values
;;;
;;;     GtkCheckButton
;;;
;;; Functions
;;;
;;;     gtk_check_button_new
;;;     gtk_check_button_new_with_label
;;;     gtk_check_button_new_with_mnemonic
;;;
;;; Style Properties
;;;
;;;     gint    indicator-size       Read
;;;     gint    indicator-spacing    Read
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkBin
;;;                    ╰── GtkButton
;;;                        ╰── GtkToggleButton
;;;                            ╰── GtkCheckButton
;;;                                ╰── GtkRadioButton
;;;
;;; Implemented Interfaces
;;;
;;;     GtkCheckButton implements AtkImplementorIface, GtkBuildable,
;;;     GtkActionable and GtkActivatable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; GtkCheckButton
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkCheckButton" check-button
  (:superclass toggle-button
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkActionable"
                "GtkActivatable")
   :type-initializer "gtk_check_button_get_type")
  nil)

#+liber-documentation
(setf (documentation 'check-button 'type)
 "@version{#2021-12-23}
  @begin{short}
    A @sym{gtk:check-button} widget places a discrete @class{gtk:toggle-button}
    widget next to a widget, usually a @class{gtk:label} widget.
  @end{short}
  See the @class{gtk:toggle-button} documentation for more information about
  toggle/check buttons. The important \"toggled\" signal is also inherited from
  the @class{gtk:toggle-button} class.

  @image[check-button]{}
  @begin[CSS nodes]{dictionary}
    @begin{pre}
 checkbutton
 ├── check
 ╰── <child>
    @end{pre}
    A @sym{gtk:check-button} widget with indicator, see the
    @fun{gtk:toggle-button-mode} function, has a main CSS node with name
    @code{checkbutton} and a subnode with name @code{check}.
    @begin{pre}
 button.check
 ├── check
 ╰── <child>
    @end{pre}
    A @sym{gtk:check-button} widget without indicator changes the name of its
    main node to @code{button} and adds a @code{.check} style class to it. The
    subnode is invisible in this case.
  @end{dictionary}
  @begin[Style Property Details]{dictionary}
    @begin[code]{table}
      @begin[indicator-size]{entry}
        The @code{indicator-size} style property of type @code{:int} (Read)
        @br{}
        Size of check or radio indicator. @br{}
        @em{Warning:} The @code{indicator-size} style property has been
        deprecated since version 3.20 and should not be used in newly written
        code. Use CSS @code{min-width} and @code{min-height} on the indicator
        node. @br{}
        Allowed values: >= 0 @br{}
        Default value: 16
      @end{entry}
      @begin[indicator-spacing]{entry}
        The @code{indicator-spacing} style property of type @code{:int}
        (Read) @br{}
        Spacing around check or radio indicator. @br{}
        @em{Warning:} The @code{indicator-spacing} style property has been
        deprecated since version 3.20 and should not be used in newly written
        code. Use CSS @code{min-width} and @code{min-height} on the indicator
        node. @br{}
        Allowed values: >= 0 @br{}
        Default value: 2
      @end{entry}
    @end{table}
  @end{dictionary}
  @see-class{gtk:button}
  @see-class{gtk:toggle-button}
  @see-class{gtk:radio-button}")

;;; ----------------------------------------------------------------------------
;;; gtk_check_button_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline check-button-new))

(defun check-button-new ()
 #+liber-documentation
 "@version{#2021-12-23}
  @return{A @class{gtk:check-button} widget.}
  @short{Creates a new check button.}
  @see-class{gtk:check-button}
  @see-function{gtk:check-button-new-with-label}
  @see-function{gtk:check-button-new-with-mnemonic}"
  (make-instance 'check-button))

(export 'check-button-new)

;;; ----------------------------------------------------------------------------
;;; gtk_check_button_new_with_label ()
;;; ----------------------------------------------------------------------------

(declaim (inline check-button-new-with-label))

(defun check-button-new-with-label (label)
 #+liber-documentation
 "@version{#2021-12-23}
  @argument[label]{a string with the text for the check button}
  @return{A @class{gtk:check-button} widget.}
  @begin{short}
    Creates a new check button with a @class{gtk:label} widget to the right
    of it.
  @end{short}
  @see-class{gtk:check-button}
  @see-class{gtk:label}
  @see-function{gtk:check-button-new}
  @see-function{gtk:check-button-new-with-mnemonic}"
  (make-instance 'check-button
                 :label label))

(export 'check-button-new-with-label)

;;; ----------------------------------------------------------------------------
;;; gtk_check_button_new_with_mnemonic ()
;;; ----------------------------------------------------------------------------

;; TODO: Rewrite the implementation in terms of the function make-instance

(defcfun ("gtk_check_button_new_with_mnemonic"
           check-button-new-with-mnemonic)
    (g:object check-button)
#+liber-documentation
 "@version{#2021-12-23}
  @argument[label]{a string with the text of the button, with an underscore in
    front of the mnemonic character}
  @return{A @class{gtk:check-button} widget.}
  @begin{short}
    Creates a new check button widget containing a label.
  @end{short}
  The label will be created using the @fun{gtk:label-new-with-mnemonic}
  function, so underscores in label indicate the mnemonic for the check button.
  @see-class{gtk:check-button}
  @see-function{gtk:check-button-new}
  @see-function{gtk:check-button-new-with-label}
  @see-function{gtk:label-new-with-mnemonic}"
  (label :string))

(export 'check-button-new-with-mnemonic)

;;; --- End of file gtk.check-button.lisp --------------------------------------
