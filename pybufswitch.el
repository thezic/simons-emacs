;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Switch to next python bffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun next-py-buf ()
  (interactive)
  (let ((sb (current-buffer))
	(found nil))
    (while (progn
	     (next-buffer)
	     (message "%s" (current-buffer))
	     (let ((buf-name (buffer-name (current-buffer))))
	       (when (string-match "\.py$" buf-name)
		 (setq found t)
		 ))
	     (not (or (eq found t) (eq sb (current-buffer))))))))

(defun prev-py-buf ()
  (interactive)
  (let ((sb (current-buffer))
	(found nil))
    (while (progn
	     (previous-buffer)
	     (let ((buf-name (buffer-name (current-buffer))))
	       (when (string-match "\.py$" buf-name)
		 (setq found t)
		 ))
	     (not (or (eq found t) (eq sb (current-buffer))))))))


(provide 'pybufswitch)