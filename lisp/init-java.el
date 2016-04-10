;; TODO: merge this with init-compilation and make it less stupid
(defun custom/compile-and-run-java ()
  (interactive)
  (let* ((full-path (buffer-file-name))
         (source-file (f-filename full-path))
         (class-name (f-base full-path))
         (cmd (format "javac %s" source-file)))
    (setenv "RUN_AFTER_COMPILE" (format "/usr/bin/java %s" class-name))
    (compile cmd)))

(define-key java-mode-map (kbd "C-c 0") 'custom/compile-and-run-java)

(provide 'init-java)
