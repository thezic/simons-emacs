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
;;(global-auto-complete-mode t)



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
;; pybufswitch
(require 'pybufswitch)
;; Column numbers
(setq column-number-mode t)
;; Highlight column 80 in python mode
(require 'column-marker)
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-3 80)))

;; Keyboard bindings
(global-set-key (kbd "M-<right>") 'next-py-buf)
(global-set-key (kbd "M-<left>") 'prev-py-buf)
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
 '(column-number-mode t)
 '(majmodpri-sort-after-load (quote (chart gpl django-html-mumamo nxhtml-autoload javascript-mode)))
 '(mouse-wheel-progressive-speed nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
 '(inhibit-startup-screen t)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "#c0c0c0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 92 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
