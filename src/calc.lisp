; (load "quicklisp.lisp")
; (quicklisp-quickstart:install)
(ql:quickload :ltk)
(ql:quickload :asdf)
(in-package :ltk-user)

(require 'asdf)

(with-ltk ()                                                
             (grid                                             
               (make-instance 'button :text "Hello World")     
               0 0))  