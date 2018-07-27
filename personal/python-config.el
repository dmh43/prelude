(require 'python)

(setf python-indent-offset 2)

(require 'conda)
(conda-env-autoactivate-mode t)
(setf conda-anaconda-home "/Users/danyhaddad/miniconda3")
(conda-env-initialize-interactive-shells)
(conda-env-initialize-eshell)
;; (setq python-shell-interpreter "ipython"
;;       python-shell-interpreter-args "--simple-prompt -i ")

(setq-default mode-line-format (cons '(:exec conda-env-current-name) mode-line-format))

(define-key python-mode-map [remap backward-sentence] nil)
(define-key python-mode-map [remap forward-sentence] nil)

(provide 'python-config)
