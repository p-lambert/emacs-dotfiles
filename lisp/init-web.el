(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; see web-mode-current-element-highlight-face
(setq web-mode-enable-current-element-highlight t)

(defun custom/web-mode-setup ()
  (setq web-mode-markup-indent-offset 4)
  (toggle-truncate-lines 1))

(add-hook 'web-mode-hook 'custom/web-mode-setup)

(provide 'init-web)
