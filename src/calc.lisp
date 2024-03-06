					; curl -O https://beta.quicklisp.org/quicklisp.lisp
					; curl -O https://beta.quicklisp.org/quicklisp.lisp.asc
					; sbcl --load quicklisp.lisp
					; (quicklisp-quickstart:install)

					;after installation
					; (load "~/quicklisp/setup.lisp")
(ql:quickload :ltk)
(ql:quickload :asdf)
(in-package :ltk-user)

(require 'asdf)

(defun add_number(num cur-num oper first-num label)
  (let ((new-cur (+ (* cur-num 10) num)))
    (handler-case
	(when (not (null oper))
          (setf (text label) (format nil "~f~%" (funcall oper first-num new-cur))))
      (division-by-zero () (setf (text label) "devidion by zero")))
    new-cur))

(defmacro number-buttons(f cur-num oper first-num label)
  `(progn ,(loop :for num from -1 to 10
                 :collect  (if (equal num -1)
                               `progn
                             `(set (intern ,(format nil "b~a" num))
                                   (make-instance 'button
						  :master ,f
						  :text ,(format nil "~a" num)
						  :command (lambda () (progn (setf ,cur-num (add_number ,num ,cur-num ,oper ,first-num ,label))
									     (format t "~a~&", num)))))))
          (progn ,@(let ((num 0))
		     (loop :for i from 1 to 5
			   :append (loop :for j from 1 to 3
					 :until (equal num 10)
					 :collect `(grid (symbol-value (intern ,(format nil "b~a" num))) ,i ,j :sticky :e)
					 :do (setf num (+ num 1))))))))
					; (macroexpand '(number-buttons 1 2 3 4 5))

(defmacro operation-buttons(f first-num cur-num oper)
  (let ((opers (list (cons #'+ "+")
                     (cons #'- "-")
                     (cons #'* "*")
                     (cons #'/ "/")))
        (num 0))
    `(progn ,@(mapcar (lambda (o)
			(progn
                          (setf num (+ num 1))
                          `(progn
                             (set (intern ,(format nil "b~a" (cdr o)))
                                  (make-instance 'button
                                                 :master ,f
                                                 :text ,(cdr o)
                                                 :command (lambda () (progn (setf ,oper ,(car o))
									    (setf ,first-num ,cur-num)
									    (setf ,cur-num 0)
									    (format t "~a~&" ,(cdr o))))))
                             (grid (symbol-value (intern ,(format nil "b~a" (cdr o)))) ,num 4  :sticky :e))))
                      opers))))
					; (macroexpand '(operation-buttons 1 2 3 4))


(defun main()
  (with-ltk ()
	    (let* ((first-num 0)
		   (cur-num 0)
		   (oper nil)
		   (f (make-instance 'frame))
		   (label (make-instance 'label
					 :master f
					 :text ""))
		   (clear (make-instance 'button
					 :master f
					 :text "clear"
					 :command (lambda () (progn (setf first-num 0)
								    (setf cur-num 0)
								    (setf oper nil)
								    (setf (text label) "")
								    (format t "clear~&"))))))
              (grid f 0 0
                    :sticky :n
                    :padx 3
                    :pady 3
                    :rowspan 3)
              (grid label 0 1)
              (grid clear 0 4)
              (operation-buttons f first-num cur-num oper)
              (number-buttons f cur-num oper first-num label))))
