(require 'rspec-mode)
(require 'rinari)
(require 'rubocop)
(require 'f)

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
(add-hook 'dired-mode-hook 'rspec-dired-mode)

(setq rspec-use-rake-when-possible nil)
(setq rspec-use-spring-when-possible nil)

;; ignore only app dir when performing the spec lookup
(setq rspec-primary-source-dirs '("app"))

;; auto-discover spec directory structure
(defun custom/rspec-check-lib-dir (source-dirs)
  (let ((lib-dir (expand-file-name "spec/lib" (rspec-project-root))))
    (if (file-exists-p lib-dir)
        (remove "lib" source-dirs)
      (add-to-list 'source-dirs "lib"))))

(defun custom/rspec-setup ()
  (interactive)
  (setq rspec-primary-source-dirs
        (custom/rspec-check-lib-dir rspec-primary-source-dirs))
  (message (format "RSpec source dirs set to: %s" rspec-primary-source-dirs)))

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
    (setenv "VCR_OFF" "true")
    (message "VCR is OFF")))

(defun custom/ruby-console ()
  "Try to open a rails-console. If it fails, open an IRB session."
  (interactive)
  (condition-case nil
      (rinari-console)
    (error (let* ((project-root
                   (or (locate-dominating-file default-directory ".git")
                       (error "You're not inside a project.")))
                  (default-directory project-root)
                  (project-name (f-filename project-root)))
             (run-ruby "irb -Ilib" project-name)))))


;; keybindings
(global-set-key (kbd "C-M-v") 'custom/vcr-toggle)
(global-set-key (kbd "C-c r s") 'rinari-web-server)
(global-set-key (kbd "C-c r c") 'custom/ruby-console)
(global-set-key (kbd "C-c , ,") 'rspec-find-spec-or-target-other-window)

(provide 'init-ruby)
