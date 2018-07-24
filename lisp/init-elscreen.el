(require 'elscreen)

;; hide tabs
(setq elscreen-display-tab nil)

(elscreen-start)

;; custom keybindings defined in init-keybindings.el

(defun custom/elscreen-mode-line ()
  (let ((screen-list (sort (elscreen-get-screen-list) '<)))
    (format "%d/%d"
            (1+ (-elem-index (elscreen-get-current-screen) screen-list))
            (length screen-list))))

(defun custom/elscreen-display ()
  (interactive)
  (let ((screen-list (sort (elscreen-get-screen-list) '<)))
    (elscreen-message
     (mapconcat 'custom/elscreen-name screen-list " | ")
     5)))

(defun custom/elscreen-name (screen)
  (let ((screen-name (alist-get screen (elscreen-get-screen-to-name-alist))))
    (if (eq screen (elscreen-get-current-screen))
        (propertize screen-name 'face 'warning)
      screen-name)))

(defun custom/elscreen-with-display (fn &rest args)
       (let ((result (apply fn args)))
         (custom/elscreen-display)
         result))

(dolist (fn '(elscreen-previous
              elscreen-next
              elscreen-create
              elscreen-kill
              elscreen-screen-nickname))
  (advice-add fn :around #'custom/elscreen-with-display))

(provide 'init-elscreen)
