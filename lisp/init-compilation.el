(require 'f)
(require 's)
(require 'dash)
(require 'term)
(require 'cc-mode)
(require 'compile)

(defun custom/compile-and-run (compiler-cmd)
  "Compile (through COMPILER-CMD) and run current file."
  (let* ((full-path (buffer-file-name))
         (file-name (f-filename full-path))
         (base-name (f-base full-path))
         (cmd (format "%s %s -o %s" compiler-cmd file-name base-name)))
    (setenv "RUN_AFTER_COMPILE" (f-no-ext full-path))
    (compile cmd)))

(defun custom/run-after-compile-hook (buffer msg)
  (let ((file-to-run (getenv "RUN_AFTER_COMPILE")))
    (when (and file-to-run (string-match ".*finished.*" msg))
      (custom/run-program file-to-run (get-buffer-window buffer)))
    (setenv "RUN_AFTER_COMPILE" nil)))

(defun custom/run-program (program window)
  (-let* ((buffer-name (format "*program %s*" program))
          (buffer (get-buffer-create buffer-name))
          ((command args) (s-split-up-to " " program 1))
          (args (or args "")))
    (set-window-buffer window buffer)
    (with-current-buffer buffer
      (erase-buffer))
    (term-ansi-make-term buffer-name command nil args)))

(add-hook 'compilation-finish-functions 'custom/run-after-compile-hook)

(define-key c-mode-base-map (kbd "C-c 0")
  (lambda () (interactive) (custom/compile-and-run "gcc")))
(define-key c++-mode-map (kbd "C-c 0")
  (lambda () (interactive) (custom/compile-and-run "g++")))
(define-key compilation-mode-map (kbd "C-c f") 'find-file-at-point)

(provide 'init-compilation)
