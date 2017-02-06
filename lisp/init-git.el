(require 'magit)
(require 'git-timemachine)

(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g c") 'magit-checkout)
(global-set-key (kbd "C-c g b") 'magit-show-refs-popup)
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

(global-set-key (kbd "C-c g m") 'custom/branch-changelog)

(provide 'init-git)
