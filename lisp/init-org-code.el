(require 'org-src)

(setq org-src-fontify-natively t
      org-src-preserve-indentation nil
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

;; don't prompt for code evaluation
(setq org-confirm-babel-evaluate nil)

(provide 'init-org-code)
