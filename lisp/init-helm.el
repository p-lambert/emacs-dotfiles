(require 'helm-config)
(require 'helm-ag)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "s-f") 'helm-do-ag)

(setq helm-quick-update t
      helm-buffers-fuzzy-matching t
      helm-buffer-max-length 45
      helm-buffer-details-flag nil
      helm-display-header-line nil)

;; disable helm mode-line
(with-eval-after-load 'helm
 (defun helm-display-mode-line (&rest _)
   (setq mode-line-format nil)))

(provide 'init-helm)
