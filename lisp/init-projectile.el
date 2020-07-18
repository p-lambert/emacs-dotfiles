(require 'projectile)

(projectile-global-mode)

(global-set-key (kbd "C-x f") 'counsel-projectile-find-file)
(global-set-key (kbd "C-x b") 'counsel-projectile-switch-to-buffer)
(global-set-key (kbd "C-x C-d") 'projectile-dired)
(global-set-key (kbd "C-c p p") 'projectile-switch-project)
(global-set-key (kbd "C-c p d") 'counsel-projectile-find-dir)
(global-set-key (kbd "C-c p s") 'projectile-ag)

(defvar custom/projectile-blacklist '(".gems" "log" "tmp" "vendor"))

(setq
 projectile-completion-system 'ivy
 projectile-switch-project-action 'custom/projectile-switch-action
 projectile-git-submodule-command nil
 projectile-mode-line-function 'projectile-project-name)

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

(dolist (ignored custom/projectile-blacklist)
        (add-to-list 'projectile-globally-ignored-directories ignored))

(provide 'init-projectile)
