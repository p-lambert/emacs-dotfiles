(require 'f)
(require 'projectile)
(require 'ivy)

(defun custom/org-get-filenames ()
  (when (file-directory-p custom/org-dir)
    (--> custom/org-dir
         (f-entries it (lambda (file) (string-match-p "\\.org$" file)) t)
         (--map (f-base it) it)
         (sort it 'string-lessp))))

(defun custom/org-file-path (name)
  (let ((org-file (format "%s.org" name)))
    (f-join custom/org-dir org-file)))

(defun custom/org-open-project-file ()
  (interactive)
  (let* ((link (f-join (projectile-project-root) ".project.org"))
         (try-link (and (f-exists? link) link))
         (default-file (custom/org-file-path (projectile-project-name))))
    (find-file (or try-link default-file))))

;; create a ivy prompt displaying all my .org files
(defun custom/ivy-org-files ()
  (interactive)
  (ivy-read "org notes: " (custom/org-get-filenames)
            :action (lambda (file) (find-file (custom/org-file-path file)))))

(provide 'init-org-files)
