(require 'f)
(require 'projectile)
(require 'helm)

(defvar custom/org-dir (f-long "~/Dropbox/Org"))

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

(global-set-key (kbd "C-c [") 'custom/helm-org-files)
(global-set-key (kbd "C-c ]") 'custom/org-open-project-file)

(provide 'init-org)
