(require 'helm-config)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-quick-update t
      helm-buffers-fuzzy-matching t
      helm-buffer-max-length 25)

(provide 'init-helm)
