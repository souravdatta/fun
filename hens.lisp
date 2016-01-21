(defpackage #:hens
  (:use :cl)
  (:export :*state* :*goal-state* :solve))

(in-package #:hens)

(defparameter *state* '((Farmer Fox Hen Grains)
			()))

(defparameter *goal-state* '(() (Farmer Fox Hen Grains)))

(defun bad-state-p (state)
  (or (bad-state-side-p (first state))
      (bad-state-side-p (second state))))


(defun bad-state-side-p (side)
  (and
   (not (member 'farmer side))
   (or (and (member 'fox side)
	    (member 'hen side))
       (and (member 'hen side)
	    (member 'grains side)))))


(defun transfer-right (state sym)
  (if (not (eql sym 'farmer))
      (list (set-difference (first state) (list 'farmer sym))
	    (union (second state) (list 'farmer sym)))))


(defun transfer-left (state sym)
  (if (not (eql sym 'farmer))
      (list (union (first state) (list 'farmer sym)) 
	    (set-difference (second state) (list 'farmer sym)))))


(defun return-farmer (state direction)
  (case direction
    (:left (list (union (first state) (list 'farmer))
		 (set-difference (second state) (list 'farmer))))
    (:right (list (set-difference (first state) (list 'farmer))
		  (union (second state) (list 'farmer))))))


(defun state-equal-p (s1 s2)
  (and (member-wise-equal-p (first s1) (first s2))
       (member-wise-equal-p (second s1) (second s2))))


(defun member-wise-equal-p (l1 l2)
  (and (= (length l1)
	  (length l2))
       (every #'(lambda (x) (not (eql x nil)))
	      (fn:for ((x l1))
		      (member x l2)))
       (every #'(lambda (y) (not (eql y nil)))
	      (fn:for ((y l2))
		      (member y l1)))))


(defun all-moves (state state-stack)
  (fn:filter #'(lambda (x) (and (not (member x state-stack :test #'state-equal-p))
				(not (bad-state-p x))))
	     (if (member 'farmer (first state))
		 (fn:for ((x (first state) (not (eql x 'farmer))))
			 (transfer-right state x))
		 (cons
		  (return-farmer state :left)
		  (fn:for ((x (second state) (not (eql x 'farmer))))
			  (transfer-left state x))))))


(defun solve-from (start-state goal-state stack)
  (let ((moves (all-moves start-state stack)))
    (cond
      ((null moves) nil)
      ((some #'(lambda (s) (state-equal-p s goal-state)) moves) (reverse (cons goal-state stack)))
      (t (some #'(lambda (s) (solve-from s goal-state (cons s stack))) moves)))))


(defun solve (&optional (start-state *state*) (goal-state *goal-state*))
  (solve-from start-state goal-state (list start-state)))


		
