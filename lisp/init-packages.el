(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(defvar my-packages
  '(
    ag
    auctex
    bind-key
    cider
    clojure-mode
    coffee-mode
    company
    dash
    dash-at-point
    expand-region
    f
    gist
    git-timemachine
    guide-key
    go-mode
    gotest
    haskell-mode
    helm
    helm-bundle-show
    helm-flyspell
    helm-projectile
    hlinum
    inf-ruby
    magit
    markdown-mode
    multiple-cursors
    mutant
    org
    org-bullets
    perspective
    projectile
    rainbow-delimiters
    rbenv
    request
    restclient
    rinari
    rspec-mode
    rubocop
    smart-forward
    toggle-quotes
    visual-fill-column
    web-mode
    yaml-mode
    yasnippet
    ;; themes
    atom-one-dark-theme
    doom-themes
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
