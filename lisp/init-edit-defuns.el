(defun custom/insert-new-line ()
  "Insert a new line without breaking the current one"
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))

(defun custom/smart-move-beginning-of-line ()
  "Move to beginning of line or to beginning of indentation depending on POINT."
  (interactive)
  (if (= (point) (line-beginning-position))
      (back-to-indentation)
    (move-beginning-of-line nil)))

(defun custom/duplicate-current-line-or-region (arg)
  "Duplicates the current line or those covered by region ARG times."
  (interactive "p")
  (custom/with-region-info
   (let ((exit-point end)
         (region (buffer-substring-no-properties beg end)))
     (dotimes (_ arg)
       (goto-char end)
       (newline)
       (insert region)
       (setq end (point)))
     (goto-char exit-point)
     (next-line)
     (back-to-indentation))))

(defun custom/copy-line ()
  "Copy current line or those covered by a marked region"
  (interactive)
  (custom/with-region-info (kill-ring-save beg end)))

(defun custom/kill-line ()
  "Kill current line or the ones covered by a marked region."
  (interactive)
  (custom/with-region-info
   (if (and mark-active (> (point) (mark)))
       (setq num-lines (* -1 num-lines)))
     (kill-whole-line num-lines)))

(defun custom/join-line ()
  "Join current line with the previous one or all covered by a marked region."
  (interactive)
  (custom/with-region-info
   (goto-char end)
   (dotimes (_ (max 1 (1- num-lines)))
     (join-line))))

(defun custom/toggle-line-comment ()
  "Comment or uncomment current line or the ones covered by a marked region."
  (interactive)
  (custom/with-region-info
   (comment-or-uncomment-region beg end)))

(defmacro custom/with-region-info (&rest body)
  "Evaluates BODY provinding BEG, END and NUM-LINES bindings, which represents
regions's beginning, ending and extension in lines."
  `(save-excursion
    (let (beg end num-lines)
      (if (and mark-active (> (point) (mark)))
          (exchange-point-and-mark))
      (setq beg (line-beginning-position))
      (if mark-active
          (exchange-point-and-mark))
      (setq end (line-end-position))
      (setq num-lines (max 1 (count-lines beg end)))
      ,@body)))

(defun custom/yank-and-indent ()
  "Indent and then indent newly formed region."
  (interactive)
  (yank)
  (call-interactively 'indent-region))

(provide 'init-edit-defuns)
