(require 'magit)
(require 'git-timemachine)
(require 'git-link)
(require 's)

(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g f") 'magit-log-buffer-file)
(global-set-key (kbd "C-c g t") 'git-timemachine)
(global-set-key (kbd "C-c g B") 'magit-blame)

;; disable magit startup message
(setq magit-last-seen-setup-instructions "1.4.0")

(setq magit-pull-arguments '("--rebase" "--no-tags"))
(setq magit-fetch-arguments '("--no-tags" "--prune"))

(defun custom/branch-changelog ()
  (interactive)
  (let ((default-directory (magit-toplevel))
        (cmd "git log --format='* %s' origin/master..HEAD"))
    (kill-new (shell-command-to-string cmd))
    (message "Changelog copied to kill-ring.")))

(defun custom/branch-name ()
  (cond ((projectile-project-p)
         (let* ((git-branch-cmd "/usr/bin/env git branch --show-current")
                (branch-name (s-chomp (shell-command-to-string git-branch-cmd))))
           (if (s-blank? branch-name)
               (substring (shell-command-to-string "/usr/bin/env git rev-parse HEAD") 0 7)
             branch-name)))
        (vc-mode (substring vc-mode 5))))

(defun custom/git-branch-cache-purge ()
  (setq custom/git-branch-cache (make-hash-table :test 'eq)))
(custom/git-branch-cache-purge)

(defvar custom/git-branch-cache-ttl 10
  "Amount of time in seconds that we should cache the branch name")

(defun custom/git-mode-line ()
  (let* ((now (current-time))
         (key (current-buffer))
         (cached (gethash key custom/git-branch-cache))
         (expiry (car cached))
         (branch (cdr cached)))
    (unless (and cached (time-less-p now expiry))
      (setq branch (custom/branch-name))
      (puthash key
               (cons (time-add now custom/git-branch-cache-ttl) branch)
               custom/git-branch-cache))
    (if (s-blank? branch)
        ""
      (concat " @ " branch))))

;; force cache expiration when magit re-renders
(add-hook 'magit-pre-refresh-hook 'custom/git-branch-cache-purge)

(global-set-key (kbd "C-c g m") 'custom/branch-changelog)
(global-set-key (kbd "C-c g b") 'magit-checkout)
(global-set-key (kbd "C-c g l") 'git-link)

(provide 'init-git)
