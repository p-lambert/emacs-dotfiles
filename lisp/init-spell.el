(require 'flyspell-correct-ivy)

(add-hook 'text-mode-hook 'flyspell-mode)
(setq flyspell-correct-interface #'flyspell-correct-ivy)
(define-key flyspell-mode-map (kbd "C-;") 'flyspell-correct-wrapper)

(provide 'init-spell)
