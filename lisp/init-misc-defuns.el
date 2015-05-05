(defun custom/open-or-create-scratch-buffer ()
   "Open or create a scratch buffer"
   (interactive)
   (switch-to-buffer (get-buffer-create "*scratch*"))
   (lisp-interaction-mode))

(provide 'init-misc-defuns)
