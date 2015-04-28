(require 'dired)

(defun custom/dired-open ()
  (interactive)
  (let ((file (dired-get-filename)))
    (if (file-directory-p file)
        (dired-find-alternate-file)
      (dired-find-file))))

(define-key dired-mode-map (kbd "RET") 'custom/dired-open)

;; disable buffer trail left by directory navigation
(put 'dired-find-alternate-file 'disabled nil)

(provide 'init-dired)
