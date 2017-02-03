(require 'cc-mode)

(add-hook 'c-mode-common-hook 'google-set-c-style)

(c-set-offset 'innamespace 0)

(define-key c-mode-base-map (kbd "C-c , ,")
  (lambda () (interactive) (ff-find-other-file t)))

;; enable syntax highlighting for arduino sketches
(add-to-list 'auto-mode-alist '("\\.ino\\'" . c++-mode))

(provide 'init-c)
