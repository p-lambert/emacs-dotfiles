(require 'rspec-mode)

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

(provide 'init-ruby)
