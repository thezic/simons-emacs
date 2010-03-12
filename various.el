
(require 'breadcrumb)
(defun bookmark-and-jump-to-def ()
  (interactive)
  ; Add to bookmark to list
  (bc-set)
  (rope-goto-definition)
  )

(provide 'various)