(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; see web-mode-current-element-highlight-face
(setq web-mode-enable-current-element-highlight t)

(defvar custom/web-mode-indent 4
  "Number of spaces used by web-mode to indent code.")

(defun custom/prompt-web-mode-indent ()
  (interactive)
  (let* ((default (number-to-string custom/web-mode-indent))
         (indent-offset
          (read-string "Number of spaces to indent: " default nil default)))
    (setq web-mode-markup-indent-offset (string-to-number indent-offset))))

(defun custom/web-mode-setup ()
  (setq web-mode-markup-indent-offset custom/web-mode-indent)
  (toggle-truncate-lines 1))

(add-hook 'web-mode-hook 'custom/web-mode-setup)

(provide 'init-web)
