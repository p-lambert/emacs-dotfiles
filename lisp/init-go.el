(require 'go-mode)
(require 'gotest)
(require 's)

(defun custom/go-run ()
  (interactive)
  (if (s-suffix? "_test.go" buffer-file-name)
      (go-test-current-test)
    (let ((command (format "go run %s" buffer-file-name)))
      (compile command))))

(define-key go-mode-map (kbd "C-c 0") 'custom/go-run)
(define-key go-mode-map (kbd "C-c , a") 'go-test-current-project)
(define-key go-mode-map (kbd "C-c , f") 'go-test-current-file)

(provide 'init-go)
