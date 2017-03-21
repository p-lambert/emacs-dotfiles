(defun custom/open-or-create-scratch-buffer ()
   "Open or create a scratch buffer"
   (interactive)
   (switch-to-buffer (get-buffer-create "*scratch*"))
   (lisp-interaction-mode))

(defun custom/search-asterisk ()
  "Performs an isearch-forward much like Vim's *."
  (interactive)
  (let (str)
    (if (region-active-p)
        (progn
          (let ((beg (region-beginning))
                (end (region-end)))
            (setq str (buffer-substring-no-properties beg end))
            (pop-mark)
            (goto-char beg)))
      (setq str (symbol-name (symbol-at-point)))
      (goto-char (max (- (point) 1) (point-min))))
    (isearch-forward nil 1)
    (isearch-yank-string str)))

(defun custom/occur ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))

(provide 'init-misc-defuns)
