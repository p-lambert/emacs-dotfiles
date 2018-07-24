(defun custom/import-env-var (name)
  (let* ((cmd (format ". ~/.bashrc; echo -n $%s" name))
         (var (shell-command-to-string cmd)))
    (setenv name var)))

(custom/import-env-var "PATH")
(custom/import-env-var "GOPATH")
(custom/import-env-var "DATADOG_ROOT")
(custom/import-env-var "GITLAB_TOKEN")

;; setup PATH
(setq exec-path
      (append (split-string-and-unquote (getenv "PATH") ":") exec-path))

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
