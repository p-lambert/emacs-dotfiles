(require 'tex-site)
(require 'reftex)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(setq TeX-command-force "LaTex")
(setq reftex-plug-into-AUCTeX t)
(setq reftex-use-external-file-finders t)
(setq reftex-use-external-file-finders t)
(setq reftex-external-file-finders
      '(("tex" . "kpsewhich -format=.tex %f")
        ("bib" . "kpsewhich -format=.bib %f")))

(provide 'init-latex)
