(require 'company)

(global-company-mode '(not esh-mode))

;; disable company mode on inf-mode (couldn't use blacklist above)
(add-hook 'inf-ruby-mode-hook (lambda () (call-interactively 'company-mode)))

(provide 'init-company)
