(require 'f)
(require 'term)
(require 'cc-mode)

(defun custom/compile-and-run ()
  "Compile and run current file."
  (interactive)
  (let* ((full-path (buffer-file-name))
         (file-name (f-filename full-path))
         (base-name (f-base full-path))
         (cmd (format "gcc %s -o %s" file-name base-name)))
    (setenv "RUN_AFTER_COMPILE" (f-no-ext full-path))
    (compile cmd)))

(defun custom/run-after-compile-hook (buffer msg)
  (let ((file-to-run (getenv "RUN_AFTER_COMPILE")))
    (when (and file-to-run (string-match ".*finished.*" msg))
      (custom/run-program file-to-run (get-buffer-window buffer)))
    (setenv "RUN_AFTER_COMPILE" nil)))

(defun custom/run-program (program window)
  (let* ((program-name (f-filename program))
         (buffer-name (format "*program %s*" program-name))
         (buffer (get-buffer-create buffer-name)))
    (set-window-buffer window buffer)
    (with-current-buffer buffer
      (erase-buffer))
    (term-ansi-make-term buffer-name program)))

(add-hook 'compilation-finish-functions 'custom/run-after-compile-hook)

(define-key c-mode-base-map (kbd "C-c 0") 'custom/compile-and-run)

(provide 'init-compilation)
