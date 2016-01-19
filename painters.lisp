(defun draw (painter)
  (funcall painter))

(defun make-painter (psym &rest painters)
  (cond
    ((null painters) #'(lambda (&rest params) (cons psym (mapcar #'(lambda (p) (if (consp p) p (cons :param p))) params))))
    (t #'(lambda (&rest params) (append (cons psym (mapcar #'draw painters)) (mapcar #'(lambda (p) (if (consp p) p (cons :param p))) params))))))

(defun painter-params (painter &rest params)
  (if (null params) painter #'(lambda () (apply painter params))))

(defun flipped-vert (painter) (make-painter 'flipped-v painter))

(defun flipped-horiz (painter) (make-painter 'flipped-h painter))

(defun beside (painter1 painter2) (make-painter 'beside painter1 painter2))

(defun below (painter1 painter2) (make-painter 'below painter1 painter2))

(defun right-split (painter w h)
  (cond
    ((or (< w 1) (< h 1)) (painter-params painter '(width . 0) '(height . 0)))
    (t (beside
	(painter-params painter (cons 'width (/ w 2)) (cons 'height h))
	(below
	 (painter-params painter (cons 'width (/ w 2)) (cons 'height 1))
	 (right-split painter (/ w 2) (- h 1)))))))



