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

;; start in fullscreen
(toggle-frame-fullscreen)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; line numbers
(add-hook 'prog-mode-hook 'linum-mode)
;; enable current line hightlighting
(global-hl-line-mode t)

;; fonts
(set-default-font "Fira Mono 14")

;; theme
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))
(load-theme 'atom-one-dark t)

;; modeline
(defun branch-name ()
  ;; for powerline patched fonts, the unicode char \ue0a0 is cooler!
  (when vc-mode (concat "@ " (substring vc-mode 5))))

(setq-default mode-line-format
              (list
               ;; add padding to mode-line (hacky solution)
               (propertize "\u200b" 'display '((raise -0.15) (height 1.2)))
               "[" mode-line-modified "]"
               "  "
               (propertize "%b" 'face 'bold)
               "  |  "
               'mode-name
               "  |  "
               '(:eval (projectile-project-name))
               " "
               '(:eval (branch-name))
               "  |  "
               "%p (%l:%c)"
               ))

;; default window size
(when window-system (set-frame-size (selected-frame) 115 35))

;; force horizontal splits
(setq split-height-threshold nil)
(setq split-width-threshold 80)

;; fix theme switching
(defadvice load-theme (before smooth-theme-switching activate)
  (ad-set-arg 1 t)
  (mapcar #'disable-theme custom-enabled-themes))

(provide 'init-ui)
