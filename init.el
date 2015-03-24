(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-packages)
(require 'init-general)
(require 'init-ui)

;; package-specific
(require 'init-helm)
(require 'init-magit)

(require 'init-keybindings)
