(require 'package)

(setq custom/vendor-folder (expand-file-name "vendor" user-emacs-directory))

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(defvar my-packages
  '(
    ag
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
    haskell-mode
    helm
    helm-bundle-show
    helm-projectile
    hlinum
    inf-ruby
    magit
    markdown-mode
    multiple-cursors
    mutant
    org
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
    visual-fill-column
    web-mode
    yaml-mode
    yasnippet
    ;; themes
    atom-one-dark-theme
    flatui-theme
    )
  "A list of packages to be installed at application launch.")

;; add every package inside vendor folder to `load-path`
(let ((no-dots "^\\([^.]\\|\\.[^.]\\|\\.\\..\\)"))
  (dolist (entry (directory-files custom/vendor-folder nil no-dots))
    (let ((full-path (expand-file-name entry custom/vendor-folder)))
      (when (file-directory-p full-path)
        (add-to-list 'load-path full-path)))))

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
