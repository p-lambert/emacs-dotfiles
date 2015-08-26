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
  (let* ((shell-dir (projectile-project-root))
         (shell-title (format "*eshell [%s]*" (projectile-project-name)))
         (cmd (format "cd %s; clear" shell-dir))
         (buffer (or (get-buffer shell-title)
                     (custom/run-eshell-command shell-title cmd))))
    (other-window 1)
    (switch-to-buffer buffer)))

(provide 'init-projectile)
