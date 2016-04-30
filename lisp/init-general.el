;; import PATH environment variable
(let ((path (shell-command-to-string ". ~/.bashrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append (split-string-and-unquote path ":") exec-path)))

(setq
 ;; default directory
 default-directory (concat (getenv "HOME") "/Code/")
 ;; disable backup files
 make-backup-files nil
 auto-save-default nil
 backup-inhibited t
 ;; don't display byte-compile warnings
 warning-minimum-level :emergency
 )

;; enable protected commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(provide 'init-general)
