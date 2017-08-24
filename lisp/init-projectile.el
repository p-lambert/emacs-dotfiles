(require 'projectile)
(require 'helm-projectile)

(projectile-global-mode)

(global-set-key (kbd "C-x f") 'helm-projectile)
(global-set-key (kbd "C-x C-d") 'projectile-dired)

(defvar custom/projectile-blacklist '(".gems" "log" "tmp" "vendor"))

(setq
 projectile-completion-system 'helm
 projectile-switch-project-action 'projectile-dired)

(setq helm-projectile-sources-list
      '(helm-source-projectile-buffers-list helm-source-projectile-files-list))

(dolist (ignored custom/projectile-blacklist)
        (add-to-list 'projectile-globally-ignored-directories ignored))

(defun custom/projectile-eshell ()
  "Open an eshell buffer at project's root directory."
  (interactive)
  (if (projectile-project-p)
      (let* ((shell-dir (projectile-project-root))
             (shell-title (format "*eshell [%s]*" (projectile-project-name)))
             (cmd (format "cd %s; clear" shell-dir))
             (buffer (or (get-buffer shell-title)
                         (custom/run-eshell-command shell-title cmd))))
        (other-window 1)
        (switch-to-buffer buffer))
    (eshell)))

(provide 'init-projectile)
