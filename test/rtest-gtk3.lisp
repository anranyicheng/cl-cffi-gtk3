(defpackage :gtk-test
  (:use :fiveam :cffi :common-lisp)
  (:export #:run!)
  (:import-from :glib)
  (:import-from :gobject)
  (:import-from :gio)
  (:import-from :gtk)
  (:import-from :gdk))

(in-package :gtk-test)

(defvar *first-run-gtk-test* t)

(def-suite gtk-test)
(def-suite gtk-suite :in gtk-test)
(def-suite gdk-suite :in gtk-test)

;; Ensure directory for the output of test results
(eval-when (:compile-toplevel :load-toplevel :execute)
  (ensure-directories-exist
      (asdf:system-relative-pathname :cl-cffi-gtk3 "test/out/")))

;; Get the pathname for a file in the testsuite
(defun sys-path (filename &optional (system :cl-cffi-gtk3))
  (asdf:system-relative-pathname system
                                 (concatenate 'string "test/" filename)))

;; See https://www.embeddeduse.com/2019/08/26/qt-compare-two-floats/
(defun approx-equal (x y &optional (eps-factor 1.0d-1))
  (or (< (abs (- x y)) eps-factor)
      (< (abs (- x y)) (* eps-factor (max (abs x) (abs y))))))


(defun list-children (gtype)
  (sort (mapcar #'g:type-name (g:type-children gtype))
        #'string<))

(defun list-interfaces (gtype)
  (mapcar #'g:type-name (g:type-interfaces gtype)))

;; A sorted list of the class property names without inherited properties
(defun list-properties (gtype)
  (sort (set-difference (mapcar #'g:param-spec-name
                                (g:object-class-list-properties gtype))
                        (mapcar #'g:param-spec-name
                                (g:object-class-list-properties
                                  (g:type-parent gtype)))
                        :test #'string=)
        #'string<))

(defun list-interface-properties (gtype)
  (mapcar #'g:param-spec-name
          (g:object-interface-list-properties gtype)))

(defun list-interface-prerequisites (gtype)
  (mapcar #'g:type-name
          (g:type-interface-prerequisites gtype)))

;; A sorted list of the class style property names without inherited properties
(defun list-style-properties (gtype)
  (sort (set-difference (mapcar #'g:param-spec-name
                                (gtk:widget-class-list-style-properties gtype))
                        (mapcar #'g:param-spec-name
                                (gtk:widget-class-list-style-properties
                                  (g:type-parent gtype)))
                        :test #'string=)
        #'string<))

;; A sorted list of the class child property names
(defun list-child-properties (gtype)
  (sort (mapcar #'g:param-spec-name
                (gtk:container-class-list-child-properties gtype))
        #'string<))

;; A sorted list of the signal names of a class
(defun list-signals (gtype)
  (sort (mapcar #'g:signal-name
                (g:signal-list-ids gtype)) #'string<))

(defun list-flags-item-name (gtype)
  (mapcar #'gobject:flags-item-name
          (gobject:get-flags-items gtype)))

(defun list-flags-item-nick (gtype)
  (mapcar #'gobject:flags-item-nick
          (gobject:get-flags-items gtype)))

(defun list-flags-item-value (gtype)
  (mapcar #'gobject:flags-item-value
          (gobject:get-flags-items gtype)))

(defun list-enum-item-name (gtype)
  (mapcar #'gobject:enum-item-name
          (gobject:get-enum-items gtype)))

(defun list-enum-item-nick (gtype)
  (mapcar #'gobject:enum-item-nick
          (gobject:get-enum-items gtype)))

(defun list-enum-item-value (gtype)
  (mapcar #'gobject:enum-item-value
          (gobject:get-enum-items gtype)))

;;; --- 2023-7-19 --------------------------------------------------------------
