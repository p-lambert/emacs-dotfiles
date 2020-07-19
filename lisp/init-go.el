(require 'go-mode)
;;(require 'go-guru)
(require 'gotest)
(require 's)
(require 'f)

;; requires go get -u golang.org/x/tools/cmd/goimports
(setq gofmt-command "goimports")
;; requires go get -u github.com/zmb3/gogetdoc
(setq godoc-at-point-function #'godoc-and-godef)
(setq godoc-and-godef-command "go doc")

(defvar custom/go-path-src (f-join (getenv "GOPATH") "src"))
(defvar custom/go-src "/usr/local/go/src")
(defvar custom/godoc-url "https://godoc.org")

;; expose go definition cmd as a custom variable
(defcustom custom/go-definition-cmd "godef-jump"
  "Command to use when jumping to (Go) definition"
  :type '(choice
          (string :tag "godef-jump")
          (string :tag "go-guru-definition")))

(add-hook 'before-save-hook 'gofmt-before-save)

(defun custom/go-run ()
  (interactive)
  (if (s-suffix? "_test.go" buffer-file-name)
      (go-test-current-file)
    (quickrun)))

(defun custom/go-test-wrapper (orig-fun &rest args)
  (let ((pwd (f-relative default-directory (getenv "GOPATH")))
        (go-test-cmd (apply orig-fun args)))
    ;; run test command in vagrant box, if needed
    (if (and (boundp 'custom/vagrant-box) (boundp 'custom/vagrant-go-path))
        (setq go-test-cmd (format "cd %s && vagrant ssh -c \"bash -c \\\"cd %s/%s; %s\\\"\""
                                  custom/vagrant-box custom/vagrant-go-path pwd go-test-cmd)))
    ;; add special test arguments, if needed
    (if (boundp 'custom/go-test-args)
        (setq go-test-cmd
              (s-replace "go test" (concat "go test " custom/go-test-args) go-test-cmd)))
    ;; run test command with custom prefix, if set
    (if (boundp 'custom/go-test-prefix)
        (setq go-test-cmd
              (s-replace "go test" (format "%s go test" custom/go-test-prefix) go-test-cmd)))
      go-test-cmd))

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

(defun custom/go-open-in-godoc (point)
  (interactive "d")
  (-let [(pkg name field-or-method) (custom/go-definition-info point)]
    (when (and pkg name)
      (->> (concat custom/godoc-url "/" pkg "#" name "." field-or-method)
           (s-chop-suffix ".")
           (browse-url)))))

(defun custom/go-definition-info (point)
  (let* ((name) ;; Can be either type, function, const or variable name
         (field-or-method)
         (addr (split-string (car (godef--call point)) ":"))
         (file (car addr))
         (line (nth 1 addr))
         (pkg (custom/go-package-from-file file)))
    (with-temp-buffer
      (insert-file-contents file)
      (goto-line (string-to-number line))
      (cond
       ;; type declaration
       ((looking-at "type[[:blank:]]+\\([[:alnum:]]+\\)")
        (setq name (match-string 1)))
       ;; method definition
       ((looking-at "func (.*?\\([[:alnum:]]+\\)) \\([[:alnum:]]+\\)")
        (setq name (match-string 1))
        (setq field-or-method (match-string 2)))
       ;; function defintion
       ((looking-at "func \\([[:alnum:]]+\\)")
        (setq name (match-string 1)))
       ;; variable declaration
       ((or (looking-at "var \\([[:alnum:]]+\\) [[:alnum:]]+ =") ;; variable declaration
            (looking-at "[[:blank:]]*\\([[:alnum:]]+\\)[[:blank:]]+[[:alnum:]]+[[:blank:]]+=")
            (looking-at "[[:blank:]]*\\([[:alnum:]]+\\)[[:blank:]]*="))
        (setq name (match-string 1)))
       ;; interface method
       ((looking-at "[[:blank:]]*\\([[:alnum:]]+\\)(")
        (setq field-or-method (match-string 1))
        (search-backward-regexp "^type")
        (forward-to-word 1)
        (setq name (thing-at-point 'word)))))
    (list pkg name field-or-method)))

(defun custom/go-package-from-file (file)
  (-as-> file x
       (f-dirname x)
       (s-chop-prefix custom/go-path-src x)
       (s-chop-prefix custom/go-src x)
       (car (s-split ".+?/vendor/" x 't))
       (s-chop-prefix "/" x)))

(defun custom/go-open-package-documentation ()
  (interactive)
  (push-mark)
  (when (looking-at "\"")
    (forward-char))
  (let ((pkg (read-string "Open documentation for package: " (thing-at-point 'filename t))))
    (pop-global-mark)
    (browse-url (concat custom/godoc-url "/" pkg))))

(defun custom/godef-jump (open-in-split-p)
  (interactive "P")
  (let ((fn (intern custom/go-definition-cmd))
        (fn-other-window (intern (concat custom/go-definition-cmd "-other-window"))))
  (if open-in-split-p
      (call-interactively fn-other-window)
    (call-interactively fn))))

(advice-add 'go-test--get-program :around #'custom/go-test-wrapper)

(define-key go-mode-map (kbd "C-c 0") 'custom/go-run)
(define-key go-mode-map (kbd "C-c p t") 'custom/go-find-test-or-implementation)
(define-key go-mode-map (kbd "C-c , a") 'go-test-current-project)
(define-key go-mode-map (kbd "C-c , f") 'go-test-current-file)
(define-key go-mode-map (kbd "C-c , .") 'go-test-current-test)
(define-key go-mode-map (kbd "C-c C-f c") 'custom/go-function-callers)
(define-key go-mode-map (kbd "C-c ? .") 'godoc-at-point)
(define-key go-mode-map (kbd "C-c ? d") 'custom/go-open-in-godoc)
(define-key go-mode-map (kbd "C-c ? p") 'custom/go-open-package-documentation)
(define-key go-mode-map (kbd "C-c C-j") 'custom/godef-jump)

(provide 'init-go)
