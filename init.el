(add-to-list 'load-path "~/.emacs.d/plugins")

(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
          (let* ((my-lisp-dir "~/.emacs.d/plugins/")
		               (default-directory my-lisp-dir))
	               (setq load-path (cons my-lisp-dir load-path))
		                  (normal-top-level-add-subdirs-to-load-path)))

(require 'color-theme)
(eval-after-load "color-theme"
		   '(progn
		           (color-theme-initialize)
			        (color-theme-hober)))

