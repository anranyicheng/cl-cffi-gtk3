;;; ----------------------------------------------------------------------------
;;; gtk3.printer.lisp
;;;
;;; The documentation of this file is taken from the GTK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GTK library.
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
;;; GtkPrinter
;;;
;;;     Represents a printer
;;;
;;; Types and Values
;;;
;;;     GtkPrinter
;;;     GtkPrintBackend
;;;
;;; Functions
;;;
;;;     gtk_printer_new
;;;     gtk_printer_get_backend
;;;     gtk_printer_get_name
;;;     gtk_printer_get_state_message
;;;     gtk_printer_get_description
;;;     gtk_printer_get_location
;;;     gtk_printer_get_icon_name
;;;     gtk_printer_get_job_count
;;;     gtk_printer_is_active
;;;     gtk_printer_is_paused
;;;     gtk_printer_is_accepting_jobs
;;;     gtk_printer_is_virtual
;;;     gtk_printer_is_default
;;;     gtk_printer_accepts_ps
;;;     gtk_printer_accepts_pdf
;;;     gtk_printer_list_papers
;;;     gtk_printer_compare
;;;     gtk_printer_has_details
;;;     gtk_printer_request_details
;;;     gtk_printer_get_capabilities
;;;     gtk_printer_get_default_page_size
;;;     gtk_printer_get_hard_margins
;;;     GtkPrinterFunc
;;;     gtk_enumerate_printers
;;;
;;; Properties
;;;
;;;     accepting-jobs
;;;     accepts-pdf
;;;     accepts-ps
;;;     backend
;;;     icon-name
;;;     is-virtual
;;;     job-count
;;;     location
;;;     name
;;;     paused
;;;     state-message
;;;
;;; Signals
;;;
;;;     details-acquired
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ├── GtkPrintBackend
;;;     ╰── GtkPrinter
;;; ----------------------------------------------------------------------------

(in-package :gtk)

;;; ----------------------------------------------------------------------------
;;; GtkPrintBackend
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkPrintBackend" print-backend
  (:superclass g:object
    :export t
    :interfaces nil
    :type-initializer "gtk_print_backend_get_type")
  nil)

#+liber-documentation
(setf (documentation 'print-backend 'type)
 "@version{#2021-12-25}
  @short{No documentation.}
  @see-class{gtk:printer}")

;;; ----------------------------------------------------------------------------
;;; struct GtkPrinter
;;; ----------------------------------------------------------------------------

(define-g-object-class "GtkPrinter" printer
  (:superclass g:object
    :export t
    :interfaces nil
    :type-initializer "gtk_printer_get_type")
  ((accepting-jobs
    printer-accepting-jobs
    "accepting-jobs" "gboolean" t nil)
   (accepts-pdf
    printer-accepts-pdf
    "accepts-pdf" "gboolean" t t)
   (accepts-ps
    printer-accepts-ps
    "accepts-ps" "gboolean" t t)
   (backend
    printer-backend
    "backend" "GtkPrintBackend" t t)
   (icon-name
    printer-icon-name
    "icon-name" "gchararray" t nil)
   (is-virtual
    printer-is-virtual
    "is-virtual" "gboolean" t t)
   (job-count
    printer-job-count
    "job-count" "gint" t nil)
   (location
    printer-location
    "location" "gchararray" t nil)
   (name
    printer-name
    "name" "gchararray" t t)
   (paused
    printer-paused
    "paused" "gboolean" t nil)
   (state-message
    printer-state-message
    "state-message" "gchararray" t nil)))

#+liber-documentation
(setf (documentation 'printer 'type)
 "@version{#2021-12-25}
  @begin{short}
    A @sym{gtk:printer} object represents a printer.
  @end{short}
  You only need to deal directly with printers if you use the non-portable
  @class{gtk:print-unix-dialog} API.

  A @sym{gtk:printer} object allows to get status information about the printer,
  such as its description, its location, the number of queued jobs, etc. Most
  importantly, a @sym{gtk:printer} object can be used to create a
  @class{gtk:print-job} object, which lets you print to the printer.
  @begin[Signal Details]{dictionary}
    @subheading{The \"details-acquired\" signal}
      @begin{pre}
lambda (printer success)    :run-last
      @end{pre}
      Gets emitted in response to a request for detailed information about a
      printer from the print backend. The success parameter indicates if the
      information was actually obtained.
      @begin[code]{table}
        @entry[printer]{The @sym{gtk:printer} object on which the signal is
          emitted.}
        @entry[success]{@em{True} if the details were successfully acquired.}
      @end{table}
  @end{dictionary}
  @see-slot{gtk:printer-accepting-jobs}
  @see-slot{gtk:printer-accepts-pdf}
  @see-slot{gtk:printer-accepts-ps}
  @see-slot{gtk:printer-backend}
  @see-slot{gtk:printer-icon-name}
  @see-slot{gtk:printer-is-virtual}
  @see-slot{gtk:printer-job-count}
  @see-slot{gtk:printer-location}
  @see-slot{gtk:printer-name}
  @see-slot{gtk:printer-paused}
  @see-slot{gtk:printer-state-message}
  @see-class{gtk:print-unix-dialog}
  @see-class{gtk:print-job}
  @see-class{gtk:print-backend}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- printer-accepting-jobs ---------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "accepting-jobs" 'printer) t)
 "The @code{accepting-jobs} property of type @code{:boolean} (Read) @br{}
  This property is @em{true} if the printer is accepting jobs. @br{}
  Default value: @em{true}")

#+liber-documentation
(setf (liber:alias-for-function 'printer-accepting-jobs)
      "Accessor"
      (documentation 'printer-accepting-jobs 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-accepting-jobs object) => accepting-jobs}
  @argument[object]{a @class{gtk:printer} object}
  @argument[accepting-jobs]{a boolean whether the printer is accepting jobs}
  @begin{short}
    Accessor of the @slot[gtk:printer]{accepting-jobs} slot of the
    @class{gtk:printer} class.
  @end{short}
  @see-class{gtk:printer}
  @see-function{gtk:printer-is-accepting-jobs}")

;;; --- printer-accepts-pdf ------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "accepts-pdf" 'printer) t)
 "The @code{accepts-pdf} property of type @code{:boolean}
  (Read / Write / Construct Only) @br{}
  @em{True} if the printer can accept PDF. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'printer-accepts-pdf)
      "Accessor"
      (documentation 'printer-accepts-pdf 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-accepts-pdf object) => accepts-pdf}
  @argument[object]{a @class{gtk:printer} object}
  @argument[accepts-pdf]{a boolean whether the printer can accept PDF}
  @begin{short}
    Accessor of the @slot[gtk:printer]{accepts-pdf} slot of the
    @class{gtk:printer} class.
  @end{short}
  Returns whether the printer accepts input in PDF format.
  @see-class{gtk:printer}")

;;; --- printer-accepts-ps -------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "accepts-ps" 'printer) t)
 "The @code{accepts-ps} property of type @code{:boolean}
  (Read / Write / Construct Only) @br{}
  @em{True} if the printer can accept PostScript. @br{}
  Default value: @em{true}")

#+liber-documentation
(setf (liber:alias-for-function 'printer-accepts-ps)
      "Accessor"
      (documentation 'printer-accepts-ps 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-accepts-ps object) => accepts-ps}
  @argument[object]{a @class{gtk:printer} object}
  @argument[accepts-ps]{a boolean whether the printer can accept PostScript}
  @begin{short}
    Accessor of the @slot[gtk:printer]{accepts-ps} slot of the
    @class{gtk:printer} class.
  @end{short}
  Returns whether the printer accepts input in PostScript format.
  @see-class{gtk:printer}")

;;; --- printer-backend ----------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "backend" 'printer) t)
 "The @code{backend} property of type @class{gtk:print-backend}
  (Read / Write / Construct Only) @br{}
  Backend for the printer.")

#+liber-documentation
(setf (liber:alias-for-function 'printer-backend)
      "Accessor"
      (documentation 'printer-backend 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-backend object) => backend}
  @argument[object]{a @class{gtk:printer} object}
  @argument[backend]{a @class{gtk:print-backend} object}
  @return{The @class{gtk:print-backend} backend of printer.}
  @begin{short}
    Accessor of the @slot[gtk:printer]{backend} slot of the
    @class{gtk:printer} class.
  @end{short}
  Returns the backend of the printer.
  @see-class{gtk:printer}
  @see-class{gtk:print-backend}")

;;; --- printer-icon-name --------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "icon-name" 'printer) t)
 "The @code{icon-name} property of type @code{:string} (Read) @br{}
  The icon name to use for the printer. @br{}
  Default value: \"\"")

#+liber-documentation
(setf (liber:alias-for-function 'printer-icon-name)
      "Accessor"
      (documentation 'printer-icon-name 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-icon-name object) => icon-name}
  @argument[object]{a @class{gtk:printer} object}
  @argument[icon-name]{a string with the icon name}
  @begin{short}
    Accessor of the @slot[gtk:printer]{icon-name} slot of the
    @class{gtk:printer} class.
  @end{short}
  Gets the name of the icon to use for the printer.
  @see-class{gtk:printer}")

;;; --- printer-is-virtual -------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "is-virtual" 'printer) t)
 "The @code{is-virtual} property of type @code{:boolean}
  (Read / Write / Construct) @br{}
  @em{False} if this represents a real hardware printer. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'printer-is-virtual)
      "Accessor"
      (documentation 'printer-is-virtual 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-is-virtual object) => is-virtual}
  @argument[object]{a @class{gtk:printer} object}
  @argument[is-virtual]{a boolean whether the printer is real hardware printer}
  @begin{short}
    Accessor of the @slot[gtk:printer]{is-virtual} slot of the
    @class{gtk:printer} class.
  @end{short}
  Returns whether the printer is virtual, i.e. does not represent actual
  printer hardware, but something like a CUPS class.
  @see-class{gtk:printer}")

;;; --- printer-job-count --------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "job-count" 'printer) t)
 "The @code{job-count} property of type @code{:int} (Read) @br{}
  Number of jobs queued in the printer. @br{}
  Allowed values: >= 0 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'printer-job-count)
      "Accessor"
      (documentation 'printer-job-count 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-job-count object) => count}
  @argument[object]{a @class{gtk:printer} object}
  @argument[count]{an integer with he number of jobs queued on the printer}
  @begin{short}
    Accessor of the @slot[gtk:printer]{job-count} slot of the
    @class{gtk:printer} class.
  @end{short}
  Gets the number of jobs currently queued on the printer.
  @see-class{gtk:printer}")

;;; --- printer-location ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "location" 'printer) t)
 "The @code{location} property of type @code{:string} (Read) @br{}
  The location of the printer. @br{}
  Default value: \"\"")

#+liber-documentation
(setf (liber:alias-for-function 'printer-location)
      "Accessor"
      (documentation 'printer-location 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-location object) => location}
  @argument[object]{a @class{gtk:printer} object}
  @argument[location]{a string with the location of the printer}
  @begin{short}
    Accessor of the @slot[gtk:printer]{location} slot of the
    @class{gtk:printer} class.
  @end{short}
  Returns a description of the location of the printer.
  @see-class{gtk:printer}")

;;; --- printer-name -------------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "name" 'printer) t)
 "The @code{name} property of type @code{:string} (Read / Write / Construct)
  @br{}
  Name of the printer. @br{}
  Default value: \"\"")

#+liber-documentation
(setf (liber:alias-for-function 'printer-name)
      "Accessor"
      (documentation 'printer-name 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-name object) => name}
  @argument[object]{a @class{gtk:printer} object}
  @argument[name]{a string with the name of the printer}
  @begin{short}
    Accessor of the @slot[gtk:printer]{name} slot of the
    @class{gtk:printer} class.
  @end{short}
  Returns the name of the printer.
  @see-class{gtk:printer}")

;;; --- printer-paused -----------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "paused" 'printer) t)
 "The @code{paused} property of type @code{:boolean} (Read) @br{}
  This property is @em{true} if this printer is paused. A paused printer still
  accepts jobs, but it does not print them. @br{}
  Default value: @em{false}")

#+liber-documentation
(setf (liber:alias-for-function 'printer-paused)
      "Accessor"
      (documentation 'printer-paused 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-paused object) => paused}
  @argument[object]{a @class{gtk:printer} object}
  @argument[paused]{a boolean whether the printer is paused}
  @begin{short}
    Accessor of the @slot[gtk:printer]{paused} slot of the
    @class{gtk:printer} class.
  @end{short}
  @see-class{gtk:printer}
  @see-function{gtk:printer-is-paused}")

;;; --- printer-state-message ----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "state-message" 'printer) t)
 "The @code{state-message} property of type @code{:string} (Read) @br{}
  String giving the current state of the printer. @br{}
  Default value: \"\"")

#+liber-documentation
(setf (liber:alias-for-function 'printer-state-message)
      "Accessor"
      (documentation 'printer-state-message 'function)
 "@version{#2021-12-25}
  @syntax[]{(gtk:printer-state-message object) => message}
  @argument[object]{a @class{gtk:printer} object}
  @argument[message]{a string with the current state of the printer}
  @begin{short}
    Accessor of the @slot[gtk:printer]{state-message} slot of the
    @class{gtk:printer} class.
  @end{short}
  Returns the state message describing the current state of the printer.
  @see-class{gtk:printer}")

;;; ----------------------------------------------------------------------------
;;; gtk_printer_new ()
;;; ----------------------------------------------------------------------------

(declaim (inline printer-new))

(defun printer-new (name backend virtual)
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[name]{a string with the name of the printer}
  @argument[backend]{a @class{gtk:print-backend} object}
  @argument[virtual]{a boolean whether the printer is virtual}
  @return{A new @class{gtk:printer} object.}
  @short{Creates a new printer.}
  @see-class{gtk:printer}
  @see-class{gtk:print-backend}"
  (make-instance 'printer
                 :name name
                 :backend backend
                 :is-virtual virtual))

(export 'printer-new)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_get_description ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_get_description" printer-description) :string
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{A string with the description of @arg{printer}.}
  @short{Gets the description of the printer.}
  @see-class{gtk:printer}"
  (printer (g:object printer)))

(export 'printer-description)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_is_active ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_is_active" printer-is-active) :boolean
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{@em{True} if @arg{printer} is active.}
  @begin{short}
    Returns whether the printer is currently active, i.e. accepts new jobs.
  @end{short}
  @see-class{gtk:printer}"
  (printer (g:object printer)))

(export 'printer-is-active)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_is_paused ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_is_paused" printer-is-paused) :boolean
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{@em{True} if @arg{printer} is paused.}
  @begin{short}
    Returns whether the printer is currently paused.
  @end{short}
  A paused printer still accepts jobs, but it is not printing them.
  @see-class{gtk:printer}"
  (printer (g:object printer)))

(export 'printer-is-paused)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_is_accepting_jobs ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_is_accepting_jobs" printer-is-accepting-jobs)
    :boolean
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{@em{True} if @arg{printer} is accepting jobs.}
  @short{Returns whether the printer is accepting jobs.}
  @see-class{gtk:printer}"
  (printer (g:object printer)))

(export 'printer-is-accepting-jobs)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_is_default ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_is_default" printer-is-default) :boolean
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{@em{True} if @arg{printer} is the default.}
  @short{Returns whether the printer is the default printer.}
  @see-class{gtk:printer}"
  (printer (g:object printer)))

(export 'printer-is-default)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_accepts_ps ()
;;; ----------------------------------------------------------------------------

;;; Implemented as the Accessor of the "accepts-ps" slot

;;; ----------------------------------------------------------------------------
;;; gtk_printer_accepts_pdf ()
;;; ----------------------------------------------------------------------------

;;; Implemented as the Accessor of the "accepts-pdf" slot

;;; ----------------------------------------------------------------------------
;;; gtk_printer_list_papers ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_list_papers" printer-list-papers)
    (g:list-t (g:object page-setup))
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{A list of @class{gtk:page-setup} objects.}
  @begin{short}
     Lists all the paper sizes the printer supports.
  @end{short}
  This will return an empty list unless the details of the printer are
  available, see the @fun{gtk:printer-has-details} and
  @fun{gtk:printer-request-details} functions.
  @see-class{gtk:printer}
  @see-class{gtk:page-setup}
  @see-function{gtk:printer-has-details}
  @see-function{gtk:printer-request-details}"
  (printer (g:object printer)))

(export 'printer-list-papers)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_compare ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_compare" printer-compare) :int
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer1]{a @class{gtk:printer} object}
  @argument[printer2]{another @class{gtk:printer} object}
  @begin{return}
    0 if the printer match, a negative value if @arg{a} < @arg{b}, or a
    positive value if @arg{a} > @arg{b}.
  @end{return}
  @short{Compares two printers.}
  @see-class{gtk:printer}"
  (printer1 (g:object printer))
  (printer2 (g:object printer)))

(export 'printer-compare)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_has_details ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_has_details" printer-has-details) :boolean
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{@em{True} if @arg{printer} details are available.}
  @short{Returns whether the printer details are available.}
  @see-class{gtk:printer}
  @see-function{gtk:printer-request-details}"
  (printer (g:object printer)))

(export 'printer-has-details)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_request_details ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_request_details" printer-request-details) :void
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @begin{short}
    Requests the printer details.
  @end{short}
  When the details are available, the \"details-acquired\" signal will be
  emitted on the printer.
  @see-class{gtk:printer}
  @see-function{gtk:printer-has-details}"
  (printer (g:object printer)))

(export 'printer-request-details)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_get_capabilities ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_get_capabilities" printer-capabilities)
    print-capabilities
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{The @symbol{gtk:print-capabilities} capabilities of the printer.}
  @begin{short}
    Returns the capabilities of the printer.
  @end{short}
  This is useful when you are using the
  @slot[gtk:print-unix-dialog]{manual-capabilities} setting of the
  @class{gtk:print-unix-dialog} widget and need to know which settings the
  printer can handle and which you must handle yourself.

  This will return 0 unless the details of the printer are available, see the
  @fun{gtk:printer-has-details} and @fun{gtk:printer-request-details} functions.
  @see-class{gtk:printer}
  @see-symbol{gtk:print-capabilities}
  @see-class{gtk:print-unix-dialog}
  @see-function{gtk:printer-has-details}
  @see-function{gtk:printer-request-details}"
  (printer (g:object printer)))

(export 'printer-capabilities)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_get_default_page_size ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_get_default_page_size" printer-default-page-size)
    (g:object page-setup)
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @return{A @class{gtk:page-setup} object with the default page size of the
    printer.}
  @short{Returns the default page size of the printer.}
  @see-class{gtk:printer}
  @see-class{gtk:page-setup}"
  (printer (g:object printer)))

(export 'printer-default-page-size)

;;; ----------------------------------------------------------------------------
;;; gtk_printer_get_hard_margins ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_printer_get_hard_margins" %printer-hard-margins) :boolean
  (printer (g:object printer))
  (top (:pointer :double))
  (bottom (:pointer :double))
  (left (:pointer :double))
  (right (:pointer :double)))

(defun printer-hard-margins (printer)
 #+liber-documentation
 "@version{#2021-12-25}
  @argument[printer]{a @class{gtk:printer} object}
  @begin{return}
    @arg{top} -- a double float with the top margin @br{}
    @arg{bottom} -- a double float with the bottom margin @br{}
    @arg{left} -- a double float with the left margin in @br{}
    @arg{right} -- a double float with the right margin
  @end{return}
  @begin{short}
    Retrieve the hard margins of the printer, i.e. the margins that define
    the area at the borders of the paper that the printer cannot print to.
  @end{short}
  @begin[Note]{dictionary}
    This will not succeed unless the details of the printer are available,
    see the @fun{gtk:printer-has-details} and @fun{gtk:printer-request-details}
    functions.
  @end{dictionary}
  @see-class{gtk:printer}
  @see-function{gtk:printer-has-details}
  @see-function{gtk:printer-request-details}"
  (with-foreign-objects ((top :double)
                         (bottom :double)
                         (left :double)
                         (right :double))
    (when (%printer-hard-margins printer top bottom left right)
      (values (cffi:mem-ref top :double)
              (cffi:mem-ref bottom :double)
              (cffi:mem-ref left :double)
              (cffi:mem-ref right :double)))))

(export 'printer-hard-margins)

;;; ----------------------------------------------------------------------------
;;; GtkPrinterFunc ()
;;; ----------------------------------------------------------------------------

(defcallback printer-func :boolean
    ((printer (g:object printer))
     (data :pointer))
  (funcall (glib:get-stable-pointer-value data) printer))

#+liber-documentation
(setf (liber:alias-for-symbol 'printer-func)
      "Callback"
      (liber:symbol-documentation 'printer-func)
 "@version{#2021-12-25}
  @begin{short}
    The type of function passed to the @fun{gtk:enumerate-printers} function.
  @end{short}
  @begin{pre}
lambda (printer)
  @end{pre}
  @begin[code]{table}
    @entry[widget]{A @class{gtk:printer} object.}
    @entry[Returns]{@em{True} to stop the enumeration, @em{false} to continue.}
  @end{table}
  @see-class{gtk:printer}
  @see-function{gtk:enumerate-printers}")

(export 'printer-func)

;;; ----------------------------------------------------------------------------
;;; gtk_enumerate_printers ()
;;; ----------------------------------------------------------------------------

(defcfun ("gtk_enumerate_printers" %enumerate-printers) :void
  (func :pointer)
  (data :pointer)
  (destroy :pointer)
  (wait :boolean))

(defun enumerate-printers (func wait)
 #+liber-documentation
 "@version{#2023-2-11}
  @argument[func]{a @symbol{gtk:printer-func} function to call for each printer}
  @argument[wait]{if @em{true}, wait in a recursive main loop until all printers
    are enumerated, otherwise return early}
  @begin{short}
    Calls a function for all printers.
  @end{short}
  If @arg{func} returns @em{true}, the enumeration is stopped.
  @see-class{gtk:printer}"
  (%enumerate-printers (cffi:callback printer-func)
                       (glib:allocate-stable-pointer func)
                       (cffi:callback glib:stable-pointer-destroy-notify)
                       wait))

(export 'enumerate-printers)

;;; --- End of file gtk3.printer.lisp ------------------------------------------
