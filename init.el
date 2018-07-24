(package-initialize)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'init-packages)
(require 'init-vendor-packages)
(require 'init-general)
(require 'init-edit-defuns)
(require 'init-misc-defuns)
(require 'init-windows-defuns)
(require 'init-windowing)

;; package-specific
(require 'init-c)
(require 'init-coffee)
(require 'init-comint)
(require 'init-company)
(require 'init-dired)
(require 'init-elscreen)
(require 'init-eshell)
(require 'init-expand-region)
(require 'init-git)
(require 'init-go)
(require 'init-guide-key)
(require 'init-haskell)
(require 'init-helm)
(require 'init-latex)
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
(require 'init-spell)
(require 'init-web)
(require 'init-whitespace)
(require 'init-yas)

(require 'init-ui)
(require 'init-keybindings)
