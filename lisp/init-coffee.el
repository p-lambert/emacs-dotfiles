(require 'coffee-mode)

(defun custom/setup-coffeescript-indentation ()
  (make-local-variable 'tab-width)
  (set 'tab-width 2))

(add-hook 'coffee-mode-hook 'custom/setup-coffeescript-indentation)

(provide 'init-coffee)
