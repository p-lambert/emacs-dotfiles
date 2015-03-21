;; movement and editing
(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))

;; window and buffer manipulation
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "M-k") 'kill-buffer)

(provide 'init-keybindings)
