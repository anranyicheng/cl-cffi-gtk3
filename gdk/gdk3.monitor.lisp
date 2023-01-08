;;; ----------------------------------------------------------------------------
;;; gdk.monitor.lisp
;;;
;;; The documentation of this file is taken from the GDK 3 Reference Manual
;;; Version 3.24 and modified to document the Lisp binding to the GDK library.
;;; See <http://www.gtk.org>. The API documentation of the Lisp binding is
;;; available from <http://www.crategus.com/books/cl-cffi-gtk/>.
;;;
;;; Copyright (C) 2019 - 2022 Dieter Kaiser
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
;;; GdkMonitor
;;;
;;;     Object representing an output
;;;
;;; Types and Values
;;;
;;;     GdkMonitor
;;;     GdkSubpixelLayout
;;;
;;; Functions
;;;
;;;     gdk_monitor_get_display                            Accessor
;;;     gdk_monitor_get_geometry                           Accessor
;;;     gdk_monitor_get_workarea                           Accessor
;;;     gdk_monitor_get_width_mm                           Accessor
;;;     gdk_monitor_get_height_mm                          Accessor
;;;     gdk_monitor_get_manufacturer                       Accessor
;;;     gdk_monitor_get_model                              Accessor
;;;     gdk_monitor_get_scale_factor                       Accessor
;;;     gdk_monitor_get_refresh_rate                       Accessor
;;;     gdk_monitor_get_subpixel_layout                    Accessor
;;;     gdk_monitor_is_primary
;;;
;;; Properties
;;;
;;;            GdkDisplay*   display            Read / Write / Construct Only
;;;          GdkRectangle*   geometry           Read
;;;                  gint    height-mm          Read
;;;                 gchar*   manufacturer       Read
;;;                 gchar*   model              Read
;;;                  gint    refresh-rate       Read
;;;                  gint    scale-factor       Read
;;;     GdkSubpixelLayout    subpixel-layout    Read
;;;                  gint    width-mm           Read
;;;          GdkRectangle*   workarea           Read
;;;
;;; Signals
;;;
;;;                  void    invalidate         Run First
;;;
;;; Object Hierarchy
;;;
;;;     GObject
;;;     ╰── GdkMonitor
;;; ----------------------------------------------------------------------------

(in-package :gdk)

;;; ----------------------------------------------------------------------------
;;; enum GdkSubpixelLayout
;;; ----------------------------------------------------------------------------

(define-g-enum "GdkSubpixelLayout" subpixel-layout
  (:export t
   :type-initializer "gdk_subpixel_layout_get_type")
  :unknown
  :none
  :horizontal-rgb
  :horizontal-bgr
  :vertical-rgb
  :vertical-bgr)

#+liber-documentation
(setf (liber:alias-for-symbol 'subpixel-layout)
      "GEnum"
      (liber:symbol-documentation 'subpixel-layout)
 "@version{#2020-10-27}
  @begin{short}
    This enumeration describes how the red, green and blue components of
    physical pixels on an output device are laid out.
  @end{short}
  @begin{pre}
(define-g-enum \"GdkSubPixelLayout\" sub-pixel-layout
  (:export t
   :type-initializer \"gdk_sub_pixel_layout_get_type\")
  :unkown
  :none
  :horizontal-rgb
  :horizontal-bgr
  :vertical-rgb
  :vertical-bgr)
  @end{pre}
  @begin[code]{table}
    @entry[:unkown]{The layout is not known.}
    @entry[:none]{Not organized in this way.}
    @entry[:horizontal-rgb]{The layout is horizontal, the order is RGB.}
    @entry[:horizontal-bgr]{The layout is horizontal, the order is BGR.}
    @entry[:vertical-rgb]{The layout is vertical, the order is RGB.}
    @entry[:verticla-bgr]{The layout is vertical, the order is BGR.}
  @end{table}
  Since 3.22
  @see-class{gdk:monitor}")

;;; ----------------------------------------------------------------------------
;;; struct GdkMonitor
;;; ----------------------------------------------------------------------------

(define-g-object-class "GdkMonitor" monitor
  (:superclass g:object
   :export t
   :interfaces nil
   :type-initializer "gdk_monitor_get_type")
  ((display
    monitor-display
    "display" "GdkDisplay" t t)
   (geometry
    monitor-geometry
    "geometry" "GdkRectangle" t nil)
   (height-mm
    monitor-height-mm
    "height-mm" "gint" t nil)
   (manufacturer
    monitor-manufacturer
    "manufacturer" "gchararray" t nil)
   (model
    monitor-model
    "model" "gchararray" t nil)
   (refresh-rate
    monitor-refresh-rate
    "refresh-rate" "gint" t nil)
   (scale-factor
    monitor-scale-factor
    "scale-factor" "gint" t nil)
   (subpixel-layout
    monitor-subpixel-layout
    "subpixel-layout" "GdkSubpixelLayout" t nil)
   (width-mm
    monitor-width-mm
    "width-mm" "gint" t nil)
   (workarea
    monitor-workarea
    "workarea" "GdkRectangle" t nil)))

#+liber-documentation
(setf (documentation 'monitor 'type)
 "@version{#2020-11-3}
  @begin{short}
    The @sym{gdk:monitor} class represents the individual outputs that are
    associated with a @class{gdk:display} object.
  @end{short}
  The @class{gdk:display} class has APIs to enumerate monitors with the
  functions @fun{gdk:display-n-monitors} and @fun{gdk:display-monitor}, and to
  find particular monitors with the functions @fun{gdk:display-primary-monitor}
  or @fun{gdk:display-monitor-at-window}.

  The @sym{gdk:monitor} class was introduced in GTK+ 3.22 and supersedes earlier
  APIs in the @class{gdk:screen} class to obtain monitor-related information.
  @begin[Signal Details]{dictionary}
    @subheading{The \"invalidate\" signal}
    @begin{pre}
 lambda (monitor)    : Run First
    @end{pre}
    @begin[code]{table}
      @entry[monitor]{The @sym{gdk:monitor} object on which the signal is
        emitted.}
    @end{table}
  @end{dictionary}
  @see-slot{gdk:monitor-display}
  @see-slot{gdk:monitor-geometry}
  @see-slot{gdk:monitor-height-mm}
  @see-slot{gdk:monitor-manufacturer}
  @see-slot{gdk:monitor-model}
  @see-slot{gdk:monitor-refresh-rate}
  @see-slot{gdk:monitor-scale-factor}
  @see-slot{gdk:monitor-subpixel-layout}
  @see-slot{gdk:monitor-width-mm}
  @see-slot{gdk:monitor-workarea}
  @see-class{gdk:display}
  @see-class{gdk:screen}")

;;; ----------------------------------------------------------------------------
;;; Property and Accessor Details
;;; ----------------------------------------------------------------------------

;;; --- monitor-display ----------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "display" 'monitor) t)
 "The @code{display} property of type @class{gdk:display}
  (Read / Write / Construct Only) @br{}
  The display of the monitor.")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-display)
      "Accessor"
      (documentation 'monitor-display 'function)
 "@version{#2020-10-28}
  @syntax[]{(gdk:monitor-display object) => display}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[display]{a @class{gdk:display} object}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{display} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-display} gets the display that the
  monitor belongs to.

  Since 3.22
  @see-class{gdk:monitor}
  @see-class{gdk:display}")

;;; --- monitor-geometry ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "geometry" 'monitor) t)
 "The @code{geometry} property of type @class{gdk:rectangle} (Read) @br{}
  The geometry of the monitor.")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-geometry)
      "Accessor"
      (documentation 'monitor-geometry 'function)
 "@version{#2020-11-3}
  @syntax[]{(gdk:monitor-geometry object) => geometry}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[geometry]{a @class{gdk:rectangle} with the monitor geometry}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{geometry} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-geometry} retrieves the size and
  position of an individual monitor within the display coordinate space. The
  returned geometry is in \"application pixels\", not in \"device pixels\".
  See the function @fun{gdk:monitor-scale-factor} for the internal scale factor
  that maps from monitor coordinates to device pixels.

  Since 3.22
  @see-class{gdk:monitor}
  @see-class{gdk:rectangle}
  @see-function{gdk:monitor-scale-factor}")

;;; --- monitor-height-mm --------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "height-mm" 'monitor) t)
 "The @code{height-mm} property of type @code{:int} (Read) @br{}
  The height of the monitor, in millimeters. @br{}
  Allowed values: >= 0 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-height-mm)
      "Accessor"
      (documentation 'monitor-height-mm 'function)
 "@version{#2020-10-28}
  @syntax[]{(gdk:monitor-height-mm object) => height}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[height]{an integer with the physical height of the monitor}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{height-mm} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-height-mm} gets the height in
  millimeters of the monitor.

  Since 3.22
  @see-class{gdk:monitor}")

;;; --- monitor-manufacturer -----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "manufacturer" 'monitor) t)
 "The @code{manufacturer} property of type @code{:string} (Read) @br{}
  The manufacturer name. @br{}
  Default value: @code{nil}")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-manufacturer)
      "Accessor"
      (documentation 'monitor-manufacturer 'function)
 "@version{#2020-10-28}
  @syntax[]{(gdk:monitor-manufacturer object) => manufacturer}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[manufacturer]{a string with the name of the manufacturer, or
    @code{nil}}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{manufacturer} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-manufacturer} gets the name of the
  monitor's manufacturer, if available.

  Since 3.22
  @see-class{gdk:monitor}")

;;; --- monitor-model ------------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "model" 'monitor) t)
 "The @code{model} property of type @code{:string} (Read) @br{}
  The model name. @br{}
  Default value: @code{nil}")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-model)
      "Accessor"
      (documentation 'monitor-model 'function)
 "@version{#2020-10-28}
  @syntax[]{(gdk:monitor-model object) => model}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[model]{a string with the monitor model, or @code{nil}}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{model} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-model} gets a string identifying
  the monitor model, if available.

  Since 3.22
  @see-class{gdk:monitor}")

;;; --- monitor-refresh-rate -----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "refresh-rate" 'monitor) t)
 "The @code{refresh-rate} property of type @code{:int} (Read) @br{}
  The refresh rate, in millihertz. @br{}
  Allowed values: >= 0 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-refresh-rate)
      "Accessor"
      (documentation 'monitor-refresh-rate 'function)
 "@version{#2020-10-28}
  @syntax[]{(gdk:monitor-refresh-rate object) => refresh-rate}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[refresh-rate]{an integer with the refresh rate in milli-Hertz, or 0}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{refresh-rate} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-refresh-rate} gets the refresh rate
  of the monitor, if available.

  The value is in milli-Hertz, so a refresh rate of 60 Hz is returned as 60000.

  Since 3.22
  @see-class{gdk:monitor}")

;;; --- monitor-scale-factor -----------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "scale-factor" 'monitor) t)
 "The @code{scale-factor} property of type @code{:int} (Read) @br{}
  The scale factor. @br{}
  Allowed values: >= 0 @br{}
  Default value: 1")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-scale-factor)
      "Accessor"
      (documentation 'monitor-scale-factor 'function)
 "@version{#2020-10-28}
  @syntax[]{(gdk:monitor-scale-factor object) => scale-factor}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[scale-factor]{a @code{:int} with the scale factor}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{scale-factor} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-scale-factor} gets the internal
  scale factor that maps from monitor coordinates to the actual device pixels.
  On traditional systems this is 1, but on very high density outputs this can
  be a higher value (often 2).

  This can be used if you want to create pixel based data for a particular
  monitor. But most of the time you are drawing to a window where it is better
  to use the function @fun{gdk:window-scale-factor} instead.

  Since 3.22
  @see-class{gdk:monitor}
  @see-function{gdk:window-scale-factor}")

;;; --- monitor-subpixel-layout --------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "subpixel-layout" 'monitor) t)
 "The @code{subpixel-layout} property of type @symbol{gdk:subpixel-layout}
  (Read) @br{}
  The subpixel layout. @br{}
  Default value: @code{:unknown}")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-subpixel-layout)
      "Accessor"
      (documentation 'monitor-subpixel-layout 'function)
 "@version{#2020-10-28}
  @syntax[]{(gdk:monitor-subpixel-layout object) => layout}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[layout]{a subpixel layout of type @symbol{gdk:subpixel-layout}}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{subpixel-layout} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-subpixel-layout} gets information
  about the layout of red, green and blue primaries for each pixel in this
  monitor, if available.

  Since 3.22
  @see-class{gdk:monitor}
  @see-symbol{gdk:subpixel-layout}")

;;; --- monitor-width-mm ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "width-mm" 'monitor) t)
 "The @code{width-mm} property of type @code{:int} (Read) @br{}
  The width of the monitor, in millimeters. @br{}
  Allowed values: >= 0 @br{}
  Default value: 0")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-width-mm)
      "Accessor"
      (documentation 'monitor-width-mm 'function)
 "@version{#2020-10-28}
  @syntax[]{(gdk:monitor-width-mm object) => width}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[width]{an integer with the physical width of the monitor}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{width-mm} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-width-mm} gets the width in
  millimeters of the monitor.

  Since 3.22
  @see-class{gdk:monitor}")

;;; --- monitor-workarea ---------------------------------------------------

#+liber-documentation
(setf (documentation (liber:slot-documentation "workarea" 'monitor) t)
 "The @code{workarea} property of type @class{gdk:rectangle} (Read) @br{}
  The workarea of the monitor.")

#+liber-documentation
(setf (liber:alias-for-function 'monitor-workarea)
      "Accessor"
      (documentation 'monitor-workarea 'function)
 "@version{#2020-11-3}
  @syntax[]{(gdk:monitor-workarea object) => workarea}
  @argument[object]{a @class{gdk:monitor} object}
  @argument[workarea]{a @class{gdk:rectangle} with the monitor workarea}
  @begin{short}
    Accessor of the @slot[gdk:monitor]{workarea} slot of the
    @class{gdk:monitor} class.
  @end{short}

  The slot access function @sym{gdk:monitor-workarea} retrieves the size and
  position of the \"work area\" on a monitor within the display coordinate
  space. The returned geometry is in \"application pixels\", not in
  \"device pixels\". See the function @fun{gdk:monitor-scale-factor} for the
  internal scale factor that maps from monitor coordinates to device pixels.

  The work area should be considered when positioning menus and similar popups,
  to avoid placing them below panels, docks or other desktop components.

  Note that not all backends may have a concept of workarea. This function will
  return the monitor geometry if a workarea is not available, or does not apply.

  Since 3.22
  @see-class{gdk:monitor}
  @see-class{gdk:rectangle}
  @see-function{gdk:monitor-scale-factor}")

;;; ----------------------------------------------------------------------------
;;; gdk_monitor_is_primary ()
;;; ----------------------------------------------------------------------------

(defcfun ("gdk_monitor_is_primary" monitor-is-primary) :boolean
 #+liber-documentation
 "@version{#2020-10-28}
  @argument[monitor]{a @class{gdk:monitor} object}
  @return{@em{True} if @arg{monitor} is the primary monitor.}
  @begin{short}
    Gets whether the monitor should be considered primary.
  @end{short}
  See the function @fun{gdk:display-primary-monitor}.

  Since 3.22
  @see-class{gdk:monitor}
  @see-function{gdk:display-primary-monitor}"
  (monitor (g:object monitor)))

(export 'monitor-is-primary)

;;; --- End of file gdk3.monitor.lisp ------------------------------------------
