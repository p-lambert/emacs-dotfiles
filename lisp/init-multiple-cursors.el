(setq mc/always-run-for-all t)

(require 'multiple-cursors)

(global-set-key (kbd "C-c m l") 'mc/edit-lines)
(global-set-key (kbd "C-c m m") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m r") 'mc/set-rectangular-region-anchor)

(provide 'init-multiple-cursors)
