(require 'f)

(defvar custom/org-dir "~/Dropbox/Org/")

;; load all org files
(when (file-directory-p custom/org-dir)
  (--> custom/org-dir
       (f-entries it (lambda (file) (string-match-p "\\.org$" file)) t)
       (setq org-user-agenda-files it)))

(provide 'init-org)
