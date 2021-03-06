;; make indentation commands use space only
(setq-default indent-tabs-mode nil)

(setq word-wrap t)
(setq-default fill-column 80)
(setq-default tab-width 4)

;; whitespace display
(global-whitespace-mode)

(setq whitespace-global-modes
      '(not magit-mode
            magit-status-mode
            magit-diff-mode
            magit-revision-mode
            git-commit-mode
            dired-mode
            web-mode
            vterm-mode
            org-mode
            markdown-mode))

(setq whitespace-style
      '(face
        trailing
        identation::space
        lines-tail))

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

(provide 'init-whitespace)
