(require 'magit)
(require 'magit-gh-pulls)
(require 'git-timemachine)
(require 'helm)
(require 's)

(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g c") 'magit-checkout)
(global-set-key (kbd "C-c g f") 'magit-log-buffer-file)
(global-set-key (kbd "C-c g t") 'git-timemachine)
(global-set-key (kbd "C-c g l") 'vc-annotate)

;; disable magit startup message
(setq magit-last-seen-setup-instructions "1.4.0")

;; make pull --rebase default
(setq magit-pull-arguments '("--rebase"))

(defun custom/branch-changelog ()
  (interactive)
  (let ((default-directory (magit-toplevel))
        (cmd "git log --format='* %s' origin/master..HEAD"))
    (kill-new (shell-command-to-string cmd))
    (message "Changelog copied to kill-ring.")))

(defun custom/git-branches ()
  (projectile-with-default-dir (projectile-project-root)
    (--> (shell-command-to-string "/usr/bin/env git branch")
         (s-split "\n" it t))))

(defun custom/helm-git-branches ()
  "Display a list of git branches"
  (interactive)
  (helm :sources (custom/helm-git-branches-source)
        :buffer "*Git Branches*"))

(defun custom/helm-git-branches-source ()
  (helm-build-sync-source (format "Git Branches [%s]" (projectile-project-name))
    :candidates (custom/git-branches)
    :action '(("Switch to branch" .
               (lambda (name) (magit-checkout (substring name 2)))))))

(global-set-key (kbd "C-c g m") 'custom/branch-changelog)
(global-set-key (kbd "C-c g b") 'custom/helm-git-branches)

(provide 'init-git)
