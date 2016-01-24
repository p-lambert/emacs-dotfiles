(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-packages)
(require 'init-general)
(require 'init-edit-defuns)
(require 'init-misc-defuns)
(require 'init-windows-defuns)

;; package-specific
(require 'init-coffee)
(require 'init-comint)
(require 'init-compilation)
(require 'init-dired)
(require 'init-eshell)
(require 'init-git)
(require 'init-guide-key)
(require 'init-haskell)
(require 'init-helm)
(require 'init-markdown)
(require 'init-multiple-cursors)
(require 'init-mutant)
(require 'init-org)
(require 'init-projectile)
(require 'init-quotes)
(require 'init-rainbow-delimiters)
(require 'init-rbenv)
(require 'init-ruby)
(require 'init-scheme)
(require 'init-smartparens)
(require 'init-web)
(require 'init-yas)

(require 'init-keybindings)
(require 'init-ui)
