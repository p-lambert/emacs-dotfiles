;; window splitting policy
(defun custom/set-split-width-threshold ()
  (setq split-width-threshold (+ 1 (/ (frame-width) 2))))

(setq split-height-threshold nil)
(setq split-width-threshold 80)

(add-hook 'window-configuration-change-hook 'custom/set-split-width-threshold)

(provide 'init-windowing)
