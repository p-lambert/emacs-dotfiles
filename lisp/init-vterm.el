;; this library requires cmake and libtool-bin
(require 'vterm)

(global-set-key (kbd "C-c t t") 'projectile-run-vterm)
(define-key vterm-mode-map (kbd "C-c t t") 'previous-buffer)

(provide 'init-vterm)
