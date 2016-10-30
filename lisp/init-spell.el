(require 'helm-flyspell)

(add-hook 'text-mode-hook 'flyspell-mode)
(define-key flyspell-mode-map (kbd "C-;") 'helm-flyspell-correct)

(provide 'init-spell)
