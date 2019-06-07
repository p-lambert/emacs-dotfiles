(require 'projectile)
(require 'helm-projectile)

(projectile-global-mode)

(global-set-key (kbd "C-x f") 'helm-projectile)
(global-set-key (kbd "C-x C-d") 'projectile-dired)

(defvar custom/projectile-blacklist '(".gems" "log" "tmp" "vendor"))

(setq
 projectile-completion-system 'helm
 projectile-switch-project-action 'custom/projectile-switch-action)

(defun custom/projectile-switch-action ()
  (let ((screen (custom/elscreen-from-nickname (projectile-project-name))))
    (if screen
        (elscreen-goto screen)
      (elscreen-clone)
      (elscreen-screen-nickname (projectile-project-name))
      (projectile-dired)
      (delete-other-windows))))

(setq helm-projectile-sources-list
      '(helm-source-projectile-buffers-list helm-source-projectile-files-list))

(dolist (ignored custom/projectile-blacklist)
        (add-to-list 'projectile-globally-ignored-directories ignored))

(provide 'init-projectile)
