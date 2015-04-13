(require 'smartparens)
(require 'smartparens-config)

(smartparens-global-mode t)

;; kill sexp
(define-key sp-keymap (kbd "C-M-k") 'sp-kill-hybrid-sexp)

(sp-with-modes '(ruby-mode)
  (sp-local-pair "|" "|"))

(provide 'init-smartparens)
