(require 'dired)
(require 's)
(require 'f)

(defvar custom/dired-default-directory "~/Code/")

(defun custom/dired-open ()
  (interactive)
  (let ((file (ignore-errors (dired-get-filename))))
    (if (or (not file) (file-directory-p file))
        (dired-find-alternate-file)
      (dired-find-file))))

(defun custom/dired-create-file (name)
  (interactive (list (read-string "File name: ")))
  (let ((clean-name (s-trim name)))
    (if (or (s-blank? clean-name)
            (f-exists? clean-name))
        (message "Invalid file name!")
      (shell-command (format "touch %s" clean-name))
      (revert-buffer)
      (goto-char (point-min))
      (search-forward clean-name)
      (backward-word))))

(define-key dired-mode-map (kbd "RET") 'custom/dired-open)
(define-key dired-mode-map (kbd "C-l") 'dired-up-directory)
(define-key dired-mode-map (kbd "c") 'custom/dired-create-file)

;; disable buffer trail left by directory navigation
(put 'dired-find-alternate-file 'disabled nil)

;; use GNU ls for dired
(setq insert-directory-program "gls")

;; always suggest custom/dired-default-directory
(defun custom/dired ()
  (interactive)
  (let ((default-directory custom/dired-default-directory))
    (call-interactively 'dired)))

(global-set-key (kbd "C-x d") 'custom/dired)

(provide 'init-dired)
