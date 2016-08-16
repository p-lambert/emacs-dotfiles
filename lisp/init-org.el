(require 'f)
(require 'projectile)
(require 'helm)
(require 'org)
(require 'org-attach)

(defvar custom/org-dir (f-long "~/Dropbox/Org"))
(setq org-agenda-files (list custom/org-dir))
(setq org-startup-folded nil)

(defun custom/org-get-filenames ()
  (when (file-directory-p custom/org-dir)
    (--> custom/org-dir
         (f-entries it (lambda (file) (string-match-p "\\.org$" file)) t)
         (--map (f-base it) it)
         (sort it 'string-lessp))))

(defun custom/org-file-path (name)
  (let ((org-file (format "%s.org" name)))
    (f-join custom/org-dir org-file)))

(defun custom/org-open-project-file (&optional name)
  (interactive)
  (let ((filename (or name (projectile-project-name))))
    (find-file (custom/org-file-path filename))))

;; create a helm buffer displaying all my .org files
(defun custom/helm-org-files ()
  "Display all files under `custom/org-dir` inside a helm buffer."
  (interactive)
  (helm :sources (custom/helm-org-files-source)
        :buffer "*My Org Files*"))

(defun custom/helm-org-files-source ()
  (helm-build-sync-source "My Org Files"
    :candidates (custom/org-get-filenames)
    :action '(("Open file" . custom/org-open-project-file))))

(defun custom/org-toggle-narrowing ()
  (interactive)
  (if (not (buffer-narrowed-p))
      (org-narrow-to-subtree)
    (widen)))

(require 'init-org-code)

(global-set-key (kbd "C-c [") 'custom/helm-org-files)
(global-set-key (kbd "C-c ]") 'custom/org-open-project-file)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c M-l") 'org-store-link)

(define-key org-mode-map (kbd "C-c C-k") 'custom/copy-line)
(define-key org-mode-map (kbd "C-c f") 'org-attach-open-in-emacs)
(define-key org-mode-map (kbd "C-c f") 'org-attach-open-in-emacs)
(define-key org-mode-map (kbd "C-x C-n") 'custom/org-toggle-narrowing)

(provide 'init-org)
