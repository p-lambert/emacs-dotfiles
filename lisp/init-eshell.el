(require 'eshell)

(setq eshell-aliases-file (concat user-emacs-directory ".eshell-aliases"))

(defun custom/bash-command (&rest cmd)
  "Run CMD as if you were in a bash shell instead of Eshell."
  (insert (format "bash -c 'source ~/.bashrc; cd %s; %s'"
                  (eshell/pwd)
                  (mapconcat 'identity (car cmd) " ")))
  (eshell-send-input))

(defun custom/run-eshell-command (title cmd)
  "Create an eshell buffer named TITLE and then run CMD in it."
  (let ((eshell-buffer (generate-new-buffer title)))
    (with-current-buffer eshell-buffer
      (eshell-mode)
      (goto-char (point-max))
      (insert cmd)
      (eshell-send-input)
      ;; return created buffer
      eshell-buffer)))

(defun custom/eshell-clear ()
  "Clear the eshell buffer."
  (interactive)
  (eshell/clear t)
  (eshell-send-input))

(add-hook 'eshell-mode-hook
          (lambda () (define-key eshell-mode-map (kbd "s-k") 'custom/eshell-clear)))

(provide 'init-eshell)
