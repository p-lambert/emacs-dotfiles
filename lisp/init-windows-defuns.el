(require 'f)

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

(defun custom/copy-buffer-file-name (relative-p)
  "Get current buffer's filename and add it to the kill-ring."
  (interactive "P")
  (let ((file-name (custom/get-buffer-file-name relative-p)))
    (when file-name
      (kill-new file-name)
      (message file-name))))

(defun custom/get-buffer-file-name (&optional relative-p)
  (if (and relative-p (projectile-project-p))
      (f-relative buffer-file-name (projectile-project-root))
    buffer-file-name))

(defun custom/horizontally-split-p ()
  "Find out if opened windows are horizontally split."
  (let* ((this (selected-window))
         (that (next-window))
         (this-x (car (window-edges this)))
         (that-x (car (window-edges that))))
    (= this-x that-x)))

(defun custom/toggle-split ()
  "Toggle between horizontal and vertical splits."
  (interactive)
  (let ((h-split (custom/horizontally-split-p)))
    (delete-window)
    (if h-split
        (custom/hsplit-last-buffer)
      (custom/vsplit-last-buffer))))

;; https://github.com/bbatsov/crux/
(defun custom/kill-other-buffers ()
  "Kill all buffers but the current one.
Doesn't mess with special buffers."
  (interactive)
  (when (y-or-n-p "Are you sure you want to kill all buffers but the current one? ")
    (seq-each
     #'kill-buffer
     (delete (current-buffer) (seq-filter #'buffer-file-name (buffer-list))))))

(defun custom/kill-current-buffer ()
  "Kill the current buffer trying to replace it by another one from the same project"
  (interactive)
  (if (not (projectile-project-p))
      (kill-current-buffer)
    (let ((previous (current-buffer)))
      (projectile-previous-project-buffer)
      (kill-buffer previous))))

(provide 'init-windows-defuns)
