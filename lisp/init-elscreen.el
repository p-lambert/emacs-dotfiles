(require 'elscreen)

;; hide tabs
(setq elscreen-display-tab nil)

(elscreen-start)

;; custom keybindings defined in init-keybindings.el

(defun custom/elscreen-mode-line ()
  (let ((screen-list (sort (elscreen-get-screen-list) '<))
        (screen-name (elscreen-get-screen-nickname (elscreen-get-current-screen))))
    (format "%d/%d"
            (1+ (-elem-index (elscreen-get-current-screen) screen-list))
            (length screen-list))))

(defun custom/elscreen-name (screen)
  (let ((screen-name (alist-get screen (elscreen-get-screen-to-name-alist))))
    (if (eq screen (elscreen-get-current-screen))
        (propertize screen-name 'face 'warning)
      screen-name)))

(defun custom/elscreen-with-display (fn &rest args)
  (let ((result (apply fn args)))
    (elscreen-message (custom/elscreen-message) 5)
    result))

(defun custom/elscreen-message ()
  (let ((screen-list (sort (elscreen-get-screen-list) '<)))
    (mapconcat 'custom/elscreen-name screen-list " | ")))

(defun custom/elscreen-from-nickname (nickname)
  (car (rassoc (projectile-project-name)
               (elscreen-get-screen-to-name-alist))))

(dolist (fn '(elscreen-previous
              elscreen-next
              elscreen-create
              elscreen-kill))
  (advice-add fn :around #'custom/elscreen-with-display))

(advice-add 'elscreen-screen-nickname :after
            (lambda (&rest _) (message (custom/elscreen-message))))

(advice-add 'elscreen-kill :before
            (lambda (&rest _) (and (projectile-project-p) (projectile-kill-buffers))))

(provide 'init-elscreen)
