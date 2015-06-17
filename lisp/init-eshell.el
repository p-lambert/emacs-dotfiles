(require 'eshell)

(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))

(defun custom/bash-command (&rest cmd)
  "Run CMD as if you were in a bash shell instead of Eshell."
  (insert (format "bash -c 'source ~/.bashrc; cd %s; %s'"
                  (eshell/pwd)
                  (mapconcat 'identity (car cmd) " ")))
  (eshell-send-input))

(provide 'init-eshell)
