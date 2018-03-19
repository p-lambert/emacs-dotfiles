(require 'go-mode)
(require 'gotest)
(require 's)
(require 'f)

;; requires go get -u golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")
;; requires go get -u github.com/zmb3/gogetdoc
(setq godoc-at-point-function #'godoc-gogetdoc)

(add-hook 'before-save-hook 'gofmt-before-save)

(defun custom/go-run ()
  (interactive)
  (if (s-suffix? "_test.go" buffer-file-name)
      (go-test-current-file)
    (quickrun)))

(defvar custom/go-test-use-vagrant 't)

(defun custom/go-test-wrapper (orig-fun &rest args)
  (let ((pwd (f-relative default-directory (getenv "GOPATH")))
        (orig-cmd (apply orig-fun args)))
    (if custom/go-test-use-vagrant
        (format "ssh vagrant -t \"bash -l -c \\\"cd go/%s; %s\\\"\"" pwd orig-cmd)
      cmd)))

(advice-add 'go-test--get-program :around #'custom/go-test-wrapper)

(define-key go-mode-map (kbd "C-c 0") 'custom/go-run)
(define-key go-mode-map (kbd "C-c , a") 'go-test-current-project)
(define-key go-mode-map (kbd "C-c , f") 'go-test-current-file)
(define-key go-mode-map (kbd "C-c ? .") 'godoc-at-point)
(define-key go-mode-map (kbd "C-c ? p") (lambda () (interactive) (godoc (symbol-name (symbol-at-point)))))

(provide 'init-go)
