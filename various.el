;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.
(require 'breadcrumb)
(defun bookmark-and-jump-to-def ()
  (interactive)
  ; Add to bookmark to list
  (bc-set)
  (rope-goto-definition)
  )


(provide 'various)