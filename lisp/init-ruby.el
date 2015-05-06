(require 'rspec-mode)
(require 'rinari)
(require 'rubocop)

;; auto modes
(dolist (fp '("\\.rb$"
              "\\.ru$"
              "\\.rake"
              "\\.jbuilder$"
              "\\.gemspec$"
              "\\GuardFile$"
              "\\Rakefile$"
              "\\Vagrantfile$"
              "\\Gemfile$"
              "\\Godfile$"
              "\\.god$"))
  (add-to-list 'auto-mode-alist `(,fp . ruby-mode)))

;; do not add encoding comment automatically
(setq ruby-insert-encoding-magic-comment nil)

;; rspec-mode configuration
(add-hook 'ruby-mode-hook 'rspec-mode)

(setq rspec-use-rake-when-possible nil)
(setq rspec-use-spring-when-possible nil)

;; enable debugging tools (binding.pry or byebug)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)

;; identation fixes
(setq
 ruby-align-chained-calls nil
 ruby-align-to-stmt-keywords nil
 ruby-deep-indent-paren nil
 ruby-deep-indent-paren-style nil
 ruby-use-smie nil)

(defadvice ruby-indent-line (after unindent-closing-paren activate)
  "Ensure desired behaviour for parenthesis indentation."
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

;; vcr toggle
(defun custom/vcr-toggle ()
  (interactive)
  (if (getenv "VCR_OFF")
      (progn
        (setenv "VCR_OFF" nil)
        (message "VCR is ON"))
    (progn
      (setenv "VCR_OFF" "true")
      (message "VCR is OFF"))))

(defun custom/class-from-file-name (file-name)
  "Guess the name of the class given a filename."
  (let* ((name (file-relative-name file-name (projectile-project-root)))
         (class (capitalize name))
         (rules '(("\\.rb"        . "")
                  ("app\\/.+?\\/" . "")
                  ("lib\\/"       . "")
                  ("/"            . "::")
                  ("_"            . ""))))
    (dolist (rule rules)
      (setq class (replace-regexp-in-string (car rule) (cdr rule) class nil t)))
    class))

(defun custom/run-mutant-from-dired ()
  "Run mutant over all marked files."
  (interactive)
  (let* ((file-names (dired-get-marked-files))
         (class-names (mapcar 'custom/class-from-file-name file-names))
         (joined-names (mapconcat 'identity class-names " ")))
    (compile (concat "rake 'mutant:check[" joined-names "]'"))))

(define-key dired-mode-map (kbd "C-c t") 'custom/run-mutant-from-dired)

(provide 'init-ruby)
