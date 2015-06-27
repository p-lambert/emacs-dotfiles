(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; see web-mode-current-element-highlight-face
(setq web-mode-enable-current-element-highlight t)

(provide 'init-web)
