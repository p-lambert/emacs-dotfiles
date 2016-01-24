(require 'mutant)

(add-hook 'ruby-mode-hook 'mutant-mode)
(add-hook 'dired-mode-hook 'mutant-dired-mode)

(provide 'init-mutant)
