(require 'elscreen)

;; hide tabs
(setq elscreen-display-tab nil)

(elscreen-start)

;; custom keybindings defined in init-keybindings.el

(defun custom/elscreen-mode-line ()
  (format "%d/%d"
          (1+ (elscreen-get-current-screen))
          (length (elscreen-get-screen-list))))


(provide 'init-elscreen)
