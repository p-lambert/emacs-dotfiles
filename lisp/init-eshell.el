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

(defun custom/eshell-beginning-of-line ()
  (interactive)
  (let ((previous (point)))
    (eshell-bol)
    (when (= previous (point))
      (beginning-of-line))))

(defun custom/open-eshell ()
  (if (projectile-project-p)
      (projectile-run-eshell)
    (eshell)))

(global-set-key (kbd "C-c e") 'custom/open-eshell)

(defun custom/define-eshell-keymaps ()
  (define-key eshell-mode-map (kbd "C-a") 'custom/eshell-beginning-of-line)
  (define-key eshell-mode-map (kbd "s-k") 'custom/eshell-clear))

(add-hook 'eshell-mode-hook 'custom/define-eshell-keymaps)

(provide 'init-eshell)
