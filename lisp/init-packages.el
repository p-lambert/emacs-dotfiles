(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(defvar my-packages
  '(
    ag
    bind-key
    cider
    clojure-mode
    coffee-mode
    dash
    expand-region
    f
    gist
    git-timemachine
    guide-key
    haskell-mode
    helm
    helm-bundle-show
    helm-projectile
    inf-ruby
    magit
    markdown-mode
    multiple-cursors
    mutant
    projectile
    rainbow-delimiters
    rbenv
    request
    restclient
    rinari
    rspec-mode
    rubocop
    smart-forward
    smartparens
    toggle-quotes
    web-mode
    yaml-mode
    yasnippet
    ;; themes
    atom-one-dark-theme
    flatui-theme
    )
  "A list of packages to be installed at application launch.")

(setq packaged-contents-refreshed-p nil)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (condition-case ex
  (package-install p)
      ('error (if packaged-contents-refreshed-p
      (error ex)
    (package-refresh-contents)
    (setq packaged-contents-refreshed-p t)
    (package-install p))))))

(provide 'init-packages)
