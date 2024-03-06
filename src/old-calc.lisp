					; curl -O https://beta.quicklisp.org/quicklisp.lisp
					; curl -O https://beta.quicklisp.org/quicklisp.lisp.asc
					; sbcl --load quicklisp.lisp
					; (quicklisp-quickstart:install)
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
								    (format t "clear~&")))))
		   (b+ (make-instance 'button
				      :master f
				      :text "+"
				      :command (lambda () (progn (setf oper #'+)
								 (setf first-num cur-num)
								 (setf cur-num 0)
								 (format t "+~&")))))
		   (b- (make-instance 'button
				      :master f
				      :text "-"
				      :command (lambda () (progn (setf oper #'-)
								 (setf first-num cur-num)
								 (setf cur-num 0)
								 (format t "-~&")))))
		   (b* (make-instance 'button
				      :master f
				      :text "*"
				      :command (lambda () (progn (setf oper #'*)
								 (setf first-num cur-num)
								 (setf cur-num 0)
								 (format t "*~&")))))
		   (b/ (make-instance 'button
				      :master f
				      :text "/"
				      :command (lambda () (progn (setf oper #'/)
								 (setf first-num cur-num)
								 (setf cur-num 0)
								 (format t "/~&")))))
		   (b1 (make-instance 'button
				      :master f
				      :text "1"
				      :command (lambda () (progn (setf cur-num (add_number 1 cur-num oper first-num label))
								 (format t "1~&")))))
		   (b2 (make-instance 'button
				      :master f
				      :text "2"
				      :command (lambda () (progn (setf cur-num (add_number 2 cur-num oper first-num label))
								 (format t "2~&")))))
		   (b3 (make-instance 'button
				      :master f
				      :text "3"
				      :command (lambda () (progn (setf cur-num (add_number 3 cur-num oper first-num label))
								 (format t "3~&")))))
		   (b4 (make-instance 'button
				      :master f
				      :text "4"
				      :command (lambda () (progn (setf cur-num (add_number 4 cur-num oper first-num label))
								 (format t "4~&")))))
		   (b5 (make-instance 'button
				      :master f
				      :text "5"
				      :command (lambda () (progn (setf cur-num (add_number 5 cur-num oper first-num label))
								 (format t "5~&")))))
		   (b6 (make-instance 'button
				      :master f
				      :text "6"
				      :command (lambda () (progn (setf cur-num (add_number 6 cur-num oper first-num label))
								 (format t "6~&")))))
		   (b7 (make-instance 'button
				      :master f
				      :text "7"
				      :command (lambda () (progn (setf cur-num (add_number 7 cur-num oper first-num label))
								 (format t "7~&")))))
		   (b8 (make-instance 'button
				      :master f
				      :text "8"
				      :command (lambda () (progn (setf cur-num (add_number 8 cur-num oper first-num label))
								 (format t "8~&")))))
		   (b9 (make-instance 'button
				      :master f
				      :text "9"
				      :command (lambda () (progn (setf cur-num (add_number 9 cur-num oper first-num label))
								 (format t "9~&")))))
		   (b0 (make-instance 'button
				      :master f
				      :text "0"
				      :command (lambda () (progn (setf cur-num (add_number 0 cur-num oper first-num label))
								 (format t "0~&"))))))
	      (grid f 0 0
		    :sticky :n
		    :padx 3
		    :pady 3
		    :rowspan 3)
	      (grid label 0 1)
	      (grid clear 0 4)
	      (grid b+ 1 4  :sticky :e)
	      (grid b- 2 4  :sticky :e)
	      (grid b* 3 4  :sticky :e)
	      (grid b/ 4 4  :sticky :e)
	      (grid b1 1 1 :sticky :e)
	      (grid b2 1 2 :sticky :e)
	      (grid b3 1 3 :sticky :e)
	      (grid b4 2 1 :sticky :e)
	      (grid b5 2 2 :sticky :e)
	      (grid b6 2 3 :sticky :e)
	      (grid b7 3 1 :sticky :e)
	      (grid b8 3 2 :sticky :e)
	      (grid b9 3 3 :sticky :e)
	      (grid b0 4 2 :sticky :e))))
