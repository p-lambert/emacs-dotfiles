(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(defvar my-packages
  '(
    helm
    magit
    projectile
    helm-projectile
    rbenv
    rspec-mode
    inf-ruby
    ujelly-theme
    yaml-mode
    )
  "A list of packages to be installed at application launch.")

;; package loading (stolen from milhouse)
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
