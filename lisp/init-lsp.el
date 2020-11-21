(require 'lsp-mode)

;; (add-hook 'go-mode-hook #'lsp)

(setq
 lsp-diagnostic-package :none
 lsp-eldoc-enable-hover 't
 lsp-enable-completion-at-point 't
 lsp-enable-enable-text-document-color nil
 lsp-enable-indentation nil
 lsp-enable-links nil
 lsp-enable-on-type-formatting nil
 lsp-enable-snippet nil
 lsp-enable-symbol-highlighting nil
 lsp-modeline-code-actions-enable nil
 lsp-modeline-diagnostics-enable nil
 )

(provide 'init-lsp)
