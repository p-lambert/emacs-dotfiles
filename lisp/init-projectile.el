(require 'projectile)
(require 'helm-projectile)

(global-set-key (kbd "C-x f") 'helm-projectile)

(projectile-global-mode)

(setq projectile-completion-system 'helm)

(setq projectile-switch-project-action 'projectile-dired)

(setq helm-projectile-sources-list
      '(helm-source-projectile-buffers-list helm-source-projectile-files-list))

;; ignore .gems directory
(add-to-list 'projectile-globally-ignored-directories ".gems")

(defun custom/projectile-eshell ()
  "Open an eshell buffer at project's root directory."
  (interactive)
  (let ((shell-dir (projectile-project-root))
        (shell-title (format "*eshell [%s]*" (projectile-project-name))))
    (other-window 1)
    (if (get-buffer shell-title)
        (switch-to-buffer (get-buffer shell-title))
      (switch-to-buffer (generate-new-buffer shell-title))
      (eshell-mode)
      (goto-char (point-max))
      (insert (format "cd %s" shell-dir))
      (eshell-send-input))))

(provide 'init-projectile)
