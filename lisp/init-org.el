(require 'org)
(require 'org-attach)

(defvar custom/org-dir "~/Dropbox/Org")

(setq org-agenda-files (list custom/org-dir)
      org-default-notes-file (expand-file-name "notes.org" custom/org-dir)
      org-startup-folded nil)

;; custom tag preset
(setq org-tag-alist
      '(("personal" . ?p)
        ("work" . ?w)
        ("ideas" . ?i)
        ("emacs" . ?m)
        ("events" . ?e)
        ("nyu" . ?n)
        ))

(require 'init-org-code)
(require 'init-org-files)
(require 'init-org-defuns)

(global-set-key (kbd "C-c [") 'custom/helm-org-files)
(global-set-key (kbd "C-c ]") 'custom/org-open-project-file)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c M-l") 'org-store-link)

(define-key org-mode-map (kbd "C-c C-k") 'custom/copy-line)
(define-key org-mode-map (kbd "C-c f") 'org-attach-open-in-emacs)
(define-key org-mode-map (kbd "C-c f") 'org-attach-open-in-emacs)
(define-key org-mode-map (kbd "C-x C-n") 'custom/org-toggle-narrowing)
(define-key org-mode-map (kbd "C-c [") nil)
(define-key org-mode-map (kbd "C-c ]") 'previous-buffer)

(provide 'init-org)
