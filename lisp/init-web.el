(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

;; see web-mode-current-element-highlight-face
(setq web-mode-enable-current-element-highlight t)
(setq web-mode-enable-current-column-highlight t)

(provide 'init-web)
