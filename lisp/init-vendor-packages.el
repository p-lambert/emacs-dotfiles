(require 'dash)
(require 'f)

(defvar custom/vendor-folder (expand-file-name "vendor" user-emacs-directory)
  "The folder containing third-party packages.")

;; add every package inside vendor folder to `load-path`
(-> (f-directories custom/vendor-folder)
     (--each (add-to-list 'load-path it)))

(provide 'init-vendor-packages)
