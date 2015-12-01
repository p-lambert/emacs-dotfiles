(require 'projectile)
(require 'helm-projectile)

(global-set-key (kbd "C-x f") 'helm-projectile)
(global-set-key (kbd "C-x C-d") 'projectile-dired)

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

;; overwrite original `projectile-completing-read` with cleaner helm buffer
(defun projectile-completing-read (prompt choices &optional initial-input)
  "Present a project tailored PROMPT with CHOICES."
  (let ((prompt (projectile-prepend-project-name prompt)))
    (helm-comp-read prompt choices
                    :initial-input initial-input
                    :candidates-in-buffer t
                    :must-match 'confirm
                    :buffer "*Project List*"
                    :mode-line ""
                    :name "Project List")))

(provide 'init-projectile)
