(require 'comint)

(defun custom/comint-clear-buffer ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

(define-key comint-mode-map (kbd "C-c C-o") 'custom/comint-clear-buffer)

(provide 'init-comint)
