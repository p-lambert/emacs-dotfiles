(require 'magit)
(require 'magit-gh-pulls)
(require 'git-timemachine)
(require 's)

(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)

(global-set-key (kbd "C-c g g") 'magit-status)
(global-set-key (kbd "C-c g f") 'magit-log-buffer-file)
(global-set-key (kbd "C-c g t") 'git-timemachine)
(global-set-key (kbd "C-c g l") 'vc-annotate)

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

(defun custom/github-copy-shareable-url ()
  "Copies to kill-ring a shareable GitHub URL for the line the
point is currently at."
  (interactive)
  (-when-let* ((branch (magit-get-current-branch))
              (repo (magit-gh-pulls-guess-repo))
              (fpath (magit-current-file))
              (user (car repo))
              (repo-name (cdr repo))
              (urlpath (concat "/" user "/" repo-name "/blob/" branch "/" fpath))
              (line (line-number-at-pos))
              (urlattr (concat "L" (number-to-string line)))
              (url (url-parse-make-urlobj
                    "https" nil nil "github.com" nil urlpath urlattr nil t)))
    (message (kill-new (url-recreate-url url)))))

(global-set-key (kbd "C-c g m") 'custom/branch-changelog)
(global-set-key (kbd "C-c g b") 'magit-checkout)
(global-set-key (kbd "C-c g l") 'custom/github-copy-shareable-url)

(provide 'init-git)
