(defun custom/org-toggle-narrowing ()
  (interactive)
  (if (not (buffer-narrowed-p))
      (org-narrow-to-subtree)
    (widen)
    (call-interactively 'recenter-top-bottom)))

(provide 'init-org-defuns)
