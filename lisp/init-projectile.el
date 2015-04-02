(require 'projectile)
(require 'helm-projectile)

(global-set-key (kbd "C-x f") 'helm-projectile)

(projectile-global-mode)

(setq projectile-completion-system 'helm)

(setq projectile-switch-project-action 'helm-projectile-find-file)

(setq helm-projectile-sources-list '(helm-source-projectile-buffers-list
				     helm-source-projectile-files-list))

(setq projectile-mode-line
      '(:eval (format " Proj[%s]" (projectile-project-name))))

(provide 'init-projectile)
