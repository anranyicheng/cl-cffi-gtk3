;;; ----------------------------------------------------------------------------
;;; gtk3.selection.lisp
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
;;; Selections
;;;
;;;     Functions for handling inter-process communication via selections
;;;
;;; Types and Values
;;;
;;;     GtkSelectionData
;;;     GtkTargetFlags                                <-- gtk.drag-and-drop.lisp
;;;     GtkTargetEntry                                     not implemented
;;;     GtkTargetList
;;;     GtkTargetPair                                      not implemented
;;;
;;; Functions
;;;
;;;     gtk_target_entry_new                               not implemented
;;;     gtk_target_entry_copy                              not implemented
;;;     gtk_target_entry_free                              not implemented
;;;
;;;     gtk_target_list_new
;;;     gtk_target_list_ref
;;;     gtk_target_list_unref
;;;     gtk_target_list_add
;;;     gtk_target_list_add_table
;;;     gtk_target_list_add_text_targets
;;;     gtk_target_list_add_image_targets
;;;     gtk_target_list_add_uri_targets
;;;     gtk_target_list_add_rich_text_targets
;;;     gtk_target_list_remove
;;;     gtk_target_list_find
;;;
;;;     gtk_target_table_free
;;;     gtk_target_table_new_from_list
;;;
;;;     gtk_selection_owner_set
;;;     gtk_selection_owner_set_for_display
;;;     gtk_selection_add_target
;;;     gtk_selection_add_targets
;;;     gtk_selection_clear_targets
;;;     gtk_selection_convert
;;;
;;;     gtk_selection_data_set
;;;     gtk_selection_data_set_text
;;;     gtk_selection_data_get_text
;;;     gtk_selection_data_set_pixbuf
;;;     gtk_selection_data_get_pixbuf
;;;     gtk_selection_data_set_uris
;;;     gtk_selection_data_get_uris
;;;     gtk_selection_data_get_targets
;;;     gtk_selection_data_targets_include_image
;;;     gtk_selection_data_targets_include_text
;;;     gtk_selection_data_targets_include_uri
;;;     gtk_selection_data_targets_include_rich_text
;;;     gtk_selection_data_get_selection
;;;     gtk_selection_data_get_data
;;;     gtk_selection_data_get_length
;;;     gtk_selection_data_get_data_with_length
;;;     gtk_selection_data_get_data_type
;;;     gtk_selection_data_get_display
;;;     gtk_selection_data_get_format
;;;     gtk_selection_data_get_target
;;;
;;;     gtk_targets_include_image
;;;     gtk_targets_include_text
;;;     gtk_targets_include_uri
;;;     gtk_targets_include_rich_text
;;;
;;;     gtk_selection_remove_all
;;;     gtk_selection_data_copy
;;;     gtk_selection_data_free
;;;
;;; Object Hierarchy
;;;
;;;     GBoxed
;;;     ├── GtkSelectionData
;;;     ╰── GtkTargetList
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkTargetFlags
;;; ----------------------------------------------------------------------------

(define-g-flags "GtkTargetFlags" target-flags
  (:export t
   :type-initializer "gtk_target_flags_get_type")
  (:none 0)
  (:same-app 1)
  (:same-widget 2)
  (:other-app 4)
  (:other-widget 8))

#+liber-documentation
(setf (liber:alias-for-symbol 'target-flags)
      "GFlags"
      (liber:symbol-documentation 'target-flags)
 "@version{#2021-10-3}
  @begin{short}
    The @sym{gtk:target-flags} flags is used to specify constraints on
    a target entry.
  @end{short}
  @begin{pre}
(define-g-flags \"GtkTargetFlags\" target-flags
  (:export t
   :type-initializer \"gtk_target_flags_get_type\")
  (:same-app 1)
  (:same-widget 2)
  (:other-app 4)
  (:other-widget 8))
  @end{pre}
  @begin[code]{table}
    @entry[:same-app]{If this is set, the target will only be selected for
      drags within a single application.}
    @entry[:same-widget]{If this is set, the target will only be selected for
      drags within a single widget.}
    @entry[:other-app]{If this is set, the target will not be selected for
      drags within a single application.}
    @entry[:other-widget]{If this is set, the target will not be selected for
      drags within a single widget.}
  @end{table}
  @see-class{gtk:target-list}")

;;; ----------------------------------------------------------------------------
;;; struct GtkTargetEntry                                  not implemented
;;;
;;; struct GtkTargetEntry {
;;;   gchar *target;
;;;   guint  flags;
;;;   guint  info;
;;; };
;;;
;;; A GtkTargetEntry represents a single type of data than can be supplied for
;;; by a widget for a selection or for supplied or received during
;;; drag-and-drop.
;;;
;;; gchar *target:
;;;     a string representation of the target type
;;;
;;; guint flags:
;;;     GtkTargetFlags for DND
;;;
;;; guint info:
;;;     an application-assigned integer ID which will get passed as a parameter
;;;     to e.g the "selection-get" signal. It allows the application to identify
;;;     the target type without extensive string compares.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; GtkTargetList
;;; ----------------------------------------------------------------------------

(define-g-boxed-opaque target-list "GtkTargetList"
  :type-initializer "gtk_target_list_get_type"
  :alloc (%target-list-new (cffi:null-pointer) 0))

#+liber-documentation
(setf (liber:alias-for-class 'target-list)
      "GBoxed"
      (documentation 'target-list 'type)
 "@version{2023-1-28}
  @begin{short}
    A @sym{gtk:target-list} structure is used to represent a list of target
    entries.
  @end{short}
  This structure should be treated as opaque.
  @begin{pre}
(define-g-boxed-opaque gtk:target-list \"GtkTargetList\"
  :type-initializer \"gtk_target_list_get_type\"
  :alloc (%gtk:target-list-new (cffi:null-pointer) 0))
  @end{pre}
  A target entry is a list with the following fields. See the
  @fun{gtk:target-list-new} function for an example.
  @begin[code]{table}
    @entry[target]{A string representation of the target type.}
    @entry[flags]{The @symbol{gtk:target-flags} flags for DND.}
    @entry[info]{An application-assigned integer ID which will get passed
      as a parameter to e.g. the \"selection-get\" signal. It allows the
      application to identify the target type without extensive string
      compares.}
  @end{table}
  @see-function{gtk:target-list-new}")

(export 'target-list)

;;; ----------------------------------------------------------------------------
;;; struct GtkTargetPair                                   not implemented
;;;
;;; struct GtkTargetPair {
;;;   GdkAtom   target;
;;;   guint     flags;
;;;   guint     info;
;;; };
;;;
;;; A GtkTargetPair is used to represent the same information as a table of
;;; GtkTargetEntry, but in an efficient form.
;;;
;;; Members
;;;
;;; GdkAtom target;
;;; GdkAtom representation of the target type
;;;
;;; guint flags;
;;; GtkTargetFlags for DND
;;;
;;; guint info;
;;; an application-assigned integer ID which will get passed as a parameter to
;;; e.g the "selection-get" signal. It allows the application to identify the
;;; target type without extensive string compares.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; GtkSelectionData
;;; ----------------------------------------------------------------------------

(define-g-boxed-opaque selection-data "GtkSelectionData"
  :type-initializer "gtk_selection_data_get_type"
  :alloc (error "GtkSelectionData cannot be created from the Lisp side."))

#+liber-documentation
(setf (liber:alias-for-class 'selection-data)
      "GBoxed"
      (documentation 'selection-data 'type)
 "@version{#2021-10-3}
  @begin{short}
    The @sym{gtk:selection-data} structure is used to store a chunk of data
    along with the data type and other associated information.
  @end{short}
  @begin{pre}
(define-g-boxed-opaque gtk:selection-data \"GtkSelectionData\"
  :alloc (error \"GtkSelectionData cannot be created from the Lisp side.\"))
  @end{pre}
  All fields of the @sym{gtk:selection-data} structure are private and can only
  be retrieved with the corresponding accessor functions.
  @begin[code]{table}
    @entry[selection]{A @symbol{gdk:atom-as-string} as a string with the
      selection.}
    @entry[target]{A @symbol{gdk:atom-as-string} as a string with the target of
      the selection.}
    @entry[type]{A @symbol{gdk:atom-as-string} as a string with the data type
      of the selection.}
    @entry[format]{An integer with the format of the selection.}
    @entry[data]{A foreign pointer to the raw data of the selection.}
    @entry[length]{An integer with the length of the data.}
    @entry[display]{A @class{gdk:display} object with the display of the
      selection.}
  @end{table}
  @see-function{gtk:selection-data-selection}
  @see-function{gtk:selection-data-target}
  @see-function{gtk:selection-data-data-type}
  @see-function{gtk:selection-data-format}
  @see-function{gtk:selection-data-data}
  @see-function{gtk:selection-data-length}
  @see-function{gtk:selection-data-display}")

(export 'selection-data)

;;; ----------------------------------------------------------------------------
;;; gtk_target_entry_new ()                                not implemented
;;;
;;; GtkTargetEntry *
;;; gtk_target_entry_new (const gchar *target,
;;;                       guint flags,
;;;                       guint info);
;;;
;;; Makes a new GtkTargetEntry.
;;;
;;; target :
;;;     String identifier for target
;;;
;;; flags :
;;;     Set of flags, see GtkTargetFlags
;;;
;;; info :
;;;     an ID that will be passed back to the application
;;;
;;; Returns :
;;;     a pointer to a new GtkTargetEntry. Free with gtk_target_entry_free()
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_target_entry_copy ()                               not implemented
;;;
;;; GtkTargetEntry *
;;; gtk_target_entry_copy (GtkTargetEntry *data);
;;;
;;; Makes a copy of a GtkTargetEntry and its data.
;;;
;;; data :
;;;     a pointer to a GtkTargetEntry
;;;
;;; Returns :
;;;     a pointer to a copy of data . Free with gtk_target_entry_free()
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_target_entry_free ()                               not implemented
;;;
;;; void
;;; gtk_target_entry_free (GtkTargetEntry *data);
;;;
;;; Frees a GtkTargetEntry returned from gtk_target_entry_new() or
;;; gtk_target_entry_copy().
;;;
;;; data :
;;;     a pointer to a GtkTargetEntry.
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_new ()
;;; ----------------------------------------------------------------------------

(defcstruct %target-entry
  (target :string)
  (flags target-flags)
  (info :uint))

(defcfun ("gtk_target_list_new" %target-list-new) (g:boxed target-list :return)
  (targets :pointer)
  (n-targets :uint))

(defun target-list-new (&optional (targets nil))
 #+liber-documentation
 "@version{2023-1-28}
  @argument[targets]{a list of target entries}
  @return{The new @class{gtk:target-list} instance.}
  @begin{short}
    Creates a new @class{gtk:target-list} instance from a list of target
    entries.
  @end{short}
  @begin[Examples]{dictionary}
    @begin{pre}
(let ((tlist (gtk:target-list-new '((\"text/html\" :none 0)
                                    (\"STRING\" :none 1)
                                    (\"number\" :none 2)
                                    (\"image/jpeg\" :none 3)
                                    (\"text/uri-list\" :none 4)))))
  ... )
    @end{pre}
  @end{dictionary}
  @see-class{gtk:target-list}"
  (let ((n-targets (length targets)))
    (with-foreign-object (targets-ptr '(:struct %target-entry) n-targets)
      (loop for i from 0 below n-targets
            for target-ptr = (cffi:mem-aptr targets-ptr
                                            '(:struct %target-entry) i)
            for entry in targets
            do (with-foreign-slots ((target flags info)
                                    target-ptr
                                    (:struct %target-entry))
                 (setf target (first entry))
                 (setf flags (second entry))
                 (setf info (third entry))))
      (%target-list-new targets-ptr n-targets))))

(export 'target-list-new)

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_ref ()                                 not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_ref" target-list-ref)
    (g:boxed target-list)
 #+liber-documentation
 "@version{#2013-11-21}
  @argument[target-list]{a @class{gtk:target-list}}
  @return{The passed in @class{gtk:target-list}.}
  Increases the reference count of a @class{gtk:target-list} by one.
  @see-class{gtk:target-list}"
  (target-list (g:boxed target-list)))

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_unref ()                               not exported
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_unref" target-list-unref) :void
 #+liber-documentation
 "@version{#2013-11-21}
  @argument[list]{a @class{gtk:target-list}}
  @begin{short}
    Decreases the reference count of a @class{gtk:target-list} by one.
  @end{short}
  If the resulting reference count is zero, frees the list.
  @see-class{gtk:target-list-unref}"
  (target-list (g:boxed target-list)))

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_add ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_add" target-list-add) :void
 #+liber-documentation
 "@version{2023-1-28}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @argument[target]{a @symbol{gdk:atom-as-string} as a string for the interned
    atom representing the target}
  @argument[flags]{the @symbol{gtk:target-flags} flags for this target}
  @argument[info]{an unsigned integer ID that will be passed back to the
    application}
  @begin{short}
    Appends another target entry to a target list.
  @end{short}
  @see-class{gtk:target-list}
  @see-symbol{gtk:target-flags}"
  (tlist (g:boxed target-list))
  (target gdk:atom-as-string)
  (flags target-flags)
  (info :uint))

(export 'target-list-add)

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_add_table ()
;;; ----------------------------------------------------------------------------

;; TODO: Consider to change the name. This function adds a Lisp list of
;; targets to the target list.

(defcfun ("gtk_target_list_add_table" %target-list-add-table) :void
  (tlist (g:boxed target-list))
  (targets :pointer)
  (n-targets :uint))

(defun target-list-add-table (tlist targets)
 #+liber-documentation
 "@version{2023-1-28}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @argument[targets]{a list of target entries}
  @begin{short}
    Prepends a list of target entries to a target list.
  @end{short}
  @see-class{gtk:target-list}"
  (mapcar #'(lambda (x) (apply #'target-list-add tlist x)) targets))

(export 'target-list-add-table)

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_add_text_targets ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_add_text_targets" target-list-add-text-targets) :void
 #+liber-documentation
 "@version{2023-1-28}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @argument[info]{an unsigned integer ID that will be passed back to the
    application}
  @begin{short}
    Appends the text targets supported by a selection to the target list.
  @end{short}
  All targets are added with the same info.
  @see-class{gtk:target-list}"
  (tlist (g:boxed target-list))
  (info :uint))

(export 'target-list-add-text-targets)

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_add_image_targets ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_add_image_targets" target-list-add-image-targets)
    :void
 #+liber-documentation
 "@version{2023-1-28}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @argument[info]{an unsigned integer ID that will be passed back to the
    application}
  @argument[writable]{a boolean whether to add only targets for which GTK knows
    how to convert a pixbuf into the format}
  @begin{short}
    Appends the image targets supported by a selection to the target list.
  @end{short}
  All targets are added with the same info.
  @see-class{gtk:target-list}"
  (tlist (g:boxed target-list))
  (info :uint)
  (writeable :boolean))

(export 'target-list-add-image-targets)

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_add_uri_targets ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_add_uri_targets" target-list-add-uri-targets) :void
 #+liber-documentation
 "@version{2023-1-28}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @argument[info]{an unsigned integer ID that will be passed back to the
    application}
  @begin{short}
    Appends the URI targets supported by a selection to the target list.
  @end{short}
  All targets are added with the same info.
  @see-class{gtk:target-list}"
  (tlist (g:boxed target-list))
  (info :uint))

(export 'target-list-add-uri-targets)

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_add_rich_text_targets ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_add_rich_text_targets"
           target-list-add-rich-text-targets) :void
 #+liber-documentation
 "@version{2023-1-28}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @argument[info]{an unsigned integer ID that will be passed back to the
    application}
  @argument[deserializable]{if @em{true}, then deserializable rich text formats
    will be added, serializable formats otherwise}
  @argument[buffer]{a @class{gtk:text-buffer} object}
  @begin{short}
    Appends the rich text targets registered with the
    @fun{gtk:text-buffer-register-serialize-format} or
    @fun{gtk:text-buffer-register-deserialize-format} functions to the target
    list.
  @end{short}
  All targets are added with the same info.
  @see-class{gtk:target-list}
  @see-class{gtk:text-buffer}
  @see-function{gtk:text-buffer-register-serialize-format}
  @see-function{gtk:text-buffer-register-deserialize-format}"
  (tlist (g:boxed target-list))
  (info :uint)
  (deserializable :boolean)
  (buffer (g:object text-buffer)))

(export 'target-list-add-rich-text-targets)

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_remove ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_remove" target-list-remove) :void
 #+liber-documentation
 "@version{2023-1-27}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @argument[target]{a @symbol{gdk:atom-as-string} as a string with for the
    interned atom representing the target}
  @begin{short}
    Removes a target from a target list.
  @end{short}
  @see-class{gtk:target-list}"
  (tlist (g:boxed target-list))
  (target gdk:atom-as-string))

(export 'target-list-remove)

;;; ----------------------------------------------------------------------------
;;; gtk_target_list_find ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_target_list_find" %target-list-find) :boolean
  (tlist (g:boxed target-list))
  (target gdk:atom-as-string)
  (info :pointer))

(defun target-list-find (tlist target)
 #+liber-documentation
 "@version{2023-1-28}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @argument[target]{a @symbol{gdk:atom-as-string} as a string with the interned
    atom representing the target to search for}
  @begin{return}
    Application info as an unsigned integer for @arg{target}, or @code{nil}.
  @end{return}
  @begin{short}
    Looks up a given target in a target list.
  @end{short}
  @see-class{gtk:target-list}
  @see-symbol{gdk:atom-as-string}"
  (with-foreign-object (info :uint)
    (when (%target-list-find tlist target info)
      (cffi:mem-ref info :uint))))

(export 'target-list-find)

;;; ----------------------------------------------------------------------------
;;; gtk_target_table_free ()
;;;
;;; void gtk_target_table_free (GtkTargetEntry *targets, gint n_targets);
;;;
;;; This function frees a target table as returned by
;;; gtk_target_table_new_from_list()
;;;
;;; targets :
;;;     a GtkTargetEntry array
;;;
;;; n_targets :
;;;     the number of entries in the array
;;;
;;; Since 2.10
;;; ----------------------------------------------------------------------------

;;; ----------------------------------------------------------------------------
;;; gtk_target_table_new_from_list ()
;;; ----------------------------------------------------------------------------

;; TODO: Consider to change the name of the implementation. This function
;; does not create a new instance, but returns the target list as a Lisp list.

(defcfun ("gtk_target_table_new_from_list" %target-table-new-from-list)
    :pointer
  (tlist (g:boxed target-list))
  (n-targets (:pointer :int)))

(defun target-table-new-from-list (tlist)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[tlist]{a @class{gtk:target-list} instance}
  @return{A list of target entries.}
  @begin{short}
    This function creates a list of target entries that contains the same
    targets as the passed @arg{tlist} argument.
  @end{short}
  @see-class{gtk:target-list}"
  (with-foreign-object (n-targets :int)
    (let* ((targets (%target-table-new-from-list tlist n-targets))
           (n (cffi:mem-ref n-targets :int)))
      (prog1
        (loop for i from 0 below n
              for target-ptr = (cffi:mem-aptr targets '(:struct %target-entry) i)
              collect (with-foreign-slots ((target flags info)
                                           target-ptr
                                           (:struct %target-entry))
                        (list target flags info)))
        (g:free targets)))))

(export 'target-table-new-from-list)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_owner_set ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_owner_set" selection-owner-set) :boolean
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[widget]{a @class{gtk:widget} object, or @code{nil}}
  @argument[selection]{a @symbol{gdk:atom-as-string} as a string with a setting
    representing the selection to claim}
  @argument[time]{an unsigned integer with the timestamp with which to claim
    the selection}
  @return{@em{True} if the operation succeeded.}
  @begin{short}
    Claims ownership of a given selection for a particular widget, or, if
    the @arg{widget} argument is @code{nil}, release ownership of the selection.
  @end{short}
  @see-class{gtk:widget}
  @see-symbol{gdk:atom-as-string}
  @see-function{gtk:selection-owner-set-for-display}"
  (widget (g:object widget))
  (selection gdk:atom-as-string)
  (time :uint))

(export 'selection-owner-set)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_owner_set_for_display ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_owner_set_for_display"
           selection-owner-set-for-display) :boolean
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[display]{the @class{gdk:display} object where the selection is set}
  @argument[widget]{new selection owner, a @class{gtk:widget} object,
    or @code{nil}}
  @argument[selection]{a @symbol{gdk:atom-as-string} as a string representing
    the selection to claim}
  @argument[time]{an unsigned integer with the timestamp with which to claim
    the selection}
  @return{@em{True} if the operation succeeded.}
  @begin{short}
    Claim ownership of a given selection for a particular widget, or, if
    the @arg{widget} argument is @code{nil}, release ownership of the selection.
  @end{short}
  @see-class{gdk:display}
  @see-class{gtk:widget}
  @see-symbol{gdk:atom-as-string}
  @see-function{gtk:selection-owner-set}"
  (display (g:object gdk:display))
  (widget (g:object widget))
  (selection gdk:atom-as-string)
  (time :uint))

(export 'selection-owner-set-for-display)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_add_target ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_add_target" selection-add-target) :void
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[widget]{a @class{gtk:widget} object}
  @argument[selection]{a @symbol{gdk:atom-as-string} as a string with the
    selection}
  @argument[target]{a @symbol{gdk:atom-as-string} as a string with the target
    to add}
  @argument[info]{a unsigned integer which will be passed back to the
    application}
  @begin{short}
    Appends a specified target to the list of supported targets for a given
    widget and selection.
  @end{short}
  @see-class{gtk:widget}
  @see-symbol{gdk:atom-as-string}
  @see-function{gtk:selection-add-targets}"
  (widget (g:object widget))
  (selection gdk:atom-as-string)
  (target gdk:atom-as-string)
  (info :uint))

(export 'selection-add-target)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_add_targets ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_add_targets" %selection-add-targets) :void
  (widget (g:object widget))
  (selection gdk:atom-as-string)
  (targets :pointer)
  (n-targets :uint))

(defun selection-add-targets (widget selection targets)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[widget]{a @class{gtk:widget} object}
  @argument[selection]{a @symbol{gdk:atom-as-string} as a string with the
    selection}
  @argument[targets]{a list of target entries to add}
  @begin{short}
    Prepends a table of targets to the list of supported targets for a given
    widget and selection.
  @end{short}
  @see-class{gtk:widget}
  @see-symbol{gdk:atom-as-string}"
  (mapcar #'(lambda (x)
              (apply #'selection-add-target widget selection x))
              targets))

(export 'selection-add-targets)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_clear_targets ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_clear_targets" selection-clear-targets) :void
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[widget]{a @class{gtk:widget} object}
  @argument[selection]{a @symbol{gdk:atom-as-string} as a string representing a
    selection}
  @begin{short}
    Remove all targets registered for the given selection for the widget.
  @end{short}
  @see-class{gtk:widget}
  @see-symbol{gdk:atom-as-string}"
  (widget (g:object widget))
  (selection gdk:atom-as-string))

(export 'selection-clear-targets)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_convert ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_convert" selection-convert) :boolean
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[widget]{the @class{gtk:widget} object which acts as requestor}
  @argument[selection]{a @symbol{gdk:atom-as-string} as a string which selection
    to get}
  @argument[target]{a @symbol{gdk:atom-as-string} as a string with the form of
    information desired}
  @argument[time]{an unsigned integer with the time of request, usually of
    triggering event, in emergency, you could use the @var{+gdk-current-time+}
    value}
  @begin{return}
    @em{True} if requested succeeded, @em{false} if we could not process
    request, e.g., there was already a request in process for this widget.
  @end{return}
  @begin{short}
    Requests the contents of a selection.
  @end{short}
  When received, a \"selection-received\" signal will be generated.
  @see-class{gtk:widget}
  @see-symbol{gdk:atom-as-string}
  @see-variable{+gdk-current-time+}"
  (widget (g:object widget))
  (selection gdk:atom-as-string)
  (target gdk:atom-as-string)
  (time :uint))

(export 'selection-convert)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_set ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_set" selection-data-set) :void
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @argument[type]{a @symbol{gdk:atom-as-string} as a string with the type of
    selection data}
  @argument[format]{an integer with the format, number of bits in a unit}
  @argument[data]{a pointer to the data, will be copied}
  @argument[length]{an integer with the length of the data}
  @begin{short}
    Stores new data into a @class{gtk:selection-data} instance.
  @end{short}
  Should only be called from a selection handler callback. Zero-terminates
  the stored data.
  @see-class{gtk:selection-data}
  @see-symbol{gdk:atom-as-string}"
  (selection (g:boxed selection-data))
  (type gdk:atom-as-string)
  (format :int)
  (data :pointer)
  (length :int))

(export 'selection-data-set)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_text ()
;;; gtk_selection_data_set_text () -> selection-data-text
;;; ----------------------------------------------------------------------------

(defun (setf selection-data-text) (text selection)
  (when (cffi:foreign-funcall "gtk_selection_data_set_text"
                         (g:boxed selection-data) selection
                         :string text
                         :int -1
                         :boolean)
    text))

(defcfun ("gtk_selection_data_get_text" selection-data-text) :string
 #+liber-documentation
 "@version{#2021-10-3}
  @syntax[]{(gtk:selection-data-text selection) => text}
  @syntax[]{(setf (gtk:selection-data-text selection) text)}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @argument[text]{a UTF-8 string}
  @begin{short}
    The @sym{gtk:selection-data-text} function gets the contents of the
    selection data as a UTF-8 string.
  @end{short}
  The @sym{(setf gtk:selection-data-text)} function sets the contents of the
  selection. The string is converted to the form determined by the target
  of the selection.
  @see-class{gtk:selection-data}"
  (selection (g:boxed selection-data)))

(export 'selection-data-text)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_pixbuf ()
;;; gtk_selection_data_set_pixbuf () -> selection-data-pixbuf
;;; ----------------------------------------------------------------------------

(defun (setf selection-data-pixbuf) (pixbuf selection)
  (when (cffi:foreign-funcall "gtk_selection_data_set_pixbuf"
                         (g:boxed selection-data) selection
                         (g:object gdk:pixbuf :free-to-foreign nil) pixbuf
                         :boolean)
    pixbuf))

(defcfun ("gtk_selection_data_get_pixbuf" selection-data-pixbuf)
    (g:object gdk:pixbuf :free-from-foreign t)
 #+liber-documentation
 "@version{#2021-10-3}
  @syntax[]{(gtk:selection-data-pixbuf selection) => pixbuf}
  @syntax[]{(setf (gtk:selection-data-pixbuf selection) pixbuf)}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @argument[pixbuf]{a @class{gdk:pixbuf} object}
  @begin{short}
    The @sym{gtk:selection-data-pixbuf} function gets the contents of the
    selection data as a @class{gdk:pixbuf} object.
  @end{short}
  The @sym{(setf gtk:selection-data-pixbuf)} function sets the contents of the
  selection. The pixbuf is converted to the form determined by the target of
  the selection.
  @see-class{gtk:selection-data}
  @see-class{gdk:pixbuf}"
  (selection (g:boxed selection-data)))

(export 'selection-data-pixbuf)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_uris ()
;;; gtk_selection_data_set_uris () -> selection-data-uris
;;; ----------------------------------------------------------------------------

(defun (setf selection-data-uris) (uris selection)
  (when (cffi:foreign-funcall "gtk_selection_data_set_uris"
                              (g:boxed selection-data) selection
                              g:strv-t uris
                              :boolean)
    uris))

(defcfun ("gtk_selection_data_get_uris" selection-data-uris) g:strv-t
 #+liber-documentation
 "@version{#2021-10-3}
  @syntax[]{(gtk:selection-data-uris selection) => uris}
  @syntax[]{(setf (gtk:selection-data-uris selection) uris)}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @argument[uris]{a list of strings holding URIs}
  @begin{short}
    The @sym{gtk:selection-data-uris} function gets the contents of the
    selection data as a list of URIs.
  @end{short}
  The @sym{(setf gtk:selection-data-uris)} function sets the contents of the
  selection. The string is converted to the form determined by the target
  of the selection.
  @see-class{gtk:selection-data}"
  (selection (g:boxed selection-data)))

(export 'selection-data-uris)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_targets () -> selection-data-targets
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_targets" %selection-data-targets) :boolean
  (selection (g:boxed selection-data))
  (targets (:pointer gdk:atom-as-string))
  (n-atoms (:pointer :int)))

(defun selection-data-targets (selection)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @return{A list of @symbol{gdk:atom-as-string} targets as strings.}
  @begin{short}
    Gets the contents of the selection as a list of targets.
  @end{short}
  This can be used to interpret the results of getting the standard \"TARGETS\"
  target that is always supplied for any selection.
  @see-class{gtk:selection-data}
  @see-symbol{gdk:atom-as-string}"
  (with-foreign-objects ((targets-ptr :pointer) (n-atoms :int))
    (when (%selection-data-targets selection targets-ptr n-atoms)
      (let ((result nil))
        (loop for i from 0 below (cffi:mem-ref n-atoms :int)
              do (push (cffi:mem-aref targets-ptr 'gdk:atom-as-string i) result))
        (nreverse result)))))

(export 'selection-data-targets)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_targets_include_image ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_targets_include_image"
           selection-data-targets-include-image) :boolean
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @argument[writable]{a boolean whether to accept only targets for which GTK
    knows how to convert a pixbuf into the format}
  @begin{return}
    @em{True} if the @arg{selection} argument holds a list of targets, and a
    suitable target for images is included, otherwise @em{false}.
  @end{return}
  @begin{short}
    Given a @class{gtk:selection-data} instance holding a list of targets,
    determines if any of the targets can be used to provide a @class{gdk:pixbuf}
    object.
  @end{short}
  @see-class{gtk:selection-data}
  @see-class{gdk:pixbuf}"
  (selection (g:boxed selection-data))
  (writeable :boolean))

(export 'selection-data-targets-include-image)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_targets_include_text ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_targets_include_text"
           selection-data-targets-include-text) :boolean
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @begin{return}
    @em{True} if the @arg{selection} argument holds a list of targets, and a
    suitable target for text is included, otherwise @em{false}.
  @end{return}
  @begin{short}
    Given a @class{gtk:selection-data} instance holding a list of targets,
    determines if any of the targets can be used to provide text.
  @end{short}
  @see-class{gtk:selection-data}"
  (selection (g:boxed selection-data)))

(export 'selection-data-targets-include-text)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_targets_include_uri ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_targets_include_uri"
           selection-data-targets-include-uri) :boolean
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @begin{return}
    @em{True} if the @arg{selection} argument holds a list of targets, and a
    suitable target for URI lists is included, otherwise @em{false}.
  @end{return}
  @begin{short}
    Given a @class{gtk:selection-data} instance holding a list of targets,
    determines if any of the targets can be used to provide a list
    or URIs.
  @end{short}
  @see-class{gtk:selection-data}"
  (selection (g:boxed selection-data)))

(export 'selection-data-targets-include-uri)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_targets_include_rich_text ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_targets_include_rich_text"
           selection-data-targets-include-rich-text) :boolean
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @argument[buffer]{a @class{gtk:text-buffer} object}
  @begin{return}
    @em{True} if the @arg{selection} argument holds a list of targets, and a
    suitable target for rich text is included, otherwise @em{false}.
  @end{return}
  @begin{short}
    Given a @class{gtk:selection-data} instance holding a list of targets,
    determines if any of the targets can be used to provide rich text.
  @end{short}
  @see-class{gtk:selection-data}
  @see-class{gtk:text-buffer}"
  (selection (g:boxed selection-data))
  (buffer (g:object text-buffer)))

(export 'selection-data-targets-include-rich-text)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_selection ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_selection" selection-data-selection)
    gdk:atom-as-string
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[data]{a @class{gtk:selection-data} instance}
  @return{A @symbol{gdk:atom-as-string} as a string with the selection.}
  @begin{short}
    Retrieves the selection of the selection data.
  @end{short}
  @see-class{gtk:selection-data}
  @see-symbol{gdk:atom-as-string}"
  (data (g:boxed selection-data)))

(export 'selection-data-selection)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_data ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_data" selection-data-data)
    (:pointer :uchar)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[data]{a @class{gtk:selection-data} instance}
  @return{A pointer to the raw data.}
  @begin{short}
    Retrieves the raw data of the selection.
  @end{short}
  @see-class{gtk:selection-data}"
  (data (g:boxed selection-data)))

(export 'selection-data-data)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_length ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_length" selection-data-length) :int
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[data]{a @class{gtk:selection-data} instance}
  @return{An integer with the length of the data.}
  @begin{short}
    The length of the data of the selection.
  @end{short}
  @see-class{gtk:selection-data}"
  (data (g:boxed selection-data)))

(export 'selection-data-length)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_data_with_length ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_data_with_length"
          %selection-data-data-with-length) :pointer
  (selection (g:boxed selection-data))
  (length (:pointer :int)))

(defun selection-data-data-with-length (selection)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[selection]{a @class{gtk:selection-data} instance}
  @begin{return}
    @code{length} -- an integer with the length of the data segment @br{}
    @code{data} -- a pointer to the raw data of the selection, see the
    @fun{gtk:selection-data-data} function
  @end{return}
  @begin{short}
    Retrieves the raw data of the selection along with its length.
  @end{short}
  @see-class{gtk:selection-data}
  @see-function{gtk:selection-data-data}"
  (with-foreign-object (length-ptr :int)
    (let ((data (%selection-data-data-with-length selection length-ptr)))
      (let ((length (cffi:mem-ref length-ptr :int)))
        (if (> length 0)
            (values length data)
            (values length nil))))))

(export 'selection-data-data-with-length)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_data_type ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_data_type" selection-data-data-type)
    gdk:atom-as-string
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[data]{a @class{gtk:selection-data} instance}
  @return{A @symbol{gdk:atom-as-string} as a string with the type of the
    selection.}
  @begin{short}
    Retrieves the data type of the selection.
  @end{short}
  @see-class{gtk:selection-data}"
  (data (g:boxed selection-data)))

(export 'selection-data-data-type)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_display ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_display" selection-data-display)
    (g:object gdk:display)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[data]{a @class{gtk:selection-data} instance}
  @return{A @class{gdk:display} object.}
  @begin{short}
    The display of the selection.
  @end{short}
  @see-class{gtk:selection-data}
  @see-class{gdk:display}"
  (data (g:boxed selection-data)))

(export 'selection-data-display)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_format ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_format" selection-data-format) :int
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[data]{a @class{gtk:selection-data} instance}
  @return{An integer with the format.}
  @begin{short}
    Retrieves the format of the selection.
  @end{short}
  @see-class{gtk:selection-data}"
  (data (g:boxed selection-data)))

(export 'selection-data-format)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_get_target ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_get_target" selection-data-target)
    gdk:atom-as-string
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[data]{a @class{gtk:selection-data} instance}
  @return{A @symbol{gdk:atom-as-string} as a string with the target.}
  @begin{short}
    The target of the selection.
  @end{short}
  @see-class{gtk:selection-data}"
  (data (g:boxed selection-data)))

(export 'selection-data-target)

;;; ----------------------------------------------------------------------------
;;; gtk_targets_include_image ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_targets_include_image" %targets-include-image) :boolean
  (targets :pointer)
  (n-targets :int)
  (writable :boolean))

(defun targets-include-image (targets writable)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[targets]{a list of @symbol{gdk:atom-as-string} as strings}
  @argument[writable]{a boolean whether to accept only targets for which GTK
    knows how to convert a pixbuf into the format}
  @return{@em{True} if the @arg{targets} argument include a suitable target for
    images, otherwise @em{false}.}
  @begin{short}
    Determines if any of the targets in the @arg{targets} argument can be used
    to provide a @class{gdk:pixbuf} object.
  @end{short}
  @see-class{gdk:atom-as-string}
  @see-class{gdk:pixbuf}"
  (let ((n-targets (length targets)))
    (with-foreign-object (targets-ar :pointer n-targets)
      (loop for i from 0 below n-targets
            for target in targets
            do (setf (cffi:mem-aref targets-ar 'gdk:atom-as-string i) target))
      (%targets-include-image targets-ar n-targets writable))))

(export 'targets-include-image)

;;; ----------------------------------------------------------------------------
;;; gtk_targets_include_text ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_targets_include_text" %targets-include-text) :boolean
  (targets :pointer)
  (n-targets :int))

(defun targets-include-text (targets)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[targets]{a list of @symbol{gdk:atom-as-string} as strings}
  @return{@em{True} if the @arg{targets} argument include a suitable target for
    text, otherwise @em{false}.}
  @begin{short}
    Determines if any of the targets in the @arg{targets} argument can be used
    to provide text.
  @end{short}
  @see-class{gdk:atom-as-string}"
  (let ((n-targets (length targets)))
    (with-foreign-object (targets-ar :pointer n-targets)
      (loop for i from 0 below n-targets
            for target in targets
            do (setf (cffi:mem-aref targets-ar 'gdk:atom-as-string i) target))
      (%targets-include-text targets-ar n-targets))))

(export 'targets-include-text)

;;; ----------------------------------------------------------------------------
;;; gtk_targets_include_uri ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_targets_include_uri" %targets-include-uri) :boolean
  (targets :pointer)
  (n-targets :int))

(defun targets-include-uri (targets)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[targets]{a list of @symbol{gdk:atom-as-string} as strings}
  @return{@em{True} if the @arg{targets} arguments include a suitable target
    for URI lists, otherwise @em{false}.}
  @begin{short}
    Determines if any of the targets in the @arg{targets} argument can be used
    to provide an URI list.
  @end{short}
  @see-class{gdk:atom-as-string}"
  (let ((n-targets (length targets)))
    (with-foreign-object (targets-ar :pointer n-targets)
      (loop for i from 0 below n-targets
            for target in targets
            do (setf (cffi:mem-aref targets-ar 'gdk:atom-as-string i) target))
      (%targets-include-uri targets-ar n-targets))))

(export 'targets-include-uri)

;;; ----------------------------------------------------------------------------
;;; gtk_targets_include_rich_text ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_targets_include_rich_text" %targets-include-rich-text)
    :boolean
  (targets :pointer)
  (n-targets :int)
  (buffer (g:object text-buffer)))

(defun targets-include-rich-text (targets buffer)
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[targets]{a list of @symbol{gdk:atom-as-string} as strings}
  @argument[buffer]{a @class{gtk:text-buffer} object}
  @return{@em{True} if the @arg{targets} argument include a suitable target for
    rich text, otherwise @em{false}.}
  @begin{short}
    Determines if any of the targets in the @arg{targets} argument can be used
    to provide rich text.
  @end{short}
  @see-class{gdk:atom-as-string}
  @see-class{gtk:text-buffer}"
  (let ((n-targets (length targets)))
    (with-foreign-object (targets-ar :pointer n-targets)
      (loop for i from 0 below n-targets
            for target in targets
            do (setf (cffi:mem-aref targets-ar 'gdk:atom-as-string i) target))
      (%targets-include-rich-text targets-ar n-targets buffer))))

(export 'targets-include-rich-text)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_remove_all ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_remove_all" selection-remove-all) :void
 #+liber-documentation
 "@version{#2021-10-3}
  @argument[widget]{a @class{gtk:widget} object}
  @begin{short}
    Removes all handlers and unsets ownership of all selections for a widget.
  @end{short}
  Called when the widget is being destroyed. This function will not generally
  be called by applications.
  @see-class{gtk:selection-data}
  @see-class{gtk:widget}"
  (widget (g:object widget)))

(export 'selection-remove-all)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_copy ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_selection_data_copy" selection-data-copy)
    (g:boxed selection-data :return)
 #+liber-documentation
 "@version{#2023-1-28}
  @argument[data]{a @class{gtk:selection-data} instance}
  @begin{short}
    Copies a @class{gtk:selection-data} instance.
  @end{short}
  @see-class{gtk:selection-data}"
  (data (g:boxed selection-data)))

(export 'selection-data-copy)

;;; ----------------------------------------------------------------------------
;;; gtk_selection_data_free ()
;;;
;;; void gtk_selection_data_free (GtkSelectionData *data);
;;;
;;; Frees a GtkSelectionData structure returned from gtk_selection_data_copy().
;;;
;;; data :
;;;     a pointer to a GtkSelectionData structure.
;;; ----------------------------------------------------------------------------

;;; --- End of file gtk3.selections.lisp ---------------------------------------
