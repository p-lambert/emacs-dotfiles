(require 'projectile)
(require 'helm-projectile)

(projectile-global-mode)

(global-set-key (kbd "C-x f") 'helm-projectile)
(global-set-key (kbd "C-x C-d") 'projectile-dired)
(global-set-key (kbd "s-f") 'projectile-ag)

(defvar custom/projectile-blacklist '(".gems" "log" "tmp" "vendor"))

(setq
 projectile-completion-system 'helm
 projectile-switch-project-action 'projectile-dired)

(setq helm-projectile-sources-list
      '(helm-source-projectile-buffers-list helm-source-projectile-files-list))

(dolist (ignored custom/projectile-blacklist)
        (add-to-list 'projectile-globally-ignored-directories ignored))

;; add `perspective` integration
;; (require 'perspective)
;; (persp-mode)
;; (require 'persp-projectile)

(provide 'init-projectile)
