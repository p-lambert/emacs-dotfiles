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
 )

;; make indentation commands use space only
(setq-default indent-tabs-mode nil)

;; whitespace display
(global-whitespace-mode)

(setq whitespace-global-modes
      '(not magit-mode git-commit-mode))

(setq whitespace-style
      '(
        face
        trailing
        tabs
        identation::space
        lines-tail
        ))

(provide 'init-general)
