(require 'rbenv)

(add-hook 'ruby-mode-hook 'rbenv-use-corresponding)
(add-hook 'eshell-mode-hook 'rbenv-use-corresponding)

(provide 'init-rbenv)
