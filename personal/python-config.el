(require 'python)

(setf python-indent-offset 2)

(require 'conda)
(conda-env-autoactivate-mode t)
(setf conda-anaconda-home "/Users/danyhaddad/miniconda3")
(conda-env-initialize-interactive-shells)
(conda-env-initialize-eshell)

(setq-default mode-line-format (cons '(:exec conda-env-current-name) mode-line-format))

(setq-default flycheck-disabled-checkers '(python-flake8))

(define-key python-mode-map [remap backward-sentence] nil)
(define-key python-mode-map [remap forward-sentence] nil)
(define-key python-mode-map (kbd "C-M-<backspace>") 'sp-backward-kill-sexp)
(define-key python-mode-map (kbd "C-M-k") 'sp-kill-sexp)

(provide 'python-config)
