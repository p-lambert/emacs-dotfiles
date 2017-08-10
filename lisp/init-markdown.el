(require 'markdown-mode)

;; disable autoindent after pressing RET
(setq markdown-indent-on-enter nil)

(add-hook 'markdown-mode-hook (lambda () (yas-minor-mode)))

;; use vanilla yank function (without indenting after)
(define-key markdown-mode-map (kbd "C-y") 'yank)

(provide 'init-markdown)
