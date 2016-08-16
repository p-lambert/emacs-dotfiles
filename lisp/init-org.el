(require 'org)
(require 'org-attach)

(defvar custom/org-dir (f-long "~/Dropbox/Org"))
(setq org-agenda-files (list custom/org-dir))
(setq org-startup-folded nil)

;; custom tag preset
(setq org-tag-alist
      '(("personal" . ?p)
        ("work" . ?w)
        ("ideas" . ?i)
        ("emacs" . ?m)
        ("events" . ?e)
        ("nyu" . ?n)))

(defun custom/org-toggle-narrowing ()
  (interactive)
  (if (not (buffer-narrowed-p))
      (org-narrow-to-subtree)
    (widen)))

(require 'init-org-code)
(require 'init-org-files)

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
