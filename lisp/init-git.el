(require 'magit)
(require 'git-timemachine)

(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g c") 'magit-checkout)
(global-set-key (kbd "C-c g b") 'magit-branch-manager)
(global-set-key (kbd "C-c g t") 'git-timemachine)

;; disable magit startup message
(setq magit-last-seen-setup-instructions "1.4.0")

(provide 'init-git)