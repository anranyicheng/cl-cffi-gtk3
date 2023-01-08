;;; ----------------------------------------------------------------------------
;;; gtk.calendar.lisp
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
;;; GtkCalendar
;;;
;;;     Displays a calendar and allows the user to select a date
;;;
;;; Types and Values
;;;
;;;     GtkCalendar
;;;     GtkCalendarDisplayOptions
;;;
;;; Functions
;;;
;;;     GtkCalendarDetailFunc
;;;
;;;     gtk_calendar_new
;;;     gtk_calendar_select_month
;;;     gtk_calendar_select_day
;;;     gtk_calendar_mark_day
;;;     gtk_calendar_unmark_day
;;;     gtk_calendar_get_day_is_marked
;;;     gtk_calendar_clear_marks
;;;
;;;     gtk_calendar_get_display_options
;;;     gtk_calendar_set_display_options
;;;     gtk_calendar_get_date
;;;
;;;     gtk_calendar_set_detail_func
;;;     gtk_calendar_get_detail_width_chars
;;;     gtk_calendar_set_detail_width_chars
;;;     gtk_calendar_get_detail_height_rows
;;;     gtk_calendar_set_detail_height_rows
;;;
;;; Properties
;;;
;;;         gint    day                          Read / Write
;;;         gint    detail-height-rows           Read / Write
;;;         gint    detail-width-chars           Read / Write
;;;         gint    month                        Read / Write
;;;     gboolean    no-month-change              Read / Write
;;;     gboolean    show-day-names               Read / Write
;;;     gboolean    show-details                 Read / Write
;;;     gboolean    show-heading                 Read / Write
;;;     gboolean    show-week-numbers            Read / Write
;;;         gint    year                         Read / Write
;;;
;;; Style Propertie
;;;
;;;         gint    horizontal-separation        Read
;;;         gint    inner-border                 Read
;;;         gint    vertical-separation          Read
;;;
;;; Signals
;;;
;;;         void    day-selected                 Run First
;;;         void    day-selected-double-click    Run First
;;;         void    month-changed                Run First
;;;         void    next-month                   Run First
;;;         void    next-year                    Run First
;;;         void    prev-month                   Run First
;;;         void    prev-year                    Run First
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GInitiallyUnowned
;;;         ╰── GtkWidget
;;;             ╰── GtkCalendar
;;;
;;; Implemented Interfaces
;;;
;;;     GtkCalendar implements AtkImplementorIface and GtkBuildable.
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; enum GtkCalendarDisplayOptions
;;; ----------------------------------------------------------------------------

(define-g-flags "GtkCalendarDisplayOptions" calendar-display-options
  (:export t
   :type-initializer "gtk_calendar_display_options_get_type")
  (:show-heading 1)
  (:show-day-names 2)
  (:no-month-change 4)
  (:show-week-numbers 8)
  (:show-details 32))

#+liber-documentation
(setf (liber:alias-for-symbol 'calendar-display-options)
      "GFlags"
      (liber:symbol-documentation 'calendar-display-options)
 "@version{#2021-12-18}
  @begin{short}
    These options can be used to influence the display and behaviour of a
    @class{gtk:calendar} widget.
  @end{short}
  @begin{pre}
(define-g-flags \"GtkCalendarDisplayOptions\" calendar-display-options
  (:export t
   :type-initializer \"gtk_calendar_display_options_get_type\")
  (:show-heading 1)
  (:show-day-names 2)
  (:no-month-change 4)
  (:show-week-numbers 8)
  (:show-details 32))
  @end{pre}
  @begin[code]{table}
    @entry[:show-heading]{Specifies that the month and year should be
      displayed.}
    @entry[:show-day-name]{Specifies that three letter day descriptions should
      be present.}
    @entry[:no-month-chage]{Prevents the user from switching months with the
      calendar.}
    @entry[:show-week-numbers]{Displays each week numbers of the current year,
      down the left side of the calendar.}
    @entry[:show-details]{Just show an indicator, not the full details text
      when details are provided. See the @fun{gtk:calendar-set-detail-func}
      function.}
  @end{table}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-set-detail-func}")

;;; ----------------------------------------------------------------------------
;;; struct GtkCalendar
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkCalendar" calendar
  (:superclass widget
   :export t
   :interfaces ("AtkImplementorIface"
                "GtkBuildable")
   :type-initializer "gtk_calendar_get_type")
  ((day
    calendar-day
    "day" "gint" t t)
   (detail-height-rows
    calendar-detail-height-rows
    "detail-height-rows" "gint" t t)
   (detail-width-chars
    calendar-detail-width-chars
    "detail-width-chars" "gint" t t)
   (month
    calendar-month "month" "gint" t t)
   (no-month-change
    calendar-no-month-change
    "no-month-change" "gboolean" t t)
   (show-day-names
    calendar-show-day-names
    "show-day-names" "gboolean" t t)
   (show-details
    calendar-show-details
    "show-details" "gboolean" t t)
   (show-heading
    calendar-show-heading
    "show-heading" "gboolean" t t)
   (show-week-numbers
    calendar-show-week-numbers
    "show-week-numbers" "gboolean" t t)
   (year
    calendar-year
    "year" "gint" t t)))

#+liber-documentation
(setf (documentation 'calendar 'type)
 "@version{#2021-12-18}
  @begin{short}
    The @sym{gtk:calendar} widget displays a Gregorian calendar, one month at a
    time.
  @end{short}
  It can be created with the @fun{gtk:calendar-new} function.

  The month and year currently displayed can be altered with the
  @fun{gtk:calendar-select-month} function. The exact day can be selected from
  the displayed month using the @fun{gtk:calendar-select-day} function.

  To place a visual marker on a particular day, use the
  @fun{gtk:calendar-mark-day} function and to remove the marker, the
  @fun{gtk:calendar-unmark-day} function. Alternative, all marks can be cleared
  with the @fun{gtk:calendar-clear-marks} function.

  The way in which the calendar itself is displayed can be altered using the
  @fun{gtk:calendar-display-options} function.

  The selected date can be retrieved from a @sym{gtk:calendar} widget using the
  @fun{gtk:calendar-date} function.

  Users should be aware that, although the Gregorian calendar is the legal
  calendar in most countries, it was adopted progressively between 1582 and
  1929. Display before these dates is likely to be historically incorrect.
  @begin[Style Property Details]{dictionary}
    @begin[code]{table}
      @begin[horizontal-separation]{entry}
        The @code{horizontal-separation} style property of type @code{:int}
        (Read) @br{}
        Separation between week headers and main area. @br{}
        Allowed values: >= 0 @br{}
        Default value: 4
      @end{entry}
      @begin[inner-border]{entry}
        The @code{inner-border} style property of type @code{:int} (Read) @br{}
        The spacing around the day/week headers and main area. @br{}
        Allowed values: >= 0 @br{}
        Default value: 4
      @end{entry}
      @begin[vertical-separation]{entry}
        The @code{vertical-separation} style property of type @code{:int}
        (Read) @br{}
        Space between day headers and main area. @br{}
        Allowed values: >= 0 @br{}
        Default value: 4
      @end{entry}
    @end{table}
  @end{dictionary}
  @begin[Signal Details]{dictionary}
    @subheading{The \"day-selected\" signal}
      @begin{pre}
 lambda (calendar)    :run-first
      @end{pre}
      The signal is emitted when the user selects a day.
      @begin[code]{table}
        @entry[calendar]{The @sym{gtk:calendar} widget which received the
          signal.}
      @end{table}
    @subheading{The \"day-selected-double-click\" signal}
      @begin{pre}
 lambda (calendar)    :run-first
      @end{pre}
      The signal is emitted when the user double-clicks a day.
      @begin[code]{table}
        @entry[calendar]{The @sym{gtk:calendar} widget which received the
          signal.}
      @end{table}
    @subheading{The \"month-changed\" signal}
      @begin{pre}
 lambda (calendar)    :run-first
      @end{pre}
      The signal is emitted when the user clicks a button to change the selected
       month on a calendar.
      @begin[code]{table}
        @entry[calendar]{The @sym{gtk:calendar} widget which received the
          signal.}
      @end{table}
    @subheading{The \"next-month\" signal}
      @begin{pre}
 lambda (calendar)    :run-first
      @end{pre}
      The signal is emitted when the user switched to the next month.
      @begin[code]{table}
        @enty[calendar]{The @sym{gtk:calendar} widget which received the
          signal.}
      @end{table}
    @subheading{The \"next-year\" signal}
      @begin{pre}
 lambda (calendar)    :run-first
      @end{pre}
      The signal is emitted when user switched to the next year.
      @begin[code]{table}
        @entry[calendar]{The @sym{gtk:calendar} widget which received the
          signal.}
      @end{table}
    @subheading{The \"prev-month\" signal}
      @begin{pre}
 lambda (calendar)    :run-first
      @end{pre}
      The signal is emitted when the user switched to the previous month.
      @begin[code]{table}
        @entry[calendar]{The @sym{gtk:calendar} widget which received the
          signal.}
      @end{table}
    @subheading{The \"prev-year\" signal}
      @begin{pre}
 lambda (calendar)    :run-first
      @end{pre}
      The signal is emitted when user switched to the previous year.
      @begin[code]{table}
        @entry[calendar]{The @sym{gtk:calendar} widget which received the
          signal.}
      @end{table}
  @end{dictionary}
  @see-slot{gtk:calendar-day}
  @see-slot{gtk:calendar-detail-height-rows}
  @see-slot{gtk:calendar-detail-width-chars}
  @see-slot{gtk:calendar-month}
  @see-slot{gtk:calendar-no-month-change}
  @see-slot{gtk:calendar-show-day-names}
  @see-slot{gtk:calendar-show-details}
  @see-slot{gtk:calendar-show-heading}
  @see-slot{gtk:calendar-show-week-numbers}
  @see-slot{gtk:calendar-year}
  @see-symbol{gtk:calendar-display-options}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- calendar-day -------------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "day" 'calendar) t)
 "The @code{day} property of type @code{:int} (Read / Write) @br{}
  The selected day as a number between 1 and 31, or 0 to unselect the
  currently selected day. This property gets initially set to the current
  day. @br{}
  Allowed values: [0, 31] @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-day)
      "Accessor"
      (documentation 'calendar-day 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calender-day object) => day}
  @syntax[]{(setf (gtk:calendar-day object) day)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[day]{an integer with the selected day}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{day} slot of the @class{gtk:calendar}
    class.
  @end{short}
  The selected day as a number between 1 and 31, or 0 to unselect the
  currently selected day. This property gets initially set to the current
  day.
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-date}
  @see-function{gtk:calendar-select-day}")

;;; --- calendar-detail-height-rows ----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "detail-height-rows"
                                               'calendar) t)
 "The @code{detail-height-rows} property of type @code{:int} (Read / Write)
  @br{}
  Height of a detail cell, in rows. A value of 0 allows any width. @br{}
  Allowed values: [0, 127] @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-detail-height-rows)
      "Accessor"
      (documentation 'calendar-detail-height-rows 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-detail-height-rows object) => rows}
  @syntax[]{(setf (gtk:calendar-detail-height-rows object) rows)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[rows]{an integer with the detail height in rows}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{detail-height-rows} slot of the
    @class{gtk:calendar} class.
  @end{short}

  The @sym{gtk:calendar-detail-height-rows} slot access function queries the
  height of detail cells, in rows. The
  @sym{(setf gtk:calendar-detail-height-rows)} slot access function updates the
  height of detail cells.
  @see-class{gtk:calendar}")

;;; --- calendar-detail-width-chars ----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "detail-width-chars"
                                               'calendar) t)
 "The @code{detail-width-chars} property of type @code{:int} (Read / Write)@br{}
  Width of a detail cell, in characters. A value of 0 allows any width. @br{}
  Allowed values: [0, 127] @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-detail-width-chars)
      "Accessor"
      (documentation 'calendar-detail-width-chars 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-detail-width-chars object) => chars}
  @syntax[]{(setf (gtk:calendar-detail-width-chars object) chars)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[chars]{an integer with the detail width in characters}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{detail-width-chars} slot of the
    @class{gtk:calendar} class.
  @end{short}

  The @sym{gtk:calendar-detail-width-chars} slot access function queries the
  width of detail cells, in characters. The
  @sym{(setf gtk:calendar-detail-width-chars)} slot access function updates the
  width of detail cells.
  @see-class{gtk:calendar}")

;;; --- calendar-month -----------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "month" 'calendar) t)
 "The @code{month} property of type @code{:int} (Read / Write) @br{}
  The selected month as a number between 0 and 11. This property gets
  initially set to the current month. @br{}
  Allowed values: [0, 11] @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-month)
      "Accessor"
      (documentation 'calendar-month 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-month object) => month}
  @syntax[]{(setf (gtk:calendar-month object) month)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[month]{an integer with the selected month}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{month} slot of the @class{gtk:calendar}
    class.
  @end{short}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-date}
  @see-function{gtk:calendar-select-month}")

;;; --- calendar-no-month-change -------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "no-month-change"
                                               'calendar) t)
 "The @code{no-month-change} property of type @code{:boolean} (Read / Write)
  @br{}
  Determines whether the selected month can be changed. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-no-month-change)
      "Accessor"
      (documentation 'calendar-no-month-change 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-no-month-change object) => no-change}
  @syntax[]{(setf (gtk:calendar-no-month-change object) no-change)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[no-change]{a boolean whether the selected month can be changed}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{no-month-change} slot of the
    @class{gtk:calendar} class.
  @end{short}

  Determines whether the selected month can be changed.
  @see-class{gtk:calendar}")

;;; --- calendar-show-day-names --------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "show-day-names"
                                               'calendar) t)
 "The @code{show-day-names} property of type @code{:boolean} (Read / Write)
  @br{}
  Determines whether day names are displayed. @br{}
  Default value: @em{true}")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-show-day-names)
      "Accessor"
      (documentation 'calendar-show-day-names 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-show-day-names object) => show-day-names}
  @syntax[]{(setf (gtk:calendar-show-day-names object) show-day-names)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[show-day-names]{a boolean whether day names are displayed}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{show-day-names} slot of the
    @class{gtk:calendar} class.
  @end{short}

  Determines whether day names are displayed.
  @see-class{gtk:calendar}")

;;; --- calendar-show-details ----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "show-details" 'calendar) t)
 "The @code{show-details} property of type @code{:boolean} (Read / Write) @br{}
  Determines whether details are shown directly in the widget, or if they are
  available only as tooltip. When this property is set days with details are
  marked. @br{}
  Default value: @em{true}")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-show-details)
      "Accessor"
      (documentation 'calendar-show-details 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-show-details object) => show-details}
  @syntax[]{(setf (gtk:calendar-show-details object) show-details)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[show-details]{a boolean whether details are shown}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{show-details} slot of the
    @class{gtk:calendar} class.
  @end{short}

  Determines whether details are shown directly in the widget, or if they are
  available only as tooltip. When this property is set days with details are
  marked.
  @see-class{gtk:calendar}")

;;; --- calendar-show-heading ----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "show-heading" 'calendar) t)
 "The @code{show-heading} property of type @code{:boolean} (Read / Write) @br{}
  Determines whether a heading is displayed. @br{}
  Default value: @em{true}")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-show-heading)
      "Accessor"
      (documentation 'calendar-show-heading 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-show-heading object) => show-heading}
  @syntax[]{(setf (gtk:calendar-show-heading object) show-heading)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[show-heading]{a boolean whether a heading is displayed}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{show-heading} slot of the
    @class{gtk:calendar} class.
  @end{short}

  Determines whether a heading is displayed.
  @see-class{gtk:calendar}")

;;; --- calendar-show-week-numbers -----------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "show-week-numbers"
                                               'calendar) t)
 "The @code{show-week-numbers} property of type @code{:boolean} (Read / Write)
  @br{}
  Determines whether week numbers are displayed. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-show-week-numbers)
      "Accessor"
      (documentation 'calendar-show-week-numbers 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-show-week-numbers object) => show-week-numbers}
  @syntax[]{(setf (gtk:calendar-show-week-numbers object) show-week-numbers)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[show-week-numbers]{a boolean whether week numbers are displayed}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{show-week-numbers} slot of the
    @class{gtk:calendar} class.
  @end{short}

  Determines whether week numbers are displayed.
  @see-class{gtk:calendar}")

;;; --- calendar-year ------------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "year" 'calendar) t)
 "The @code{year} property of type @code{:int} (Read / Write) @br{}
  The selected year. This property gets initially set to the current year. @br{}
  Allowed values: [0, 4194303] @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'calendar-year)
      "Accessor"
      (documentation 'calendar-year 'function)
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-year object) => year}
  @syntax[]{(setf (gtk:calendar-year object) year)}
  @argument[object]{a @class{gtk:calendar} widget}
  @argument[year]{an integer with the selected year}
  @begin{short}
    Accessor of the @slot[gtk:calendar]{year} slot of the @class{gtk:calendar}
    class.
  @end{short}

  The selected year. This property gets initially set to the current year.
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-date}
  @see-function{gtk:calendar-select-month}")

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline calendar-new))

(defun calendar-new ()
 #+liber-documentation
 "@version{#2021-12-18}
  @return{A newly @class{gtk:calendar} widget.}
  @begin{short}
    Creates a new calendar, with the current date being selected.
  @end{short}
  @see-class{gtk:calendar}"
  (make-instance 'calendar))

(export 'calendar-new)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_select_month ()
;;; ----------------------------------------------------------------------------

(declaim (inline calendar-select-month))

(defun calendar-select-month (calendar month year)
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @argument[month]{an integer with the month between 0 and 11}
  @argument[year]{an integer with the year}
  @begin{short}
    Shifts the calendar to a different month.
  @end{short}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-select-day}"
  (setf (calendar-month calendar) month
        (calendar-year calendar) year))

(export 'calendar-select-month)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_select_day ()
;;; ----------------------------------------------------------------------------

(declaim (inline calendar-select-day))

(defun calendar-select-day (calendar day)
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @argument[day]{an integer with the day between 1 and 31, or 0 to unselect the
    currently selected day}
  @begin{short}
    Selects a day from the current month.
  @end{short}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-select-month}"
  (setf (calendar-day calendar) day))

(export 'calendar-select-day)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_mark_day ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_calendar_mark_day" calendar-mark-day) :boolean
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @argument[day]{an unsigned integer with the day to mark between 1 and 31}
  @begin{short}
    Places a visual marker on a particular day.
  @end{short}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-unmark-day}
  @see-function{gtk:calendar-day-is-marked}
  @see-function{gtk:calendar-clear-marks}"
  (calendar (g:object calendar))
  (day :uint))

(export 'calendar-mark-day)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_unmark_day ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_calendar_unmark_day" calendar-unmark-day) :boolean
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @argument[day]{an unsigned integer with the day to unmark between 1 and 31}
  @begin{short}
    Removes the visual marker from a particular day.
  @end{short}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-mark-day}
  @see-function{gtk:calendar-day-is-marked}
  @see-function{gtk:calendar-clear-marks}"
  (calendar (g:object calendar))
  (day :uint))

(export 'calendar-unmark-day)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_get_day_is_marked () -> calendar-day-is-marked
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_calendar_get_day_is_marked" calendar-day-is-marked)
    :boolean
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @argument[day]{an unsigned integer with the day between 1 and 31}
  @return{A boolean whether the day is marked.}
  @begin{short}
    Returns if the day of the calendar is already marked.
  @end{short}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-mark-day}
  @see-function{gtk:calendar-unmark-day}"
  (calendar (g:object calendar))
  (day :int))

(export 'calendar-day-is-marked)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_clear_marks ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_calendar_clear_marks" calendar-clear-marks) :void
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @begin{short}
    Remove all visual markers.
  @end{short}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-mark-day}
  @see-function{gtk:calendar-unmark-day}"
  (calendar (g:object calendar)))

(export 'calendar-clear-marks)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_get_display_options ()
;;; gtk_claendar_set_display_options () -> calendar-display-options
;;; ----------------------------------------------------------------------------

(defun (setf calendar-display-options) (flags calendar)
  (cffi:foreign-funcall "gtk_calendar_set_display_options"
                   (g:object calendar) calendar
                   calendar-display-options flags
                   :void)
  flags)

(defcfun ("gtk_calendar_get_display_options" calendar-display-options)
    calendar-display-options
 #+liber-documentation
 "@version{#2021-12-18}
  @syntax[]{(gtk:calendar-display-options calendar) => flags}
  @syntax[]{(setf (gtk:calendar-display-options calendar) flags)}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @argument[flags]{the @symbol{gtk:calendar-display-options} flags}
  @begin{short}
    Accessor of the display options of the calendar.
  @end{short}

  The @sym{gtk:calendar-display-options} function returns the current display
  options of the calendar. The @sym{(setf gtk:calendar-display-options)}
  function sets display options, e.g. whether to display the heading and the
  month headings.
  @see-class{gtk:calendar}
  @see-symbol{gtk:calendar-display-options}"
  (calendar (g:object calendar)))

(export 'calendar-display-options)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_get_date () -> calendar-date
;;; ----------------------------------------------------------------------------

(defun calendar-date (calendar)
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @begin{return}
    @arg{year} -- the year as a decimal number, e.g. 2021 @br{}
    @arg{month} -- the month number, between 0 and 11 @br{}
    @arg{day} -- the day number, between 1 and 31
  @end{return}
  @begin{short}
    Obtains the selected date from the calendar.
  @end{short}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-select-day}
  @see-function{gtk:calendar-select-month}"
  (values (calendar-year calendar)
          (calendar-month calendar)
          (calendar-day calendar)))

(export 'calendar-date)

;;; ----------------------------------------------------------------------------
;;; GtkCalendarDetailFunc ()
;;; ----------------------------------------------------------------------------

(defcallback calendar-detail-func (:string :free-to-foreign nil
                                               :free-from-foreign nil)
    ((calendar (g:object calendar))
     (year :uint)
     (month :uint)
     (day :uint)
     (data :pointer))
  (restart-case
    (or (funcall (glib:get-stable-pointer-value data) calendar year month day)
        (cffi:null-pointer))
    (return-null () (cffi:null-pointer))))

#+liber-documentation
(setf (liber:alias-for-symbol 'calendar-detail-func)
      "Callback"
      (liber:symbol-documentation 'calendar-detail-func)
 "@version{#2021-12-18}
  @begin{short}
    This kind of functions provide Pango markup with detail information for the
    specified day.
  @end{short}
  Examples for such details are holidays or appointments. The function returns
  @code{nil} when no information is available.
  @begin{pre}
 lambda (calendar year month day)
  @end{pre}
  @begin[code]{table}
    @entry[calendar]{A @class{gtk:calendar} widget.}
    @entry[year]{An unsigned integer with the year for which details are
      needed.}
    @entry[month]{An unsigned integer with the month for which details are
      needed.}
    @entry[day]{An unsigned integer with the day of month for which details are
      needed.}
    @entry[Return]{A string with Pango markup with details for the specified
      day, or @code{nil}.}
  @end{table}
  @see-class{gtk:calendar}
  @see-function{gtk:calendar-set-detail-func}")

(export 'calendar-detail-func)

;;; ----------------------------------------------------------------------------
;;; gtk_calendar_set_detail_func ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_calendar_set_detail_func" %calendar-set-detail-func) :void
  (calendar g:object)
  (func :pointer)
  (data :pointer)
  (destroy :pointer))

(defun calendar-set-detail-func (calendar func)
 #+liber-documentation
 "@version{#2021-12-18}
  @argument[calendar]{a @class{gtk:calendar} widget}
  @argument[func]{a @symbol{gtk:calendar-detail-func} callback function
    providing details for each day}
  @begin{short}
    Installs a function which provides Pango markup with detail information for
    each day.
  @end{short}
  Examples for such details are holidays or appointments. That information is
  shown below each day when the @slot[gtk:calendar]{show-details} property is
  set. A tooltip containing with full detail information is provided, if the
  entire text should not fit into the details area, or if the
  @slot[gtk:calendar]{show-details} property is not set.

  The size of the details area can be restricted by setting the
  @slot[gtk:calendar]{detail-width-chars} and
  @slot[gtk:calendar]{detail-height-rows} properties.
  @see-class{gtk:calendar}
  @see-symbol{gtk:calendar-detail-func}
  @see-function{gtk:calendar-show-details}
  @see-function{gtk:calendar-detail-width-chars}
  @see-function{gtk:calendar-detail-height-rows}"
  (%calendar-set-detail-func
          calendar
          (cffi:callback calendar-detail-func)
          (glib:allocate-stable-pointer func)
          (cffi:callback glib:stable-pointer-destroy-notify)))

(export 'calendar-set-detail-func)

;;; --- End of file gtk.calendar.lisp ------------------------------------------
