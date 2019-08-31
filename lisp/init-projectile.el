(require 'projectile)
(require 'helm-projectile)

(projectile-global-mode)

(global-set-key (kbd "C-x f") 'helm-projectile)
(global-set-key (kbd "C-x C-d") 'projectile-dired)
(global-set-key (kbd "C-c p p") 'projectile-switch-project)
(global-set-key (kbd "C-c p d") 'helm-projectile-find-dir)
(global-set-key (kbd "C-c p s") 'projectile-ag)

(defvar custom/projectile-blacklist '(".gems" "log" "tmp" "vendor"))

(setq
 projectile-completion-system 'helm
 projectile-switch-project-action 'custom/projectile-switch-action)

(defun custom/projectile-switch-action ()
  (setq custom/disable-buffer-switch-advice 't)
  (let ((project-screen (custom/elscreen-from-nickname (projectile-project-name)))
        (current-screen-name (elscreen-get-screen-nickname (elscreen-get-current-screen))))
    (cond ((string-equal current-screen-name (projectile-project-name))
           (projectile-dired))
          (project-screen (progn
                    (elscreen-goto project-screen)
                    (message (custom/elscreen-message))))
          (t (progn
               (elscreen-clone)
               (elscreen-screen-nickname (projectile-project-name))
               (projectile-dired)
               (delete-other-windows)))))
  (setq custom/disable-buffer-switch-advice nil))

(setq helm-projectile-sources-list
      '(helm-source-projectile-buffers-list helm-source-projectile-files-list))

(dolist (ignored custom/projectile-blacklist)
        (add-to-list 'projectile-globally-ignored-directories ignored))

(provide 'init-projectile)
