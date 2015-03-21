(setq
 ;; default directory
 default-directory (concat (getenv "HOME") "/Code/")
 ;; disable backup files
 make-backup-files nil
 auto-save-default nil
 backup-inhibited t
)

(provide 'init-general)
