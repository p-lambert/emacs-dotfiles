(require 'guide-key)

(setq guide-key/guide-key-sequence '("C-x r" "C-c"))

;; enable guide-key
(guide-key-mode t)

;; delay for popping up command suggestions
(setq guide-key/idle-delay 1)

;; check keys recursively
(setq guide-key/recursive-key-sequence-flag t)

;; always open a horizontal split at the bottom
(setq guide-key/popup-window-position 'bottom)

(provide 'init-guide-key)
