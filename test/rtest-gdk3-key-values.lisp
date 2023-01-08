(in-package :gtk-test)

(def-suite gdk-key-values :in gdk-suite)
(in-suite gdk-key-values)

(defparameter *verbose-gdk-key-values* nil)

;;;     GdkKeymap

(test keymap-class
  ;; Type check
  (is (g:type-is-object "GdkKeymap"))
  ;; Check the registered name
  (is (eq 'gdk:keymap
          (gobject:symbol-for-gtype "GdkKeymap")))
  ;; Check the type initializer
  (is (eq (g:gtype "GdkKeymap")
          (g:gtype (cffi:foreign-funcall "gdk_keymap_get_type" :size))))
  ;; Check the parent
  (is (eq (g:gtype "GObject")
          (g:type-parent "GdkKeymap")))
  ;; Check the children
  #-windows
  (is (or (member "GdkX11Keymap" (list-children "GdkKeymap") :test #'string=)
          (member "GdkWaylandKeymap" (list-children "GdkKeymap") :test #'string=)))
  #+windows
  (is (equal '("GdkWin32Keymap")
             (list-children "GdkKeymap")))
  ;; Check the interfaces
  (is (equal '()
             (list-interfaces "GdkKeymap")))
  ;; Check the class properties
  (is (equal '()
             (list-properties "GdkKeymap")))
  ;; Check the signals
  (is (equal '("direction-changed" "keys-changed" "state-changed")
             (list-signals "GdkKeymap")))
  ;; Check the class definition
  (is (equal '(DEFINE-G-OBJECT-CLASS "GdkKeymap" GDK-KEYMAP
                       (:SUPERCLASS G-OBJECT :EXPORT T :INTERFACES NIL
                        :TYPE-INITIALIZER "gdk_keymap_get_type")
                       NIL)
             (gobject:get-g-type-definition "GdkKeymap"))))

;;;     GdkKeymapKey

;;;   gdk_keymap_get_default

(test -keymap-default
  (is (typep (gdk:keymap-default) 'gdk:keymap)))

;;;   gdk_keymap_get_for_display

(test keymap-for-display
  (let ((display (gdk:display-default)))
    (is (typep (gdk:keymap-for-display display) 'gdk:keymap))))

;;;   gdk_keymap_lookup_key

;; TODO: Seems not to work as expected on Windows. Check this again.

#-windows
(test keymap-lookup-key
  (let ((keymap (gdk:keymap-for-display (gdk:display-default))))
    (with-foreign-object (key '(:struct gdk::keymap-key))
      (setf (cffi:foreign-slot-value key
                                     '(:struct gdk::keymap-key)
                                     'gdk::keycode) 35)
      (setf (cffi:foreign-slot-value key
                                     '(:struct gdk::keymap-key)
                                     'gdk::group) 0)
      (setf (cffi:foreign-slot-value key
                                     '(:struct gdk::keymap-key)
                                     'gdk::level) 0)
      (is (= 43 (gdk::%keymap-lookup-key keymap key))))
    (with-foreign-object (key '(:struct gdk::keymap-key))
      (setf (gdk::keymap-key-keycode key) 35)
      (setf (gdk::keymap-key-group key) 0)
      (setf (gdk::keymap-key-level key) 1)
      (is (= 42 (gdk::%keymap-lookup-key keymap key))))
    (is (=  43 (gdk:keymap-lookup-key keymap 35 0 0)))
    (is (=  42 (gdk:keymap-lookup-key keymap 35 0 1)))
    (is (= 126 (gdk:keymap-lookup-key keymap 35 0 2)))
    (is (= 175 (gdk:keymap-lookup-key keymap 35 0 3)))))

;;;     gdk_keymap_translate_keyboard_state

;; TODO: Seems not to work as expected on Windows. Check this again.

#-windows
(test keymap-translate-keyboard-state
  (let ((keymap (gdk:keymap-for-display (gdk:display-default))))
    ;; The key "+" with the name "plus"
    (is (equal '(43 0 0 NIL)
               (multiple-value-list
                   (gdk:keymap-translate-keyboard-state keymap
                                                        35
                                                        0
                                                        0))))
    ;; The key "-" with the name "minus"
    (is (equal '(42 0 1 (:SHIFT-MASK))
               (multiple-value-list
                   (gdk:keymap-translate-keyboard-state keymap
                                                        35
                                                        :shift-mask
                                                        0))))
    ;; The key "~" with the name "asciitilde"
    (is (equal '(126 0 2 (:MOD5-MASK))
               (multiple-value-list
                   (gdk:keymap-translate-keyboard-state keymap
                                                        35
                                                        :mod5-mask
                                                        0))))))

;;;     gdk_keymap_get_entries_for_keyval

;; TODO: Seems not to work as expected on Windows. Check this again.

#+nil
(test keymap-entries-for-keyval
  (let ((keymap (gdk:keymap-for-display (gdk:display-default)))
        (keyval 126))
    (with-foreign-objects ((keys :pointer) (n-keys :int))
      (when (gdk::%keymap-entries-for-keyval keymap keyval keys n-keys)
        (when *verbose-gdk-key-values*
          (format t "~%GDK-KEYMAP-ENTRIES-FOR-KEYVAL~%")
          (format t " keyval : ~a~%" keyval)
          (format t "   keys : ~a~%" keys)
          (format t " n-keys : ~a~%" (cffi:mem-ref n-keys :int)))
        (let ((keys (cffi:mem-ref keys :pointer))
              (n-keys (cffi:mem-ref n-keys :int)))
          (loop for i from 0 below n-keys
                for key = (cffi:mem-aptr keys '(:struct gdk::keymap-key) i)
                collect (list (gdk::keymap-key-keycode key)
                              (gdk::keymap-key-group key)
                              (gdk::keymap-key-level key))
                finally (g:free keys)
                do (when *verbose-gdk-key-values*
                     (format t "keycode : ~a~%" (gdk::keymap-key-keycode key))
                     (format t "  group : ~a~%" (gdk::keymap-key-group key))
                     (format t "  level : ~a~%" (gdk::keymap-key-level key)))))))
    (is (equal '((35 0 0)) (gdk:keymap-entries-for-keyval keymap 43)))
    (is (equal '((35 0 1)) (gdk:keymap-entries-for-keyval keymap 42)))
    (is (equal '((35 0 2)) (gdk:keymap-entries-for-keyval keymap 126)))
    (is (equal '((35 0 3)) (gdk:keymap-entries-for-keyval keymap 175)))))

;;;     gdk_keymap_get_entries_for_keycode

;; TODO: Seems not to work as expected on Windows. Check this again.

#-windows
(test keymap-entries-for-keycode
  (let ((keymap (gdk:keymap-for-display (gdk:display-default))))
    (with-foreign-objects ((keys :pointer) (keyvals :pointer) (n-keys :int))
      (when (gdk::%keymap-entries-for-keycode keymap
                                                  35
                                                  keys
                                                  keyvals
                                                  n-keys)
        (when *verbose-gdk-key-values*
          (format t "~%GDK-KEYMAP-ENTRIES-FOR-KEYCODE~%")
          (format t "   keys : ~a~%" keys)
          (format t "keyvals : ~a~%" keyvals)
          (format t " n-keys : ~a~%" (cffi:mem-ref n-keys :int)))
        (let ((keys (cffi:mem-ref keys :pointer))
              (keyvals (cffi:mem-ref keyvals :pointer))
              (n-keys (cffi:mem-ref n-keys :int)))
          (loop for i from 0 below n-keys
                for keyval = (cffi:mem-aref keyvals :uint i)
                for key = (cffi:mem-aptr keys '(:struct gdk::keymap-key) i)
                collect (list keyval
                              (list (gdk::keymap-key-keycode key)
                                    (gdk::keymap-key-group key)
                                    (gdk::keymap-key-level key)))
                finally (g:free keys)
                        (g:free keyvals)
                do (when *verbose-gdk-key-values*
                     (format t " keyval : ~a~%" keyval)
                     (format t "    key : ~a~%" key)
                     (format t "keycode : ~a~%" (gdk::keymap-key-keycode key))
                     (format t "  group : ~a~%" (gdk::keymap-key-group key))
                     (format t "  level : ~a~%" (gdk::keymap-key-level key)))))))
    (is (equal '((43 35 0 0) (43 35 0 1) (43 35 0 2) (43 35 0 3) (43 35 1 0)
                 (43 35 1 1) (43 35 1 2) (43 35 1 3))
               (gdk:keymap-entries-for-keycode keymap 35)))))

;;;     gdk_keymap_get_direction

(test keymap-direction
  (is (eq :ltr (gdk:keymap-direction (gdk:keymap-default)))))

;;;     gdk_keymap_have_bidi_layouts

(test keymap-have-bidi-layouts
  (is-false (gdk:keymap-have-bidi-layouts (gdk:keymap-default))))

;;;     gdk_keymap_get_caps_lock_state

(test keymap-caps-lock-state
  (is-false (gdk:keymap-caps-lock-state (gdk:keymap-default))))

;;;     gdk_keymap_get_num_lock_state

(test keymap-num-lock-state
  ;; TODO: Last value was TRUE, 2023-1-8
  (is-false (gdk:keymap-num-lock-state (gdk:keymap-default))))

;;;     gdk_keymap_get_scroll_lock_state

(test keymap-scroll-lock-state
  (is-false (gdk:keymap-scroll-lock-state (gdk:keymap-default))))

;;;     gdk_keymap_get_modifier_state

(test keymap-modifier-state
  #-windows
  (is (equal '()
             (gdk:keymap-modifier-state (gdk:keymap-default))))
  #+windows
  (is (equal '()
             (gdk:keymap-modifier-state (gdk:keymap-default)))))

;;;     gdk_keymap_add_virtual_modifiers

(test keymap-add-virtual-modifiers
  (let ((keymap (gdk:keymap-for-display (gdk:display-default))))
    #-windows
    (is (equal '(:MOD4-MASK :SUPER-MASK :HYPER-MASK)
               (gdk:keymap-add-virtual-modifiers keymap '(:mod4-mask))))
    #+windows
    (is (equal '(:MOD4-MASK)
               (gdk:keymap-add-virtual-modifiers keymap '(:mod4-mask))))))

;;;     gdk_keymap_map_virtual_modifiers

(test keymap-map-virtual-modifiers
  (let ((keymap (gdk:keymap-for-display (gdk:display-default))))
    (is (equal '((:SUPER-MASK) T)
               (multiple-value-list
                 (gdk:keymap-map-virtual-modifiers keymap '(:super-mask)))))))

;;;     gdk_keymap_get_modifier_mask

(test keymap-modifier-mask
  (let ((keymap (gdk:keymap-for-display (gdk:display-default))))
    (is (equal '(:control-mask)
               (gdk:keymap-modifier-mask keymap :primary-accelerator)))
    (is (equal '()
               (gdk:keymap-modifier-mask keymap :context-menu)))
    (is (equal '(:SHIFT-MASK)
               (gdk:keymap-modifier-mask keymap :extend-selection)))
    (is (equal '(:CONTROL-MASK)
               (gdk:keymap-modifier-mask keymap :modify-selection)))
    (is (equal '(:CONTROL-MASK :MOD1-MASK)
               (gdk:keymap-modifier-mask keymap :no-text-input)))
    (is (equal '()
               (gdk:keymap-modifier-mask keymap :shift-group)))
    (is (equal '(:SHIFT-MASK :CONTROL-MASK :MOD1-MASK :SUPER-MASK
                 :HYPER-MASK :META-MASK)
               (gdk:keymap-modifier-mask keymap :default-mod-mask)))))

;;;     gdk_keyval_name

(test keyval-name
  (is (string= "A" (gdk:keyval-name 65)))
  (is (string= "B" (gdk:keyval-name 66))))

;;;     gdk_keyval_from_name

(test keyval-from-name
  (is (= 65 (gdk:keyval-from-name "A")))
  (is (= 66 (gdk:keyval-from-name "B"))))

;;;     gdk_keyval_convert_case

(test keyval-convert-case
  (is (= 97 (gdk:keyval-convert-case 65))))

;;;     gdk_keyval_to_upper

(test keyval-to-upper
  (is (= 65 (gdk:keyval-to-upper 97))))

;;;     gdk_keyval_to_lower

(test keyval-to-lower
  (is (= 97 (gdk:keyval-to-lower 65))))

;;;     gdk_keyval_is_upper

(test keyval-is-upper
  (is-true  (gdk:keyval-is-upper (gdk:keyval-from-name "A")))
  (is-false (gdk:keyval-is-upper (gdk:keyval-from-name "a"))))

;;;     gdk_keyval_is_lower

(test keyval-is-lower
  (is-true  (gdk:keyval-is-upper (gdk:keyval-from-name "A")))
  (is-false (gdk:keyval-is-upper (gdk:keyval-from-name "a"))))

;;;     gdk_keyval_to_unicode

(test keyval-to-unicode
  (is (eq #\A  (gdk:keyval-to-unicode (gdk:keyval-from-name "A")))))

;;;     gdk_unicode_to_keyval

(test unicode-to-keyval
  (is (eq 65 (gdk:unicode-to-keyval #\A))))

;;; --- 2023-1-8 ---------------------------------------------------------------
