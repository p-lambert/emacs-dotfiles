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
  (let ((default-directory (projectile-project-root))
        (shell-title (concat "*eshell [" (projectile-project-name) "]*")))
    (other-window 1)
    (switch-to-buffer (get-buffer-create shell-title))
    (eshell-mode)))

(provide 'init-projectile)
