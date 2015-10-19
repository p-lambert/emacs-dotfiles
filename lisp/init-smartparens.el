(require 'smartparens-config)

(smartparens-global-mode t)

(sp-pair "'"  nil :actions :rem)
(sp-pair "\"" nil :actions :rem)
(sp-pair "("  nil :actions :rem)

;; kill sexp
(define-key sp-keymap (kbd "C-M-k") 'sp-kill-sexp)

;; sexp movements
(define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
(define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)

;; parens display
(setq sp-show-pair-delay 0)
(setq sp-show-pair-from-inside t)

(set-face-attribute 'sp-pair-overlay-face nil :inherit nil)

;; enable smartparens display for certain modes
(dolist (mode '(lisp-mode-hook emacs-lisp-mode-hook clojure-mode-hook))
  (add-hook mode 'show-smartparens-mode))

(provide 'init-smartparens)
