(require 'rainbow-delimiters)

(add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
(define-key emacs-lisp-mode-map (kbd "C-c C-j") 'xref-find-definitions)

(provide 'init-elisp)
