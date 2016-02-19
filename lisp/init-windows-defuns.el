(defun custom/vsplit-last-buffer ()
  "Vertically split window showing last buffer."
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))

(defun custom/hsplit-last-buffer ()
  "Horizontally split window showing last buffer."
  (interactive)
  (when (= (length (window-list)) 1)
    (split-window-horizontally))
  (other-window 1 nil)
  (switch-to-next-buffer))

(defun custom/swap-buffers-in-windows ()
  "Put the buffer from the selected window in next window, and vice versa."
  (interactive)
  (let* ((this (selected-window))
         (other (next-window))
         (this-buffer (window-buffer this))
         (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)))

(defun custom/buffer-file-name-to-kill-ring ()
  "Get current buffer's filename and add it to the kill-ring."
  (interactive)
  (when buffer-file-name
    (kill-new buffer-file-name)
    (message "File name added to kill-ring.")))

(provide 'init-windows-defuns)
