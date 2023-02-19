;;;; gtk3-demo.lisp

(asdf:defsystem :gtk3-demo
  :author "Dieter Kaiser"
  :license "LLGPL"
  :serial t
  :depends-on (:gtk3-example
               :pango-example
               :cairo-example)
  :components ((:file "package")
               (:file "gtk3-demo")))

;;; --- 2023-2-12 --------------------------------------------------------------