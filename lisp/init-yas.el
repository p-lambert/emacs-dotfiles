(require 'yasnippet)

(setq yas-snippet-dirs (list (expand-file-name "snippets" user-emacs-directory)))

(yas-reload-all)

;; enable yas only on certain modes instead of using it globally
(add-hook 'prog-mode-hook #'yas-minor-mode)

(defvar custom/yas-guess-mode nil)
(defadvice yas-new-snippet (before custom/yas-guess-mode activate)
  (setq custom/yas-guess-mode (symbol-name major-mode)))

(defun custom/yas-save-snippet ()
  "Automatically save snippet under the correct directory."
  (interactive)
  (if buffer-file-name
      (save-buffer)
    (let (mode key location)
      (save-excursion
        (beginning-of-buffer)
        (search-forward-regexp "key: \\([a-z-_]+\\)")
        (setq key (match-string 1)))

      (setq mode (read-string "Snippet mode: " custom/yas-guess-mode))
      (setq key (or key (read-string "Snippet key: ")))
      (setq location (format "%s/%s/%s" yas-snippet-dirs mode key))

      (write-file location)))
  (yas-reload-all))

(defun custom/yas-dired ()
  (interactive)
  (dired yas-snippet-dirs))

(define-key snippet-mode-map (kbd "C-x C-s") 'custom/yas-save-snippet)
(global-set-key (kbd "C-c y n") 'yas-new-snippet)
(global-set-key (kbd "C-c y t") 'yas-describe-tables)
(global-set-key (kbd "C-c y l") 'custom/yas-dired)

(provide 'init-yas)
