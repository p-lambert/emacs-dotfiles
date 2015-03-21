(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; disable anoying beep
(setq ring-bell-function 'ignore)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; line numbers
(add-hook 'prog-mode-hook 'linum-mode)

;; fonts
(set-default-font "Inconsolata 18")

(provide 'init-ui)
