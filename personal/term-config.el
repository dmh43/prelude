(add-hook 'term-mode-hook (lambda () (company-mode -1)))

(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)
(add-hook 'term-mode-hook (lambda () (setq global-hl-line-mode nil)))

(defun eshell-git-prompt-my-powerline ()
  (let ((segment-separator "\xe0b0")
        (plusminus         "\x00b1")
        (branch            "\xe0a0")
        (detached          "\x27a6")
        (cross             "\x2718")
        dir git git-bg)
    (setq dir
          (with-face (concat
                      " "
                      (unless (eshell-git-prompt-exit-success-p)
                        (concat cross " "))
                      (let* ((cwd (eshell/pwd))
                             (tramp-portion (replace-regexp-in-string ":/.+" "" cwd))
                             (remote-path (replace-regexp-in-string "[/a-zA-Z]+:[a-zA-Z@.]+:" "" cwd))
                             (abbrev-path (abbreviate-file-name remote-path)))
                        (concat tramp-portion ":" abbrev-path))
                      " ")
            :background "steel blue"
            :foreground "white"))
    (setq git
          (when (eshell-git-prompt--git-root-dir)
            (setq git-bg
                  (if (eshell-git-prompt--collect-status)
                      "indian red" "forest green"))
            (setq eshell-git-prompt-branch-name (eshell-git-prompt--branch-name))
            (with-face
                (concat " "
                        (-if-let (branch-name eshell-git-prompt-branch-name)
                            (concat branch " " branch-name)
                          (concat detached " "(eshell-git-prompt--commit-short-sha)))
                        " ")
              :background git-bg
              :foreground "white")))
    (concat
     (if git
         (concat dir
                 (with-face segment-separator
                   :background git-bg
                   :foreground "steel blue")
                 git
                 (with-face segment-separator
                   :foreground git-bg))
       (concat dir (with-face segment-separator
                     :foreground "steel blue")))
     (propertize "$" 'invisible t) " ")))

(require 'eshell-git-prompt)
(add-to-list 'eshell-git-prompt-themes
             '(my-powerline
               eshell-git-prompt-my-powerline
               eshell-git-prompt-powerline-regexp))

(defun eshell-maybe-bol ()
  (interactive)
  (let ((p (point)))
    (eshell-bol)
    (if (= p (point))
        (beginning-of-line))))

(add-hook 'eshell-mode-hook
          '(lambda () (define-key eshell-mode-map "\C-a" 'eshell-maybe-bol)))

(define-key term-raw-map (kbd "C-\\") nil)

(setq etl-box "/sshx:ubuntu@etl.commercialsearching.com:")

(defun in-buffer (name body)
  (progn
     (get-buffer-create name)
     (switch-to-buffer name)
     (insert (s-join "\n" body))))

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

(provide 'term-config)
