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

(defmacro n()
  (loop :for num from 0 to 3
                :collect (if (equal num 0)
                            `progn
                            `(set (intern ,(format nil "b~a" num)) ,num)))
  (let ((num -1))
    (loop :for i from 1 to 2
            :append (loop :for j from 1 to 2
                          :until (equal num 10)
                          :collect (if (equal num -1)
                                      `progn
                                      `(print (intern ,(format nil "b~a" num))))
                          :do (setf num (+ num 1))))))

(defun run-n()
  (n))

(defmacro number-buttons(f cur-num oper first-num label)
  `(let ,(loop :for num from 0 to 10
                :collect `( ,(format nil "b~a" num)
                            (make-instance 'button
                                    :master ,f
                                    :text ,(format nil "~a" num)
                                    :command (lambda () (progn (setf ,cur-num (add_number ,num ,cur-num ,oper ,first-num ,label)) 
                                                              (format t "~a~&", num))))))
        ,(let ((num -1))
              (loop :for i from 1 to 4
                      :append (loop :for j from 1 to 5
                                    :until (equal num 10)
                                    :collect (if (equal num -1)
                                                `progn
                                                `(grid ,(format nil "b~a" num) ,i ,j :sticky :e))
                                    :do (setf num (+ num 1)))))))
; (macroexpand '(number-buttons 1 2 3 4 5))

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
                                                        (format t "/~&"))))))
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
          (number-buttons f cur-num oper first-num label))))