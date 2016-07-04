(require 'key-chord)

(key-chord-mode 1)
(key-chord-define-global "qq" 'helm-mini)
(key-chord-define-global "qw" 'helm-imenu)
(key-chord-define-global "qp" 'helm-projectile-switch-project)
(key-chord-define-global "qf" 'helm-projectile-find-file)
(key-chord-define-global "qt" (lambda (&optional arg)
                                (interactive "D")
                                (helm-projectile-switch-to-eshell default-directory)))
(key-chord-define-global "qs" 'helm-projectile-ag)

(key-chord-define-global "zz" 'zop-up-to-char)
(key-chord-define-global "zb" (lambda (&optional arg)
                                (interactive "p")
                                (zop-up-to-char -1)))

(key-chord-define-global ",," 'repeat)
(key-chord-define-global "fv" 'fastnav-sprint-forward)
(key-chord-define-global "vb" 'fastnav-sprint-backward)
(key-chord-define-global "zx" 'helm-M-x)
(key-chord-define-global "qd" 'dired)
(key-chord-define-global "wg" 'magit-status)
(key-chord-define-global "wc" 'magit-checkout)
(key-chord-define-global "wp" 'magit-push)
(key-chord-define-global "qi" (lambda (&optional arg)
                                (interactive)
                                (find-file "~/.emacs.d/personal/my_init.el")))
(key-chord-define-global "`2" (lambda (&optional arg)
                                (interactive)
                                (split-window-below)
                                (windmove-down)))
(key-chord-define-global "`3" (lambda (&optional arg)
                                (interactive)
                                (split-window-right)
                                (windmove-right)))
(key-chord-define-global "`5" 'make-frame-command)
(key-chord-define-global "qk" 'kill-buffer)

(key-chord-define-global "lj" nil)

(provide 'keychords)
;;; keychords ends here
