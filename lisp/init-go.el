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

(defun custom/go-function-callers ()
  (interactive)
  (save-excursion
    (go-goto-function-name)
    (let ((func-name (format "%s\\(.*\\)" (thing-at-point 'symbol))))
      (projectile-ag func-name 't))))

(defun custom/go-find-test-or-implementation (other-window-p)
  (interactive "P")
  (if other-window-p
      (projectile-find-implementation-or-test-other-window)
    (projectile-toggle-between-implementation-and-test)))

(advice-add 'go-test--get-program :around #'custom/go-test-wrapper)

(define-key go-mode-map (kbd "C-c 0") 'custom/go-run)
(define-key go-mode-map (kbd "C-c p t") 'custom/go-find-test-or-implementation)
(define-key go-mode-map (kbd "C-c , a") 'go-test-current-project)
(define-key go-mode-map (kbd "C-c , f") 'go-test-current-file)
(define-key go-mode-map (kbd "C-c , .") 'go-test-current-test)
(define-key go-mode-map (kbd "C-c C-f c") 'custom/go-function-callers)
(define-key go-mode-map (kbd "C-c ? .") 'godoc-at-point)
(define-key go-mode-map (kbd "C-c ? p") (lambda () (interactive) (godoc (symbol-name (symbol-at-point)))))

(provide 'init-go)
