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
  (let*
   ((beg (car (custom/get-region-positions)))
    (end (cdr (custom/get-region-positions)))
    (exit-point end)
    (region (buffer-substring-no-properties beg end)))
   (dotimes (_ arg)
     (goto-char end)
     (newline)
     (insert region)
     (setq end (point)))
   (goto-char exit-point)
   (next-line)
   (back-to-indentation)))

(defun custom/copy-line ()
  "Copy current line or those covered by a marked region"
  (interactive)
  (kill-ring-save
   (car (custom/get-region-positions))
   (cdr (custom/get-region-positions))))

(defun custom/kill-line ()
  "Kill current line or the ones covered by a marked region."
  (interactive)
  (let*
   ((beg (car (custom/get-region-positions)))
    (end (cdr (custom/get-region-positions)))
    (number-of-lines (count-lines beg end)))
   (if (= number-of-lines 0)
       (setq number-of-lines 1))
   (if (and mark-active (> (point) (mark)))
       (setq number-of-lines (* -1 number-of-lines)))
   (kill-whole-line number-of-lines)))

(defun custom/toggle-line-comment ()
  "Comment or uncomment current line or the ones covered by a marked region."
  (interactive)
  (let
   ((beg (car (custom/get-region-positions)))
    (end (cdr (custom/get-region-positions))))
   (comment-or-uncomment-region beg end)))

(defun custom/get-region-positions ()
  "Returns a dotted-pair (BEG . END) with regions's beginning and ending positions."
  (interactive)
  (save-excursion
    (let (beg end)
      (if (and mark-active (> (point) (mark)))
          (exchange-point-and-mark))
      (setq beg (line-beginning-position))
      (if mark-active
          (exchange-point-and-mark))
      (setq end (line-end-position))
      (cons beg end))))

(provide 'init-edit-defuns)
