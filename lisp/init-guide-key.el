(require 'guide-key)

(setq guide-key/guide-key-sequence '("C-x r" "C-c"))

;; enable guide-key
(guide-key-mode t)

;; delay for popping up command suggestions
(setq guide-key/idle-delay 1)

;; check keys recursively
(setq guide-key/recursive-key-sequence-flag t)

(provide 'init-guide-key)
