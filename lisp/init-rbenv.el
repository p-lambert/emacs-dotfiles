(require 'rbenv)

;; add rbenv shims directory to PATH
(let ((shims-dir (concat rbenv-installation-dir "shims"))
      (home-dir (getenv "PATH")))
      (setenv "PATH" (concat shims-dir ":" home-dir)))

(add-hook 'ruby-mode-hook 'rbenv-use-corresponding)
(add-hook 'eshell-mode-hook 'rbenv-use-corresponding)

(provide 'init-rbenv)
