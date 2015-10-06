(require 'multiple-cursors)

(global-set-key (kbd "C-c m l") 'mc/edit-lines)
(global-set-key (kbd "C-c m m") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-c m a") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m r") 'mc/set-rectangular-region-anchor)

;; commands to run for all cursors
(setq mc/cmds-to-run-for-all
      '(custom/smart-move-beginning-of-line
        custom/yank-and-indent
        kill-region
        mark-sexp
        sp-forward-sexp))

(provide 'init-multiple-cursors)
