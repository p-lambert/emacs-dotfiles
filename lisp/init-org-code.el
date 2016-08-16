(require 'org-src)

(defvar custom/org-langs '(ruby sh))

(setq org-src-fontify-natively t
      org-src-preserve-indentation nil
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 0)

;; don't prompt for code evaluation
(setq org-confirm-babel-evaluate nil)

;; load org-babel support for specified languages
(->> custom/org-langs
     (--map (cons it t))
     (org-babel-do-load-languages 'org-babel-load-languages))

(provide 'init-org-code)
