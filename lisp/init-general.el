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
 ;; don't display any messages on scratch buffer
 initial-scratch-message nil
 ;; add newline character to the end of file
 require-final-newline t
 ;; set file for custom variables
 custom-file (expand-file-name "custom.el" user-emacs-directory)
 ;; use consistent syntax on regexp-builder
 reb-re-syntax 'string
 )

;; enable protected commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; don't bother with local variable safety
(setq enable-local-variables :all)

(provide 'init-general)
