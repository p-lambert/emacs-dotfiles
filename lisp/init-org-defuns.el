(defun custom/org-toggle-narrowing ()
  (interactive)
  (if (not (buffer-narrowed-p))
      (org-narrow-to-subtree)
    (widen)))

(provide 'init-org-defuns)
