(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(defvar my-packages
  '(
    ag
    auctex
    bind-key
    cider
    clojure-mode
    company
    counsel
    counsel-projectile
    dash
    dash-at-point
    elscreen
    expand-region
    f
    flyspell-correct-ivy
    gist
    git-timemachine
    guide-key
    go-mode
    gotest
    haskell-mode
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
    quickrun
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
