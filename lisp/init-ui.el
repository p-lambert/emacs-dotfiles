(require 's)

(menu-bar-mode -1)
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
(require 'linum)

(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((num-lines (count-lines (point-min) (point-max)))
         (num-digits (length (number-to-string num-lines)))
         (linum-format (format " %%%dd " num-digits)))
    ad-do-it))

(add-hook 'prog-mode-hook 'linum-mode)

;; Disable line number highlight for performance reasons
;; (require 'hlinum)
;; (hlinum-activate)

;; fonts
(defun custom/set-fonts ()
  (set-frame-font "Fira Mono 15")
  (set-face-attribute 'mode-line nil :font "Fira Mono 13")
  (set-face-attribute 'mode-line-inactive nil :font "Fira Mono 13"))
(custom/set-fonts)

(setq default-frame-alist
      '(
        (width . 140)
        (height . 40)
        (font . "Fira Mono 15")
        (vertical-scroll-bars . nil)))


(setq-default mode-line-format
              (list
               ;; add padding to mode-line (hacky solution)
               (propertize "\u200b" 'display '((raise -0.40) (height 1.4)))
               " "
               "[" mode-line-modified "]"
               "  "
               (propertize "%b" 'face 'bold)
               "  |  "
               'projectile--mode-line
               '(:eval (custom/git-mode-line))
               "  |  "
               'mode-name
               "  |  "
               "%l:%c"
               ))

;; default window size
(when window-system (set-frame-size (selected-frame) 140 40))

;; fix file opening (OSX specific)
(setq ns-pop-up-frames nil)

;; themes
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))
(setq custom/dark-theme 'doom-wilmersdorf)
(setq custom/light-theme nil)

;; load dark theme by default
(load-theme custom/dark-theme t)

(defun custom/toggle-light-dark-theme ()
  (interactive)
  (if (string= (frame-parameter nil 'background-mode) "dark")
      (load-theme custom/light-theme 't)
    (load-theme custom/dark-theme 't)))

;; fix theme switching
(defadvice load-theme (before smooth-theme-switching activate)
  (ad-set-arg 1 t)
  (mapcar #'disable-theme custom-enabled-themes))
(defadvice load-theme (after override-fonts activate)
  (custom/set-fonts))

(provide 'init-ui)
