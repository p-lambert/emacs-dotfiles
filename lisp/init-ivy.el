(require 'ivy)
(require 'counsel)
(require 'swiper)
(require 'projectile)

(ivy-mode 1)
(remove-hook 'ivy-mode-hook #'ivy-rich-mode)
(setq ivy-use-virtual-buffers nil)
(setq ivy-count-format "")
(setq ivy-height 20)
(setq ivy-wrap 't)
;; use `nil` instead of display-style fancy
(setq ivy-display-style nil)
(setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-arrow)
;; no regexp by default
(setq ivy-initial-inputs-alist nil)
;; configure regexp engine.
(setq ivy-re-builders-alist
	  ;; allow input not in order
      '((t . ivy--regex-ignore-order)))

(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-b") 'ivy-switch-buffer)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h a") 'counsel-apropos)
(global-set-key (kbd "C-x C-n") 'counsel-bookmark)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "s-f") 'counsel-ag)

(defun custom/ivy-open-other-window ()
  "calls 'other window' action in the ivy prompt (if available)
  the idea here is to reproduce the behavior of helm where you can call `C-c o`
  directly from the list of candidates"
  (interactive)
  (ivy-exit-with-action
   (nth 1
        (-first
         (lambda (x) (string= (-last-item x) "other window"))
         (cdr (ivy-state-action ivy-last))))))

(define-key ivy-minibuffer-map (kbd "C-c o") 'custom/ivy-open-other-window)
(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-call)

(provide 'init-ivy)
