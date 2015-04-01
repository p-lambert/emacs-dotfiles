(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq
 ;; better startup
 inhibit-splash-screen t
 inhibit-startup-message t
 ;; show column number at bottom bar
 column-number-mode t
 ;; disable anoying beep
 ring-bell-function 'ignore
 ;; improve rendering performance
 redisplay-dont-pause t
 )

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; line numbers
(add-hook 'prog-mode-hook 'linum-mode)

;; fonts
(set-default-font "Droid Sans Mono for Powerline 14")

;; theme
(load-theme 'ujelly t)

(provide 'init-ui)
