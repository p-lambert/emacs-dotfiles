(require 'helm-config)
(require 'helm-ag)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "s-f") 'custom/helm-interactive-search)
(global-set-key (kbd "C-h a") 'helm-apropos)

(setq helm-quick-update t
      helm-buffers-fuzzy-matching t
      helm-buffer-max-length 45
      helm-buffer-details-flag nil
      helm-display-header-line nil)

(defun custom/helm-interactive-search (this-file-only-p)
  (interactive "P")
  (if this-file-only-p
      (let ((current-prefix-arg nil))
        (helm-do-ag-this-file))
    (helm-do-ag)))

;; disable helm mode-line
(with-eval-after-load 'helm
 (defun helm-display-mode-line (&rest _)
   (setq mode-line-format nil)))

(provide 'init-helm)
