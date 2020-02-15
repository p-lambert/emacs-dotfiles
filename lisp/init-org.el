(require 'org)
(require 'org-attach)
(require 'org-bullets)

(defvar custom/org-dir "~/Dropbox/Org")

(setq org-agenda-files (list custom/org-dir)
      org-default-notes-file (expand-file-name "notes.org" custom/org-dir)
      org-startup-folded nil
      org-startup-indented t
      org-agenda-compact-blocks t
      org-agenda-skip-scheduled-if-done t
      org-ellipsis " ↴"
      org-agenda-use-time-grid nil)

;; custom tag preset
(setq org-tag-alist
      '(("personal" . ?p)
        ("work" . ?w)
        ("ideas" . ?i)
        ("emacs" . ?m)
        ("study" . ?s)
        ("events" . ?e)
        ("nyu" . ?n)
        ("note" . ?o)
        ))

;; capture templates
(setq org-capture-templates
      `(("t" "todo" entry (file "")
         "* TODO %?\n%U\n" :clock-resume t)
        ("n" "note" entry (file "")
         "* %? :note:\n%U\n%a\n" :clock-resume t)
        ("s" "study" entry (file "")
         "* TODO Learn about =%?= :study:\n%U\n" :clock-resume t)
        ))

;; agenda displays configurations
(setq org-agenda-prefix-format
      `((agenda . " %i %?-12t% s")
       (timeline . "  % s")
       (todo . " %i")
       (tags . " %i %-12:c")
       (search . " %i %-12:c")))

;; custom agenda commands
(setq org-agenda-custom-commands
      '(("p" todo :ALL
         ((org-agenda-files (list org-default-notes-file))))))

;; enable bullets
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(require 'init-org-code)
(require 'init-org-files)
(require 'init-org-defuns)

(global-set-key (kbd "C-c ]") 'custom/ivy-org-files)
(global-set-key (kbd "C-c [") 'custom/org-open-project-file)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c C-a") 'org-agenda-list)
(global-set-key (kbd "C-c C-t") 'org-todo-list)
(global-set-key (kbd "C-c M-l") 'org-store-link)

(define-key org-mode-map (kbd "C-c C-k") 'custom/copy-line)
(define-key org-mode-map (kbd "C-c f") 'org-attach-open-in-emacs)
(define-key org-mode-map (kbd "C-x C-n") 'custom/org-toggle-narrowing)
(define-key org-mode-map (kbd "C-c [") 'previous-buffer)
(define-key org-mode-map (kbd "C-c ]") 'custom/ivy-org-files)
(define-key org-mode-map (kbd "C-M-k") 'org-cut-subtree)

(provide 'init-org)
