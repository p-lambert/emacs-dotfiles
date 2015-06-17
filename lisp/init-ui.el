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
(set-default-font "Inconsolata-dz for Powerline 14")

;; theme
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))
;; available options: flatui | jellyburn
(load-theme 'jellyburn t)

;; linum
(setq linum-format "%3d")

;; modeline
(defun branch-name ()
  ;; for powerline patched fonts, the unicode char \ue0a0 is cooler!
  (when vc-mode (concat "@ " (substring vc-mode 5))))

(setq-default mode-line-format
      (list
       "[" mode-line-modified "]"
       "  "
       "%b"
       "  |  "
       'mode-name
       "  |  "
       '(:eval (projectile-project-name))
       " "
       '(:eval (branch-name))
       "  |  "
       "%p (%l,%c)"
       ))

;; default window size
(when window-system (set-frame-size (selected-frame) 140 35))

(provide 'init-ui)
