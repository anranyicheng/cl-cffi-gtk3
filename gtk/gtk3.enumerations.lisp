;;; ----------------------------------------------------------------------------
;;; gtk.enumerations.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
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
;;; Standard Enumerations
;;;
;;;     Public enumerated types used throughout GTK
;;;
;;; Types and Values
;;;
;;;     GtkBaselinePosition
;;;     GtkDeleteType
;;;     GtkDirectionType
;;;     GtkJustification
;;;     GtkMovementStep
;;;     GtkOrientation
;;;     GtkPackType
;;;     GtkPositionType
;;;     GtkReliefStyle
;;;     GtkScrollStep
;;;     GtkScrollType
;;;     GtkSelectionMode
;;;     GtkShadowType
;;;     GtkStateFlags
;;;     GtkToolbarStyle
;;;     GtkSortType
;;;
;;;     GtkTextDirection  <--- from gtk.widget.lisp
;;;
;;; TODO: Move these implementations to other files
;;;
;;;     GtkExpanderStyle
;;;     GtkStateType
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkBaselinePosition
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkBaselinePosition" baseline-position
  (:export t
   :type-initializer "gtk_baseline_position_get_type")
  (:top 0)
  (:center 1)
  (:bottom 2))

#+liber-documentation
(setf (liber:alias-for-symbol 'baseline-position)
      "GEnum"
      (liber:symbol-documentation 'baseline-position)
 "@version{#2021-3-21}
  @begin{short}
    Whenever a container has some form of natural row it may align children in
    that row along a common typographical baseline.
  @end{short}
  If the amount of vertical space in the row is taller than the total requested
  height of the baseline-aligned children then it can use a
  @sym{gtk:baseline-position} to select where to put the baseline inside the
  extra available space.
  @begin{pre}
(define-g-enum \"GtkBaselinePosition\" baseline-position
  (:export t
   :type-initializer \"gtk_baseline_position_get_type\")
  (:top 0)
  (:center 1)
  (:bottom 2))
  @end{pre}
  @begin[code]{table}
    @entry[:top]{Align the baseline at the top.}
    @entry[:center]{Center the baseline.}
    @entry[:bottom]{Align the baseline at the bottom.}
  @end{table}
  @see-class{gtk:box}")

;;; ----------------------------------------------------------------------------
;;; enum GtkDeleteType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkDeleteType" delete-type
  (:export t
   :type-initializer "gtk_delete_type_get_type")
  (:chars 0)
  (:word-ends 1)
  (:words 2)
  (:display-lines 3)
  (:display-line-ends 4)
  (:paragraph-ends 5)
  (:paragraphs 6)
  (:whitespace 7))

#+liber-documentation
(setf (liber:alias-for-symbol 'delete-type)
      "GEnum"
      (liber:symbol-documentation 'delete-type)
 "@version{#2021-3-21}
  @begin{short}
    The values of this enumeration are passed as an argument to the
    \"delete-from-cursor\" signal handler.
  @end{short}
  @begin{pre}
(define-g-enum \"GtkDeleteType\" delete-type
  (:export t
   :type-initializer \"gtk_delete_type_get_type\")
  (:chars 0)
  (:word-ends 1)
  (:words 2)
  (:display-lines 3)
  (:display-line-ends 4)
  (:paragraph-ends 5)
  (:paragraphs 6)
  (:whitespace 7))
  @end{pre}
  @begin[code]{table}
    @entry[:chars]{Delete characters.}
    @entry[:word-ends]{Delete only the portion of the word to the left/right
      of cursor if we are in the middle of a word.}
    @entry[:words]{Delete words.}
    @entry[:display-lines]{Delete display-lines. Display-lines refers to the
      visible lines, with respect to to the current line breaks. As opposed to
      paragraphs, which are defined by line breaks in the input.}
    @entry[:display-line-ends]{Delete only the portion of the display-line to
      the left/right of cursor.}
    @entry[:paragraph-ends]{Delete to the end of the paragraph. Like C-k in
      Emacs (or its reverse).}
    @entry[:paragraphs]{Delete entire line. Like C-k in pico.}
    @entry[:whitespace]{Delete only whitespace. Like M-\ in Emacs.}
  @end{table}
  @see-class{gtk:entry}
  @see-class{gtk:text-view}")

;;; ----------------------------------------------------------------------------
;;; enum GtkDirectionType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkDirectionType" direction-type
  (:export t
   :type-initializer "gtk_direction_type_get_type")
  (:tab-forward 0)
  (:tab-backward 1)
  (:up 2)
  (:down 3)
  (:left 4)
  (:right 5))

#+liber-documentation
(setf (liber:alias-for-symbol 'direction-type)
      "GEnum"
      (liber:symbol-documentation 'direction-type)
 "@version{#2020-8-18}
  @short{Focus movement types.}
  @begin{pre}
(define-g-enum \"GtkDirectionType\" direction-type
  (:export t
   :type-initializer \"gtk_direction_type_get_type\")
  (:tab-forward 0)
  (:tab-backward 1)
  (:up 2)
  (:down 3)
  (:left 4)
  (:right 5))
  @end{pre}
  @begin[code]{table}
    @entry[:tab-forward]{Move forward.}
    @entry[:tab-backward]{Move backward.}
    @entry[:up]{Move up.}
    @entry[:down]{Move down.}
    @entry[:left]{Move left.}
    @entry[:right]{Move right.}
  @end{table}")

;;; ----------------------------------------------------------------------------
;;; enum GtkJustification
;;; ----------------------------------------------------------------------------

;; TODO: Implement a base-type for defining an enumeration

(define-g-enum "GtkJustification" justification
  (:export t
   :type-initializer "gtk_justification_get_type")
  (:dummy1 -1)  ; Workaround to ensure the base-type is :int for the enumeration
  (:left 0)
  (:right 1)
  (:center 2)
  (:fill 3))

#+liber-documentation
(setf (liber:alias-for-symbol 'justification)
      "GEnum"
      (liber:symbol-documentation 'justification)
 "@version{#2021-12-22}
  @begin{short}
    Used for justifying the text inside a @class{gtk:label} widget.
  @end{short}
  See also the @class{gtk:alignment} widget.
  @begin{pre}
(define-g-enum \"GtkJustification\" justification
  (:export t
   :type-initializer \"gtk_justification_get_type\")
  (:left 0)
  (:right 1)
  (:center 2)
  (:fill 3))
  @end{pre}
  @begin[code]{table}
    @entry[:left]{The text is placed at the left edge of the label.}
    @entry[:right]{The text is placed at the right edge of the label.}
    @entry[:center]{The text is placed in the center of the label.}
    @entry[:fill]{The text is placed is distributed across the label.}
  @end{table}
  @see-class{gtk:alignment}
  @see-class{gtk:label}")

;;; ----------------------------------------------------------------------------
;;; enum GtkMovementStep
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkMovementStep" movement-step
  (:export t
   :type-initializer "gtk_movement_step_get_type")
  (:logical-positions 0)
  (:visual-positions 1)
  (:words 2)
  (:display-lines 3)
  (:display-line-ends 4)
  (:paragraphs 5)
  (:paragraph-ends 6)
  (:pages 7)
  (:buffer-ends 8)
  (:horizontal-pages 9))

#+liber-documentation
(setf (liber:alias-for-symbol 'movement-step)
      "GEnum"
      (liber:symbol-documentation 'movement-step)
 "@version{#2021-12-6}
  @begin{short}
    The values of this enumeration are passed as an argument to the
    \"move-cursor\" signal handler.
  @end{short}
  @begin{pre}
(define-g-enum \"GtkMovementStep\" movement-step
  (:export t
   :type-initializer \"gtk_movement_step_get_type\")
  (:logical-positions 0)
  (:visual-positions 1)
  (:words 2)
  (:display-lines 3)
  (:display-line-ends 4)
  (:paragraphs 5)
  (:paragraph-ends 6)
  (:pages 7)
  (:buffer-ends 8)
  (:horizontal-pages 9))
  @end{pre}
  @begin[code]{table}
    @entry[:logical-positions]{Move forward or back by graphemes.}
    @entry[:visual-positions]{Move left or right by graphemes.}
    @entry[:words]{Move forward or back by words.}
    @entry[:display-lines]{Move up or down lines (wrapped lines).}
    @entry[:display-line-ends]{Move to either end of a line.}
    @entry[:paragraphs]{Move up or down paragraphs (newline-ended lines).}
    @entry[:paragraph-ends]{Move to either end of a paragraph.}
    @entry[:pages]{Move by pages.}
    @entry[:buffer-ends]{Move to ends of the buffer.}
    @entry[:horizontal-pages]{Move horizontally by pages.}
  @end{table}
  @see-class{gtk:entry}
  @see-class{gtk:tree-view}
  @see-class{gtk:list-box}
  @see-class{gtk:flow-box}")

;;; ----------------------------------------------------------------------------
;;; enum GtkOrientation
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkOrientation" orientation
  (:export t
   :type-initializer "gtk_orientation_get_type")
  (:horizontal 0)
  (:vertical 1))

#+liber-documentation
(setf (liber:alias-for-symbol 'orientation)
      "GEnum"
      (liber:symbol-documentation 'orientation)
 "@version{#2021-11-13}
  @begin{short}
    Represents the orientation of widgets which can be switched between
    horizontal and vertical orientation on the fly, like the @class{gtk:toolbar}
    widget.
  @end{short}
  @begin{pre}
(define-g-enum \"GtkOrientation\" orientation
  (:export t
   :type-initializer \"gtk_orientation_get_type\")
  (:horizontal 0)
  (:vertical 1))
  @end{pre}
  @begin[code]{table}
    @entry[:horizontal]{The widget is in horizontal orientation.}
    @entry[:vertical]{The widget is in vertical orientation.}
  @end{table}
  @see-class{gtk:orientable}
  @see-class{gtk:toolbar}")

;;; ----------------------------------------------------------------------------
;;; enum GtkPackType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkPackType" pack-type
  (:export t
   :type-initializer "gtk_pack_type_get_type")
  (:start 0)
  (:end 1))

#+liber-documentation
(setf (liber:alias-for-symbol 'pack-type)
      "GEnum"
      (liber:symbol-documentation 'pack-type)
 "@version{#2021-4-30}
  @begin{short}
    Represents the packing location of a @class{gtk:box} child widget.
  @end{short}
  See also the @class{gtk:button-box} widget.
  @begin{pre}
(define-g-enum \"GtkPackType\" pack-type
  (:export t
   :type-initializer \"gtk_pack_type_get_type\")
  (:start 0)
  (:end 1))
  @end{pre}
  @begin[code]{table}
    @entry[:start]{The child is packed into the start of the box.}
    @entry[:end]{The child is packed into the end of the box.}
  @end{table}
  @see-class{gtk:box}
  @see-class{gtk:button-box}")

;;; ----------------------------------------------------------------------------
;;; enum GtkPositionType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkPositionType" position-type
  (:export t
   :type-initializer "gtk_position_type_get_type")
  (:left 0)
  (:right 1)
  (:top 2)
  (:bottom 3))

#+liber-documentation
(setf (liber:alias-for-symbol 'position-type)
      "GEnum"
      (liber:symbol-documentation 'position-type)
 "@version{#2021-12-22}
  @begin{short}
    Describes which edge of a widget a certain feature is positioned at, e.g.
    the tabs of a @class{gtk:notebook} widget or the label of a
    @class{gtk:scale} widget.
  @end{short}
  @begin{pre}
(define-g-enum \"GtkPositionType\" position-type
  (:export t
   :type-initializer \"gtk_position_type_get_type\")
  (:left 0)
  (:right 1)
  (:top 2)
  (:bottom 3))
  @end{pre}
  @begin[code]{table}
    @entry[:left]{The feature is at the left edge.}
    @entry[:right]{The feature is at the right edge.}
    @entry[:top]{The feature is at the top edge.}
    @entry[:bottom]{The feature is at the bottom edge.}
  @end{table}
  @see-class{gtk:notebook}
  @see-class{gtk:scale}")

;;; ----------------------------------------------------------------------------
;;; enum GtkReliefStyle
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkReliefStyle" relief-style
  (:export t
   :type-initializer "gtk_relief_style_get_type")
  (:normal 0)
  (:half 1)
  (:none 2))

#+liber-documentation
(setf (liber:alias-for-symbol 'relief-style)
      "GEnum"
      (liber:symbol-documentation 'relief-style)
 "@version{#2020-5-10}
  @short{Indicated the relief to be drawn around a @class{gtk:button} widget.}
  @begin{pre}
(define-g-enum \"GtkReliefStyle\" relief-style
  (:export t
   :type-initializer \"gtk_relief_style_get_type\")
  (:normal 0)
  (:half 1)
  (:none 2))
  @end{pre}
  @begin[code]{table}
    @entry[:normal]{Draw a normal relief.}
    @entry[:half]{Draw a half relief. Deprecated in 3.14, does the same as
      @code{:normal}.}
    @entry[:none]{Draw no relief.}
  @end{table}
  @see-class{gtk:button}")

;;; ----------------------------------------------------------------------------
;;; enum GtkScrollStep
;;; ----------------------------------------------------------------------------

;; TODO: This enumeration is not in use in the cl-cffi-gtk implementation.

(define-g-enum "GtkScrollStep" scroll-step
  (:export t
   :type-initializer "gtk_scroll_step_get_type")
  (:steps 0)
  (:pages 1)
  (:ends 2)
  (:horizontal-steps 3)
  (:horizontal-pages 4)
  (:horizontal-ends 5))

#+liber-documentation
(setf (liber:alias-for-symbol 'scroll-step)
      "GEnum"
      (liber:symbol-documentation 'scroll-step)
 "@version{#2020-12-4}
  @short{}
  @begin{pre}
(define-g-enum \"GtkScrollStep\" scroll-step
  (:export t
   :type-initializer \"gtk_scroll_step_get_type\")
  (:steps 0)
  (:pages 1)
  (:ends 2)
  (:horizontal-steps 3)
  (:horizontal-pages 4)
  (:horizontal-ends 5))
  @end{pre}")

;;; ----------------------------------------------------------------------------
;;; enum GtkScrollType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkScrollType" scroll-type
  (:export t
   :type-initializer "gtk_scroll_type_get_type")
  (:none 0)
  (:jump 1)
  (:step-backward 2)
  (:step-forward 3)
  (:page-backward 4)
  (:page-forward 5)
  (:step-up 6)
  (:step-down 7)
  (:page-up 8)
  (:page-down 9)
  (:step-left 10)
  (:step-right 11)
  (:page-left 12)
  (:page-right 13)
  (:start 14)
  (:end 15))

#+liber-documentation
(setf (liber:alias-for-symbol 'scroll-type)
      "GEnum"
      (liber:symbol-documentation 'scroll-type)
 "@version{#2021-2-10}
  @begin{short}
    The scrolling types of this enumeration are a parameter for signal
    handlers in various widgets such as @class{gtk:spin-button},
    @class{gtk:scrolled-window}, or @class{gtk:combo-box}.
  @end{short}
  @begin{pre}
(define-g-enum \"GtkScrollType\" scroll-type
  (:export t
   :type-initializer \"gtk_scroll_type_get_type\")
  (:none 0)
  (:jump 1)
  (:step-backward 2)
  (:step-forward 3)
  (:page-backward 4)
  (:page-forward 5)
  (:step-up 6)
  (:step-down 7)
  (:page-up 8)
  (:page-down 9)
  (:step-left 10)
  (:step-right 11)
  (:page-left 12)
  (:page-right 13)
  (:start 14)
  (:end 15))
  @end{pre}
  @see-class{gtk:spin-button}
  @see-class{gtk:scrolled-window}
  @see-class{gtk:combo-box}")

;;; ----------------------------------------------------------------------------
;;; enum GtkSelectionMode
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkSelectionMode" selection-mode
  (:export t
   :type-initializer "gtk_selection_mode_get_type")
  (:none 0)
  (:single 1)
  (:browse 2)
  (:multiple 3))

#+liber-documentation
(setf (liber:alias-for-symbol 'selection-mode)
      "GEnum"
      (liber:symbol-documentation 'selection-mode)
 "@version{#2021-12-15}
  @short{Used to control what selections users are allowed to make.}
  @begin{pre}
(define-g-enum \"GtkSelectionMode\" selection-mode
  (:export t
   :type-initializer \"gtk_selection_mode_get_type\")
  (:none 0)
  (:single 1)
  (:browse 2)
  (:multiple 3))
  @end{pre}
  @begin[code]{table}
    @entry[:none]{No selection is possible.}
    @entry[:single]{Zero or one element may be selected.}
    @entry[:browse]{Exactly one element is selected. In some circumstances, such
      as initially or during a search operation, it is possible for no element
      to be selected with the @code{:browse} value. What is really enforced is
      that the user cannot deselect a currently selected element except by
      selecting another element.}
    @entry[:multiple]{Any number of elements may be selected. The @kbd{Ctrl} key
      may be used to enlarge the selection, and the @kbd{Shift} key to select
      between the focus and the child pointed to. Some widgets may also allow
      Click-drag to select a range of elements.}
  @end{table}
  @see-class{gtk:flow-box}
  @see-class{gtk:list-box}
  @see-class{gtk:icon-view}
  @see-class{gtk:tree-selection}")

;;; ----------------------------------------------------------------------------
;;; enum GtkShadowType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkShadowType" shadow-type
  (:export t
   :type-initializer "gtk_shadow_type_get_type")
  (:none 0)
  (:in 1)
  (:out 2)
  (:etched-in 3)
  (:etched-out 4))

#+liber-documentation
(setf (liber:alias-for-symbol 'shadow-type)
      "GEnum"
      (liber:symbol-documentation 'shadow-type)
 "@version{#2021-12-22}
  @begin{short}
    Used to change the appearance of an outline typically provided by a
    @class{gtk:frame} widget.
  @end{short}

  Note that many themes do not differentiate the appearance of the various
  shadow types: Either their is no visible shadow :none, or there is any other
  value.
  @begin{pre}
(define-g-enum \"GtkShadowType\" shadow-type
  (:export t
   :type-initializer \"gtk_shadow_type_get_type\")
  (:none 0)
  (:in 1)
  (:out 2)
  (:etched-in 3)
  (:etched-out 4))
  @end{pre}
  @begin[code]{table}
    @entry[:none]{No outline.}
    @entry[:in]{The outline is bevelled inwards.}
    @entry[:out]{The outline is bevelled outwards like a button.}
    @entry[:etched-in]{The outline has a sunken 3d appearance.}
    @entry[:etched-out]{The outline has a raised 3d appearance.}
  @end{table}
  @see-class{gtk:frame}")

;;; ----------------------------------------------------------------------------
;;; enum GtkStateFlags
;;; ----------------------------------------------------------------------------

(define-g-flags "GtkStateFlags" state-flags
  (:export t
   :type-initializer "gtk_state_flags_get_type")
  (:normal 0)
  (:active       #.(ash 1 0))
  (:prelight     #.(ash 1 1))
  (:selected     #.(ash 1 2))
  (:insensitive  #.(ash 1 3))
  (:inconsistent #.(ash 1 4))
  (:focused      #.(ash 1 5))
  (:backdrop     #.(ash 1 6))
  (:dir-ltr      #.(ash 1 7))
  (:dir-rtl      #.(ash 1 8))
  (:link         #.(ash 1 9))
  (:visited      #.(ash 1 10))
  (:checked      #.(ash 1 11))
  #+gtk-3-20
  (:drop-active  #.(ash 1 12))
  )

#+liber-documentation
(setf (liber:alias-for-symbol 'state-flags)
      "GFlags"
      (liber:symbol-documentation 'state-flags)
 "@version{#2021-7-4}
  @short{Describes a widget state.}
  Widget states are used to match the widget against CSS pseudo-classes. Note
  that GTK extends the regular CSS classes and sometimes uses different names.
  @begin{pre}
(define-g-flags \"GtkStateFlags\" state-flags
  (:export t
   :type-initializer \"gtk_state_flags_get_type\")
  (:normal 0)
  (:active       #.(ash 1 0))
  (:prelight     #.(ash 1 1))
  (:selected     #.(ash 1 2))
  (:insensitive  #.(ash 1 3))
  (:inconsistent #.(ash 1 4))
  (:focused      #.(ash 1 5))
  (:backdrop     #.(ash 1 6))
  (:dir-ltr      #.(ash 1 7))
  (:dir-rtl      #.(ash 1 8))
  (:link         #.(ash 1 9))
  (:visited      #.(ash 1 10))
  (:checked      #.(ash 1 11))
  (:drop-active  #.(ash 1 12)))
  @end{pre}
  @begin[code]{table}
    @entry[:normal]{State during normal operation.}
    @entry[:active]{Widget is active.}
    @entry[:prelight]{Widget has a mouse pointer over it.}
    @entry[:selected]{Widget is selected.}
    @entry[:insensitive]{Widget is insensitive.}
    @entry[:inconsistent]{Widget is inconsistent.}
    @entry[:focused]{Widget has the keyboard focus.}
    @entry[:backdrop]{Widget is in a background toplevel window.}
    @entry[:dir-ltr]{Widget is in left-to-right text direction.}
    @entry[:dir-rtl]{Widget is in right-to-left text direction.}
    @entry[:link]{Widget is a link.}
    @entry[:visited]{The location the widget points to has already been
      visited.}
    @entry[:checked]{Widget is checked.}
    @entry[:drop-active]{Widget is highlighted as a drop target for DND.
      Since 3.20}
  @end{table}
  @see-class{gtk:widget}
  @see-class{gtk:style-context}")

;;; ----------------------------------------------------------------------------
;;; enum GtkToolbarStyle
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkToolbarStyle" toolbar-style
  (:export t
   :type-initializer "gtk_toolbar_style_get_type")
  (:icons 0)
  (:text 1)
  (:both 2)
  (:both-horiz 3))

#+liber-documentation
(setf (liber:alias-for-symbol 'toolbar-style)
      "GEnum"
      (liber:symbol-documentation 'toolbar-style)
 "@version{#2021-7-20}
  @begin{short}
    Used to customize the appearance of a @class{gtk:toolbar} widget.
  @end{short}
  Note that setting the toolbar style overrides the preferences of the user for
  the default toolbar style. Note that if the button has only a label set and
  @code{:icons} is used, the label will be visible, and vice versa.
  @begin{pre}
(define-g-enum \"GtkToolbarStyle\" toolbar-style
  (:export t
   :type-initializer \"gtk_toolbar_style_get_type\")
  (:icons 0)
  (:text 1)
  (:both 2)
  (:both-horiz 3))
  @end{pre}
  @begin[code]{table}
    @entry[:icons]{Buttons display only icons in the toolbar.}
    @entry[:text]{Buttons display only text labels in the toolbar.}
    @entry[:both]{Buttons display text and icons in the toolbar.}
    @entry[:both-horiz]{Buttons display icons and text alongside each other,
      rather than vertically stacked}
  @end{table}
  @see-class{gtk:toolbar}")

;;; ----------------------------------------------------------------------------
;;; enum GtkSortType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkSortType" sort-type
  (:export t
   :type-initializer "gtk_sort_type_get_type")
  (:ascending 0)
  (:descending 1))

#+liber-documentation
(setf (liber:alias-for-symbol 'sort-type)
      "GEnum"
      (liber:symbol-documentation 'sort-type)
 "@version{#2021-3-21}
  @short{Determines the direction of a sort.}
  @begin{pre}
(define-g-enum \"GtkSortType\" sort-type
  (:export t
   :type-initializer \"gtk_sort_type_get_type\")
  (:ascending 0)
  (:descending 1))
  @end{pre}
  @begin[code]{table}
    @entry[:ascending]{Sorting is in ascending order.}
    @entry[:descending]{Sorting is in descending order.}
  @end{table}
  @see-class{gtk:tree-sortable}
  @see-class{gtk:tree-view-column}")

;;; ----------------------------------------------------------------------------
;;; enum GtkTextDirection
;;; ----------------------------------------------------------------------------

;; TODO: Implement a base-type for defining an enumeration

(define-g-enum "GtkTextDirection" text-direction
  (:export t
   :type-initializer "gtk_text_direction_get_type")
  (:dummy -1) ; Workaround to ensure the base-type is :int for the enumeration
  (:none 0)
  (:ltr 1)
  (:rtl 2))

#+liber-documentation
(setf (liber:alias-for-symbol 'text-direction)
      "GEnum"
      (liber:symbol-documentation 'text-direction)
 "@version{#2021-9-8}
  @begin{short}
    The text direction controls the primary direction for widgets containing
    text, and also the direction in which the children of a container are
    packed.
  @end{short}
  The ability to set the text direction is present in order so that correct
  localization into languages with right-to-left reading directions can be done.
  Generally, applications will let the default reading direction present, except
  for containers where the containers are arranged in an order that is
  explicitely visual rather than logical, such as buttons for text
  justification.
  @begin{pre}
(define-g-enum \"GtkTextDirection\" text-direction
  (:export t
   :type-initializer \"gtk_text_direction_get_type\")
  (:none 0)
  (:ltr 1)
  (:rtl 2))
  @end{pre}
  @begin[code]{table}
    @entry[:none]{No direction.}
    @entry[:ltr]{Left to right text direction.}
    @entry[:rtl]{Right to left text direction.}
  @end{table}
  @see-function{gtk:widget-direction}
  @see-function{gtk:widget-default-direction}")

;;; ----------------------------------------------------------------------------
;;; enum GtkExpanderStyle
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkExpanderStyle" expander-style
  (:export t
   :type-initializer "gtk_expander_style_get_type")
  (:collapsed 0)
  (:semi-collapsed 1)
  (:semi-expanded 2)
  (:expanded 3))

#+liber-documentation
(setf (liber:alias-for-symbol 'expander-style)
      "GEnum"
      (liber:symbol-documentation 'expander-style)
 "@version{#2021-3-21}
  @begin{short}
    Used to specify the style of the expanders drawn by a @class{gtk:tree-view}
    widget.
  @end{short}
  @begin{pre}
(define-g-enum \"GtkExpanderStyle\" expander-style
  (:export t
   :type-initializer \"gtk_expander_style_get_type\")
  (:collapsed 0)
  (:semi-collapsed 1)
  (:semi-expanded 2)
  (:expanded 3))
  @end{pre}
  @begin[code]{table}
    @entry[:collapsed]{The style used for a collapsed subtree.}
    @entry[:semi-collapsed]{Intermediate style used during animation.}
    @entry[:semi-expanded]{Intermediate style used during animation.}
    @entry[:expanded]{The style used for an expanded subtree.}
  @end{table}
  @see-class{gtk:tree-view}")

;;; ----------------------------------------------------------------------------
;;; enum GtkStateType
;;; ----------------------------------------------------------------------------

(define-g-enum "GtkStateType" state-type
  (:export t
   :type-initializer "gtk_state_type_get_type")
  (:normal 0)
  (:active 1)
  (:prelight 2)
  (:selected 3)
  (:insensitive 4)
  (:inconsistent 5)
  (:focused 6))

#+liber-documentation
(setf (liber:alias-for-symbol 'state-type)
      "GEnum"
      (liber:symbol-documentation 'state-type)
 "@version{#2020-9-18}
  @begin{short}
    This type indicates the current state of a widget.
  @end{short}
  The state determines how the widget is drawn. The @sym{gtk:state-type}
  enumeration is also used to identify different colors in a deprecated
  @code{GtkStyle} object for drawing, so states can be used for subparts of a
  widget as well as entire widgets.
  @begin[Warning]{dictionary}
    The @sym{gtk:state-type} enumeration has been deprecated since version 3.14
    and should not be used in newly written code. All APIs that are using this
    enumeration have been deprecated in favor of alternatives using the
    @symbol{gtk:state-flags} flags.
  @end{dictionary}
  @begin{pre}
(define-g-enum \"GtkStateType\" state-type
  (:export t
   :type-initializer \"gtk_state_type_get_type\")
  (:normal 0)
  (:active 1)
  (:prelight 2)
  (:selected 3)
  (:insensitive 4)
  (:inconsistent 5)
  (:focused 6))
  @end{pre}
  @begin[code]{table}
    @entry[:normal]{State during normal operation.}
    @entry[:active]{State of a currently active widget, such as a depressed
      button.}
    @entry[:prelight]{State indicating that the mouse pointer is over the widget
      and the widget will respond to mouse clicks.}
    @entry[:selected]{State of a selected item, such the selected row in a
      list.}
    @entry[:insensitive]{State indicating that the widget is unresponsive to
      user actions.}
    @entry[:inconsistent]{The widget is inconsistent, such as checkbuttons or
      radiobuttons that aren't either set to @em{true} nor @code{nil}, or
      buttons requiring the user attention.}
    @entry[:focused]{The widget has the keyboard focus.}
  @end{table}
  @see-symbol{gtk:state-flags}")

;;; --- End of file gtk.enumerations.lisp --------------------------------------
