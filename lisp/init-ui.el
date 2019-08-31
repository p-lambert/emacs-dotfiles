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

;; start in fullscreen
(toggle-frame-fullscreen)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; line numbers
(require 'linum)
(require 'hlinum)

(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((num-lines (count-lines (point-min) (point-max)))
         (num-digits (length (number-to-string num-lines)))
         (linum-format (format " %%%dd " num-digits)))
    ad-do-it))

(add-hook 'prog-mode-hook 'linum-mode)
(hlinum-activate)

;; theme
(add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes"))

(load-theme 'challenger-deep t)

;; fonts
(set-default-font "Fira Mono 14")
(set-frame-font "Fira Mono 14" t t)

(setq default-frame-alist
      '(
        (width . 155)
        (height . 40)
        (font . "Fira Mono 14")
        (vertical-scroll-bars . nil)))

;; modeline
(defun custom/branch-name ()
  ;; for powerline patched fonts, the unicode char \ue0a0 is cooler!
  (cond (vc-mode (concat "@ " (substring vc-mode 5)))
        ((projectile-project-p)
         (let* ((git-branch-cmd "/usr/bin/env git symbolic-ref --short HEAD")
                (branch-name (shell-command-to-string git-branch-cmd)))
           (concat "@ " (s-chomp branch-name))))))

(setq-default mode-line-format
              (list
               ;; add padding to mode-line (hacky solution)
               (propertize "\u200b" 'display '((raise -0.15) (height 1.2)))
               "[" mode-line-modified "]"
               "  "
               '(:eval (custom/elscreen-mode-line))
               "  |  "
               (propertize "%b" 'face 'bold)
               "  |  "
               '(:eval (projectile-project-name))
               " "
               '(:eval (custom/branch-name))
               "  |  "
               'mode-name
               "  |  "
               "%l:%c"
               ))

;; default window size
(when window-system (set-frame-size (selected-frame) 155 40))

;; fix theme switching
(defadvice load-theme (before smooth-theme-switching activate)
  (ad-set-arg 1 t)
  (mapcar #'disable-theme custom-enabled-themes))

;; fix file opening (OSX specific)
(setq ns-pop-up-frames nil)

(provide 'init-ui)
