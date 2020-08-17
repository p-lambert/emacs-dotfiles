(require 'elscreen)

(defvar custom/elscreen-misc "*misc*"
  "The name of the screen used for all non-projectile buffers.")

(defvar custom/disable-buffer-switch-advice nil)

;; hide tabs
(setq elscreen-display-tab nil)

;; initialize
(elscreen-start)
(elscreen-screen-nickname custom/elscreen-misc)

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
  (car (rassoc nickname
               (elscreen-get-screen-to-name-alist))))

(defun custom/advice-switch-to-buffer (buffer &rest _)
  "Ensures buffer is opened on the screen matching project name, if available."
  (when (get-buffer buffer)
    (with-current-buffer buffer
      (when (and (not custom/disable-buffer-switch-advice)
                 (buffer-file-name)
                 (projectile-project-p))
        (let* ((project-name (projectile-project-name))
               (target-screen (custom/elscreen-from-nickname project-name)))
          (when (and target-screen
                     (not (eq target-screen (elscreen-get-current-screen))))
            (elscreen-goto target-screen)))))))

(dolist (fn '(elscreen-previous
              elscreen-next
              elscreen-create
              elscreen-kill))
  (advice-add fn :around #'custom/elscreen-with-display))

(advice-add 'elscreen-screen-nickname :after
            (lambda (&rest _) (message (custom/elscreen-message))))

(advice-add 'elscreen-kill :before
            (lambda (&rest _) (and (projectile-project-p) (projectile-kill-buffers))))

(advice-add 'switch-to-buffer :before 'custom/advice-switch-to-buffer)

(add-hook 'popwin:before-popup-hook
          (lambda () (setq custom/disable-buffer-switch-advice 't)))
(add-hook 'popwin:after-popup-hook
          (lambda () (setq custom/disable-buffer-switch-advice nil)))

(provide 'init-elscreen)
