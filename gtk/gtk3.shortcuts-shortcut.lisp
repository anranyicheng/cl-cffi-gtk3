;;; ----------------------------------------------------------------------------
;;; gtk3.shortcuts-shortcut.lisp
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
;;; GtkShortcutsShortcut
;;;
;;;     Represents a keyboard shortcut in a GtkShortcutsWindow
;;;
;;; Types and Values
;;;
;;;     GtkShortcutsShortcut
;;;     GtkShortcutType
;;;
;;; Properties
;;;
;;;     accel-size-group
;;;     accelerator
;;;     action-name
;;;     direction
;;;     icon
;;;     icon-set
;;;     shortcut-type
;;;     subtitle
;;;     subtitle-set
;;;     title
;;;     title-size-group
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkContainer
;;;                 ╰── GtkBox
;;;                     ╰── GtkShortcutsShortcut
;;;
;;; Implemented Interfaces
;;;
;;;     GtkShortcutsShortcut implements AtkImplementorIface, GtkBuildable and
;;;     GtkOrientable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkShortcutType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkShortcutType" shortcut-type
  (:export t
   :type-initializer "gtk_shortcut_type_get_type")
  :accelerator
  :gesture-pinch
  :gesture-stretch
  :gesture-rotate-clockwise
  :gesture-rotate-conterclockwise
  :gesture-two-finger-swipe-left
  :gesture-two-finger-swipe-right
  :gesture)

#+liber-documentation
(setf (liber:alias-for-symbol 'shortcut-type)
      "GEnum"
      (liber:symbol-documentation 'shortcut-type)
 "@version{#2023-2-28}
  @begin{short}
    The @sym{gtk:shortcut-type} enumeration specifies the kind of shortcut that 
    is being described.
  @end{short}
  More values may be added to this enumeration over time. Since 3.20
  @begin{pre}
(define-g-enum \"GtkShortcutType\" shortcut-type
  (:export t
   :type-initializer \"gtk_shortcut_type_get_type\")
  :accelerator
  :gesture-pinch
  :gesture-stretch
  :gesture-rotate-clockwise
  :gesture-rotate-conterclockwise
  :gesture-two-finger-swipe-left
  :gesture-two-finger-swipe-right
  :gesture)
  @end{pre}
  @begin[code]{table}
    @entry[:accelerator]{The shortcut is a keyboard accelerator. The
      @code{accelerator} property will be used.}
    @entry[:gesture-pinch]{The shortcut is a pinch gesture. GTK provides an
      icon and subtitle.}
    @entry[:gesture-stretch]{The shortcut is a stretch gesture. GTK provides an
      icon and subtitle.}
    @entry[:gesture-rotate-clockwise]{The shortcut is a clockwise rotation
      gesture. GTK provides an icon and subtitle.}
    @entry[:gesture-rotate-counter-clockwise]{The shortcut is a counterclockwise
      rotation gesture. GTK provides an icon and subtitle.}
    @entry[:gesture-two-finger-swipe-left]{The shortcut is a two-finger swipe
      gesture. GTK provides an icon and subtitle.}
    @entry[:gesture-two-finger-swipe-right]{The shortcut is a two-finger swipe
      gesture. GTK provides an icon and subtitle.}
    @entry[:gesture]{The shortcut is a gesture. The @code{icon} property will
      be used.}
  @end{table}
  @see-class{gtk:shortcuts-shortcut}")

;;; ----------------------------------------------------------------------------
;;; struct GtkShortcutsShortcut
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkShortcutsShortcut" shortcuts-shortcut
  (:superclass box
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable"
                "GtkOrientable")
   :type-initializer "gtk_shortcuts_shortcut_get_type")
  ((accel-size-group
    shortcuts-shortcut-accel-size-group
    "accel-size-group" "GtkSizeGroup" nil t)
   (accelerator
    shortcuts-shortcut-accelerator
    "accelerator" "gchararray" t t)
   #+gtk-3-22
   (action-name
    shortcuts-shortcut-action-name
    "action-name" "gchararray" t t)
   (direction
    shortcuts-shortcut-direction
    "direction" "GtkTextDirection" t t)
   (icon
    shortcuts-shortcut-icon
    "icon" "GIcon" t t)
   (icon-set
    shortcuts-shortcut-icon-set
    "icon-set" "gboolean" t t)
   (shortcut-type
    shortcuts-shortcut-shortcut-type
    "shortcut-type" "GtkShortcutType" t t)
   (subtitle
    shortcuts-shortcut-subtitle
    "subtitle" "gchararray" t t)
   (subtitle-set
    shortcuts-shortcut-subtitle-set
    "subtitle-set" "gboolean" t t)
   (title
    shortcuts-shortcut-title
    "title" "gchararray" t t)
   (title-size-group
    shortcuts-shortcut-title-size-group
    "title-size-group" "GtkSizeGroup" nil t)))

#+liber-documentation
(setf (documentation 'shortcuts-shortcut 'type)
 "@version{#2023-2-28}
  @begin{short}
    A @sym{gtk:shortcuts-shortcut} widget represents a single keyboard shortcut 
    or gesture with a short text.
  @end{short}
  This widget is only meant to be used with the @class{gtk:shortcuts-window}
  widget.
  @see-slot{gtk:shortcuts-shortcut-accel-size-group}
  @see-slot{gtk:shortcuts-shortcut-accelerator}
  @see-slot{gtk:shortcuts-shortcut-action-name}
  @see-slot{gtk:shortcuts-shortcut-direction}
  @see-slot{gtk:shortcuts-shortcut-icon}
  @see-slot{gtk:shortcuts-shortcut-icon-set}
  @see-slot{gtk:shortcuts-shortcut-shortcut-type}
  @see-slot{gtk:shortcuts-shortcut-subtitle}
  @see-slot{gtk:shortcuts-shortcut-subtitle-set}
  @see-slot{gtk:shortcuts-shortcut-title}
  @see-slot{gtk:shortcuts-shortcut-title-size-group}
  @see-class{gtk:shortcuts-window}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- shortcuts-shortcut-accel-size-group ------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "accel-size-group"
                      'shortcuts-shortcut) t)
 "The @code{accel-size-group} property of type @class{gtk:size-group} (Write)
  @br{}
  The size group for the accelerator portion of this shortcut. This is used
  internally by GTK, and must not be modified by applications.")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-accel-size-group)
      "Accessor"
      (documentation 'shortcuts-shortcut-accel-size-group 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-accel-size-group object) => group}
  @syntax[]{(setf (gtk:shortcuts-shortcut-accel-size-group object) group)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[group]{a @class{gtk:size-group} object}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{accel-size-group} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  The size group for the accelerator portion of this shortcut. This is used
  internally by GTK, and must not be modified by applications.
  @see-class{gtk:shortcuts-shortcut}
  @see-class{gtk:size-group}")

;;; --- shortcuts-shortcut-accelerator -----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "accelerator"
                      'shortcuts-shortcut) t)
 "The @code{accelerator} property of type @code{:string} (Read / Write) @br{}
  The accelerator(s) represented by this object. This property is used if the
  @code{shortcut-type} property is set to @code{:accelerator}. The syntax of 
  this property is (an extension of) the syntax understood by the 
  @fun{gtk:accelerator-parse} function. Multiple accelerators can be specified 
  by separating them with a space, but keep in mind that the available width is 
  limited. It is also possible to specify ranges of shortcuts, using ... between 
  the keys. Sequences of keys can be specified using a @kbd{+} or @kbd{&} 
  between the keys. @br{}
  @em{Examples:} @br{}
  A single shortcut: @kbd{<ctl><alt>delete} @br{}
  Two alternative shortcuts: @kbd{<shift>a Home} @br{}
  A range of shortcuts: @kbd{<alt>1} ... @kbd{<alt>9} @br{}
  Several keys pressed together: @kbd{Control_L} & @kbd{Control_R} @br{}
  A sequence of shortcuts or keys: @kbd{<ctl>c+<ctl>x} @br{}
  Use @kbd{+} instead of @kbd{&} when the keys may (or have to be) pressed 
  sequentially (e.g use @kbd{t+t} for 'press the @kbd{t} key twice'). @br{}
  Note that @kbd{<}, @kbd{>} and @kbd{&} need to be escaped as @kbd{<}, 
  @kbd{>} and @kbd{&} when used in @file{.ui} files. @br{}
  Default value: @code{nil}")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-accelerator)
      "Accessor"
      (documentation 'shortcuts-shortcut-accelerator 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-accelerator object) => accelerator}
  @syntax[]{(setf (gtk:shortcuts-shortcut-accelerator object) accelerator)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[accelerator]{a string with the accelerator}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{accelerator} of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  The accelerator(s) represented by this object. This property is used if the
  @code{shortcut-type} property is set to @code{:accelerator}. The syntax of 
  this property is (an extension of) the syntax understood by the 
  @fun{gtk:accelerator-parse} function. Multiple accelerators can be specified 
  by separating them with a space, but keep in mind that the available width is 
  limited. It is also possible to specify ranges of shortcuts, using ... between 
  the keys. Sequences of keys can be specified using a @kbd{+} or @kbd{&} 
  between the keys.

  @em{Examples:} @br{}
  A single shortcut: @kbd{<ctl><alt>delete} @br{}
  Two alternative shortcuts: @kbd{<shift>a Home} @br{}
  A range of shortcuts: @kbd{<alt>1} ... @kbd{<alt>9} @br{}
  Several keys pressed together: @kbd{Control_L} & @kbd{Control_R} @br{}
  A sequence of shortcuts or keys: @kbd{<ctl>c+<ctl>x} @br{}
  Use @kbd{+} instead of @kbd{&} when the keys may (or have to be) pressed 
  sequentially (e.g use @kbd{t+t} for 'press the @kbd{t} key twice'). @br{}
  Note that @kbd{<}, @kbd{>} and @kbd{&} need to be escaped as @kbd{<}, 
  @kbd{>} and @kbd{&} when used in @file{.ui} files. @br{}
  @see-class{gtk:shortcuts-shortcut}
  @see-function{gtk:accelerator-parse}")

;;; --- shortcuts-shortcut-action-name -----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "action-name"
                      'shortcuts-shortcut) t)
 "The @code{action-name} property of type @code{:string} (Read / Write) @br{}
  A detailed action name. If this is set for a shortcut of @code{:accelerator}
  type, then GTK will use the accelerators that are associated with the action 
  via the @fun{gtk:application-accels-for-action} function, and setting 
  @code{accelerator} is not necessary. Since 3.22 @br{}
  Default value: @code{nil}")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-action-name)
      "Accessor"
      (documentation 'shortcuts-shortcut-action-name 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-action-name object) => action-name}
  @syntax[]{(setf (gtk:shortcuts-shortcut-action-name object) action-name)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[action-name]{a string with the detailed action name}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{action-name} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  A detailed action name. If this is set for a shortcut of @code{:accelerator}
  type, then GTK will use the accelerators that are associated with the action 
  via the @fun{gtk:application-accels-for-action} function, and setting 
  @code{accelerator} is not necessary.

  Since 3.22
  @see-class{gtk:shortcuts-shortcut}
  @see-function{gtk:application-accels-for-action}")

;;; --- shortcuts-shortcut-direction -------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "direction"
                      'shortcuts-shortcut) t)
 "The @code{direction} property of type @symbol{gtk:text-direction}
  (Read / Write) @br{}
  The text direction for which this shortcut is active. If the shortcut is used
  regardless of the text direction, set this property to @code{:none}. @br{}
  Default value: @code{:dir-none}")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-direction)
      "Accessor"
      (documentation 'shortcuts-shortcut-direction 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-direction object) => direction}
  @syntax[]{(setf (gtk:shortcuts-shortcut-direction object) direction)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[direction]{a value of the @symbol{gtk:text-direction} enumeration}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{direction} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  The text direction for which this shortcut is active. If the shortcut is used
  regardless of the text direction, set this property to @code{:none}.
  @see-class{gtk:shortcuts-shortcut}
  @see-symbol{gtk:text-direction}")

;;; --- shortcuts-shortcut-icon ------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "icon"
                      'shortcuts-shortcut) t)
 "The @code{icon} property of type @class{g:icon} (Read / Write) @br{}
  An icon to represent the shortcut or gesture. This property is used if
  @code{shortcut-type} is set to @code{:gesture}. For the other predefined
  gesture types, GTK provides an icon on its own.")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-icon)
      "Accessor"
      (documentation 'shortcuts-shortcut-icon 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-icon object) => icon}
  @syntax[]{(setf (gtk:shortcuts-shortcut-icon object) icon)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[icon]{a @class{g:icon} object}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{icon} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  An icon to represent the shortcut or gesture. This property is used if
  @code{shortcut-type} is set to @code{:gesture}. For the other predefined
  gesture types, GTK provides an icon on its own.
  @see-class{gtk:shortcuts-shortcut}
  @see-class{g:icon}")

;;; --- shortcuts-shortcut-icon-set --------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "icon-set" 
                                               'shortcuts-shortcut) t)
 "The @code{icon-set} property of type @code{:boolean} (Read / Write) @br{}
  @em{True} if an icon has been set. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-icon-set)
      "Accessor"
      (documentation 'shortcuts-shortcut-icon-set 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-icon-set object) => setting}
  @syntax[]{(setf (gtk:shortcuts-shortcut-icon-set object) setting)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[setting]{a boolean whether an icon has been set}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{icon-set} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  @em{True} if an icon has been set.
  @see-class{gtk:shortcuts-shortcut}")

;;; --- shortcuts-shortcut-shortcut-type ---------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "shortcut-type"
                      'shortcuts-shortcut) t)
 "The @code{shortcut-type} property of type @symbol{gtk:shortcut-type}
  (Read / Write) @br{}
  The type of shortcut that is represented. @br{}
  Default value: @code{:accelerator}")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-shortcut-type)
      "Accessor"
      (documentation 'shortcuts-shortcut-shortcut-type 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-shortcut-type object) => shortcut-type}
  @syntax[]{(setf (gtk:shortcuts-shortcut-shortcut-type object) shortcut-type)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[shortcut-type]{a value of the @symbol{gtk:shortcut-type}
    enumeration}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{shortcut-type} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  The type of shortcut that is represented.
  @see-class{gtk:shortcuts-shortcut}
  @see-symbol{gtk:shortcut-type}")

;;; --- shortcuts-shortcut-subtitle --------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "subtitle"
                      'shortcuts-shortcut) t)
 "The @code{subtitle} property of type @code{:string} (Read / Write) @br{}
  The subtitle for the shortcut or gesture. This is typically used for gestures
  and should be a short, one-line text that describes the gesture itself. For
  the predefined gesture types, GTK provides a subtitle on its own. @br{}
  Default value: \"\"")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-subtitle)
      "Accessor"
      (documentation 'shortcuts-shortcut-subtitle 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-subtitle object) => subtitle}
  @syntax[]{(setf (gtk:shortcuts-shortcut-subtitle object) subtitle)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[subtitle]{a string with the subtitle for the shortcut}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{subtitle} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  The subtitle for the shortcut or gesture. This is typically used for gestures
  and should be a short, one-line text that describes the gesture itself. For
  the predefined gesture types, GTK provides a subtitle on its own.
  @see-class{gtk:shortcuts-shortcut}")

;;; --- shortcuts-shortcut-subtitle-set ----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "subtitle-set"
                      'shortcuts-shortcut) t)
 "The @code{subtitle-set} property of type @code{:boolean} (Read / Write) @br{}
  @em{True} if a subtitle has been set. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-subtitle-set)
      "Accessor"
      (documentation 'shortcuts-shortcut-subtitle-set 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-subtitle-set object) => setting}
  @syntax[]{(setf (gtk:shortcuts-shortcut-subtitle-set object) setting)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[setting]{a boolean whether a subtitle has been set}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{subtitle-set} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  @em{True} if a subtitle has been set.
  @see-class{gtk:shortcuts-shortcut}")

;;; --- shortcuts-shortcut-title -----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "title"
                      'shortcuts-shortcut) t)
 "The @code{title} property of type @code{:string} (Read / Write) @br{}
  The textual description for the shortcut or gesture represented by this
  object. This should be a short string that can fit in a single line. @br{}
  Default value: \"\"")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-title)
      "Accessor"
      (documentation 'shortcuts-shortcut-title 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-title object) => title}
  @syntax[]{(setf (gtk:shortcuts-shortcut-title object) title)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[title]{a string with the textual description for the shortcut}
  @begin{short}
    Accessor of the @slot[gtk:shortcuts-shortcut]{title} slot of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  The textual description for the shortcut or gesture represented by this
  object. This should be a short string that can fit in a single line.
  @see-class{gtk:shortcuts-shortcut}")

;;; --- shortcuts-shortcut-title-size-group ------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "title-size-group"
                      'shortcuts-shortcut) t)
 "The @code{title-size-group} property of type @class{gtk:size-group} (Write)
  @br{}
  The size group for the textual portion of this shortcut. This is used
  internally by GTK, and must not be modified by applications. @br{}")

#+liber-documentation
(setf (liber:alias-for-function 'shortcuts-shortcut-title-size-group)
      "Accessor"
      (documentation 'shortcuts-shortcut-title-size-group 'function)
 "@version{#2023-2-28}
  @syntax[]{(gtk:shortcuts-shortcut-title-size-group object) => title-size-group}
  @syntax[]{(setf (gtk:shortcuts-shortcut-title-size-group object) title-size-group)}
  @argument[object]{a @class{gtk:shortcuts-shortcut} widget}
  @argument[title-size-group]{a @class{gtk:size-group} object}
  @begin{short}
    Accessor of the slot @slot[gtk:shortcuts-shortcut]{title-size-group} of the
    @class{gtk:shortcuts-shortcut} class.
  @end{short}
  The size group for the textual portion of this shortcut. This is used
  internally by GTK, and must not be modified by applications.
  @see-class{gtk:shortcuts-shortcut}")

;;; --- End of file gtk3.shortcuts-shortcut.lisp -------------------------------
