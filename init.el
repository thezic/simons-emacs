(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d")

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

;; nxHtml
(load "~/.emacs.d/plugins-nr/nxhtml/autostart.el")

;; python
;; (add-hook 'python-mode-hook guess-style-guess-tabs-mode)
;;    (add-hook 'python-mode-hook (lambda ()
;;                                   (when indent-tabs-mode
;;                                     (guess-style-guess-tab-width)))

;; Smart-tabs
(require 'smart-tab)

;; yasnippet
(require 'yasnippet-bundle)

(require 'python)

;(require 'yasnippet)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Initialize Pymacs                                                                                           
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;; Initialize Rope                                                                                             
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; Autocomplete
;;     (require 'auto-complete)
;;     (require 'auto-complete-config)
;;     (global-auto-complete-mode t)
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)

;; Line numbers
(require 'linum)
(global-set-key (kbd "<f6>") 'linum-mode)

;; comment region
(global-set-key (kbd "C-;") 'comment-dwim)

;; run Django shell when editing Django Python code
(defun get-file-in-upstream-dir (location filename)
  (let* ((dir (file-name-directory location))
         (path (concat dir filename)))
    (if (file-exists-p path)
        path
      (if (not (equal dir "/"))
        (get-file-in-upstream-dir (expand-file-name (concat dir "../")) filename)))))

(defadvice run-python (before possibly-setup-django-project-environment)
  (let* ((settings-py (get-file-in-upstream-dir buffer-file-name "settings.py"))
         (project-dir (file-name-directory settings-py)))
    (if settings-py
        (progn
          (setenv "DJANGO_SETTINGS_MODULE" "settings")
          (setenv "PYTHONPATH" project-dir)))))


;; Highlight paranteses
(require 'highlight-parentheses)
(defun turn-on-highlight-parentheses-mode ()
  (highlight-parentheses-mode t))
(define-global-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  turn-on-highlight-parentheses-mode)
(global-highlight-parentheses-mode)
(setq hl-paren-background-colors '("green"))

;; javascript mode
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;; my various functions
(require 'various)
;; breadcrumbs
(require 'breadcrumb)

;; bitlbee
(require 'bitlbee)

(defvar bitlbee-password "geheim")
 
 (add-hook 'erc-join-hook 'bitlbee-identify)
 (defun bitlbee-identify ()
   "If we're on the bitlbee server, send the identify command to the 
 &bitlbee channel."
   (when (and (string= "localhost" erc-session-server)
              (string= "&bitlbee" (buffer-name)))
     (erc-message "PRIVMSG" (format "%s identify %s" 
                                    (erc-default-target) 
                                    bitlbee-password))))

;; (add-to-hook 'erc-insert-modify-hook 'mah/maybe-wash-im-with-w3m)
;;   (autoload 'w3m-region "w3m" "Render region using w3m")
;;   (defun mah/maybe-wash-im-with-w3m ()
;;     "Wash the current im with emacs-w3m."
;;     (save-restriction
;;       (with-current-buffer (current-buffer)
;;         (let ((case-fold-search t))
;; 	  (goto-char (point-min))
;; 	  (when (re-search-forward "<HTML>.*</HTML>" nil t)
;; 	    (print (match-string 0))
;; 	    (narrow-to-region (match-beginning 0) (match-end 0))
;; 	    (let ((w3m-safe-url-regexp mm-w3m-safe-url-regexp)
;; 		  w3m-force-redisplay)
;; 	      (w3m-region (point-min) (point-max))
;; 	      (goto-char (point-max))
;; 	      (delete-char -2))
;; 	    (when (and mm-inline-text-html-with-w3m-keymap
;; 		       (boundp 'w3m-minor-mode-map)
;; 		       w3m-minor-mode-map)
;; 	      (add-text-properties
;; 	       (point-min) (point-max)
;; 	       (list 'keymap w3m-minor-mode-map
;; 		     ;; Put the mark meaning this part was rendered by emacs-w3m.
;; 		     'mm-inline-text-html-with-w3m t))))))))

;; Keyboard bindings
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "C-M-<SPC>") 'speedbar)
(global-set-key (kbd "<RET>") 'newline-and-indent)

(global-set-key [(meta j)] 'bookmark-and-jump-to-def)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)(global-set-key [(shift meta j)] 'bc-previous)

(put 'scroll-left 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(majmodpri-sort-after-load (quote (chart gpl django-html-mumamo nxhtml-autoload javascript-mode))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
