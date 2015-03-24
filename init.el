(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-packages)
(require 'init-ui)
(require 'init-general)

;; package-specific
(require 'init-helm)
(require 'init-magit)
(require 'init-projectile)
(require 'init-ruby)

(require 'init-keybindings)
