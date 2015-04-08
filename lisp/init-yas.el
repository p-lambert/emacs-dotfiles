(require 'yasnippet)

(setq yas-snippet-dirs (expand-file-name "snippets" user-emacs-directory))

(yas-reload-all)

;; enable yas only on certain modes instead of using it globally
(add-hook 'prog-mode-hook #'yas-minor-mode)

(provide 'init-yas)
