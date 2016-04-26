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

;; make indentation commands use space only
(setq-default indent-tabs-mode nil)

;; whitespace display
(global-whitespace-mode)

(setq whitespace-global-modes
      '(not magit-mode git-commit-mode dired-mode web-mode org-mode))

(setq whitespace-style
      '(
        face
        trailing
        tabs
        identation::space
        lines-tail
        ))

(defun custom/toggle-whitespace-removal ()
  (interactive)
  (if (member 'delete-trailing-whitespace before-save-hook)
      (progn
        (remove-hook 'before-save-hook 'delete-trailing-whitespace)
        (message "Remove trailing whitespace DISABLED."))
    (add-hook 'before-save-hook 'delete-trailing-whitespace)
    (message "Remove trailing whitespace ENABLED.")))

;; automatic whitespace removal
(custom/toggle-whitespace-removal)

(provide 'init-general)
