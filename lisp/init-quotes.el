(require 'elec-pair)
(require 'toggle-quotes)

(electric-pair-mode)
(global-set-key (kbd "C-c \\") 'toggle-quotes)

(provide 'init-quotes)
