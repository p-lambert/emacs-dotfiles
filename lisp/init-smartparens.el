(require 'smartparens-config)

(smartparens-global-mode t)

;; kill sexp
(define-key sp-keymap (kbd "C-M-k") 'sp-kill-sexp)

;; sexp movements
(define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)

(sp-with-modes '(ruby-mode)
  (sp-local-pair "|" "|"))

;; parens display
(setq sp-show-pair-delay 0)
(setq sp-show-pair-from-inside t)

(set-face-attribute 'sp-pair-overlay-face nil :inherit nil)

(add-hook 'lisp-mode-hook 'show-smartparens-mode)
(add-hook 'emacs-lisp-mode-hook 'show-smartparens-mode)

(provide 'init-smartparens)
