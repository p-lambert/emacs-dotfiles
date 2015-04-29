(require 'magit)

(global-set-key (kbd "C-c g") 'magit-status)

;; disable magit startup message
(setq magit-last-seen-setup-instructions "1.4.0")

(provide 'init-magit)
