(require 'bind-key)

(defvar custom/strong-bindings
  '("M-n" "M-p" "C-M-&" "C-x 4")
  "List of global keybindings to be ensured on every mode.")

(defun custom/ensure-bindings-precedence (keys)
  "Ensure the precedence of all global KEYS provided."
  (let ((bindings-alist (mapcar 'custom/binding-cons-cell keys)))
    (dolist (bnd bindings-alist)
      (bind-key* (car bnd) (cdr bnd)))))

(defun custom/binding-cons-cell (key)
  (cons key (lookup-key (current-global-map) (kbd key))))

;; movement and editing
(global-set-key (kbd "M-n") (lambda () (interactive) (next-line 5)))
(global-set-key (kbd "M-p") (lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-<return>") 'custom/insert-new-line)
(global-set-key (kbd "C-a") 'custom/smart-move-beginning-of-line)
(global-set-key (kbd "C-S-n") 'end-of-buffer)
(global-set-key (kbd "C-S-p") 'beginning-of-buffer)
(global-set-key (kbd "C-c C-k") 'custom/copy-line)
(global-set-key (kbd "C-c d") 'custom/duplicate-current-line-or-region)
(global-set-key (kbd "C-M-<backspace>") 'custom/kill-line)
(global-set-key (kbd "C-c j") 'custom/join-line)
(global-set-key (kbd "C-c /") 'custom/toggle-line-comment)
(global-set-key (kbd "C-y") 'custom/yank-and-indent)
(global-set-key (kbd "C-M-f") 'forward-sexp)
(global-set-key (kbd "C-M-b") 'backward-sexp)
(global-set-key (kbd "s-g") 'goto-line)
(global-set-key (kbd "s-p") 'custom/open-file-from-clipboard)

;; window and buffer manipulation
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-0") 'delete-window)
(global-set-key (kbd "s-o") (lambda () (interactive) (switch-to-buffer nil nil 't)))
(global-set-key (kbd "M-k") 'kill-buffer)
(global-set-key (kbd "s-k") 'custom/kill-current-buffer)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "C-x 2") 'custom/vsplit-last-buffer)
(global-set-key (kbd "C-x 3") 'custom/hsplit-last-buffer)
(global-set-key (kbd "C-c -") 'custom/swap-buffers-in-windows)
(global-set-key (kbd "C-x =") 'balance-windows)
(global-set-key (kbd "C-l") 'previous-buffer)
(global-set-key (kbd "C-c l") 'recenter-top-bottom)
(global-set-key (kbd "C-c y y") 'custom/copy-buffer-file-name)
(global-set-key (kbd "s-t") 'new-frame)

;; misc
(global-set-key (kbd "C-c s") 'custom/open-or-create-scratch-buffer)
(global-set-key (kbd "C-h C-d") 'dash-at-point)
(global-set-key (kbd "C-c w") 'global-whitespace-mode)
(global-set-key (kbd "C-c 8") 'swiper-thing-at-point)
(global-set-key (kbd "M-e") 'ignore)
(global-set-key (kbd "s-n") 'ignore)
(global-set-key (kbd "C-z") 'ignore)
(global-set-key (kbd "C-x C-c") 'ignore)
(global-set-key (kbd "C-c 0") 'quickrun)
(global-set-key (kbd "s--") 'text-scale-decrease)
(global-set-key (kbd "s-=") 'text-scale-increase)
(global-set-key (kbd "<f12>") 'custom/toggle-light-dark-theme)


;; elscreen
(global-set-key (kbd "s-{") 'elscreen-previous)
(global-set-key (kbd "s-}") 'elscreen-next)
(global-set-key (kbd "s-t") 'elscreen-create)
(global-set-key (kbd "s-w") 'elscreen-kill)
(global-set-key (kbd "s-r") 'elscreen-screen-nickname)

;; set a custom keybinding for toggling binding
(global-set-key (kbd "C-M-&") 'override-global-mode)
;; ensure precedence of selected keybindings
(custom/ensure-bindings-precedence custom/strong-bindings)

(provide 'init-keybindings)
