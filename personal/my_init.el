(add-to-list 'load-path "~/.emacs.d/personal")
(load "helpers.el")
(load "js-config.el")
(load "keybindings.el")
(load "keychords.el")
(load "gnus-config.el")
(load "latex-config.el")
(load "magit-config.el")
(load "navigation.el")
(load "org-config.el")
(load "term-config.el")
(load "web-config.el")
(load "windows.el")
(load "yas-conf.el")
(load "stump-config.el")
(load "os-config.el")
(load "cl-config.el")
(load "my-secrets.el")
(load "ocaml-config.el")
(load "octave-config.el")
(load "cuda-config.el")
(load "python-config.el")

(require 'which-key)
(require 'modalka)
(require 'test-switcher)
(require 'god-mode)
(require 'harp-mode)
(require 'emacs-tertestrial)

(which-key-mode)
(setq enable-recursive-minibuffers t)
(rainbow-delimiters-mode)
(setq whitespace-style
      '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab))
(setq hippie-expand-verbose t)

(remove-hook 'after-save-hook
             (lambda ()
               (when (and
                      (string-prefix-p prelude-dir (file-truename buffer-file-name))
                      (file-exists-p (byte-compile-dest-file buffer-file-name)))
                 (emacs-lisp-byte-compile)))
             t)

(mapc 'diminish '(editorconfig-mode helm-mode company-mode cider-mode projectile-mode))

(setf yas/snippet-dirs '("~/.emacs.d/snippets"))

(define-minor-mode code-review-mode
  (if code-review-mode
      (progn
        (set-face-attribute 'region nil :background "#444155")
        (text-scale-decrease 2))
    (progn
      (text-scale-increase 2)
      (set-face-attribute 'region nil :background "firebrick"))))

(defun test-file-hook ()
  (when (or (string-match-p "test" buffer-file-name)
            (string-match-p "spec" buffer-file-name))
    (tertestrial-mode)))
(add-hook 'find-file-hook 'test-file-hook)
(add-hook 'file-file-hook 'crux-reopen-as-root)
;;(add-hook 'prelude-prog-mode-hook 'paredit-everywhere-mode t)

(require 'ansi-color)
(defun dh-display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(defun dh-get-weather ()
  (interactive)
  (with-temp-buffer
    (shell-command "curl wttr.in" "*weather*")
    (switch-to-buffer "*weather*")
    (mark-whole-buffer)
    (dh-display-ansi-colors)
    (deactivate-mark)
    (read-only-mode)
    (delete-other-windows)
    (beginning-of-buffer)))

(setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

(require 'projectile)
(setq projectile-mode-line
      '(:eval (if (file-remote-p default-directory)
                  " Projectile"
                (format " %s" (projectile-project-name)))))

(require 'flycheck)
(setq flycheck-mode-line '(:eval " FC"))

(diff-hl-flydiff-mode)

(cond
 ((string= system-type "gnu/linux") (set-face-attribute 'default nil :height 150))
 ((string= system-type "darwin") (set-face-attribute 'default nil :height 180)))

(setq company-tooltip-flip-when-above nil)

(setf prelude-clean-whitespace-on-save nil)
(require 'ws-butler)
(setf ws-butler-keep-whitespace-before-point nil)
(ws-butler-global-mode)
(add-to-list 'ws-butler-global-exempt-modes 'org-mode)

(advice-add 'delete-window :before
            (lambda (&optional window) (prelude-auto-save-command)))
(advice-add 'select-window :before
            (lambda (window &optional norecord) (prelude-auto-save-command)))
(advice-add 'other-frame :before
            (lambda (arg) (prelude-auto-save-command)))

(setf browse-url-browser-function 'browse-url-firefox)

(setq tramp-default-method "ssh")
(setq tramp-auto-save-directory "~/tmp/tramp/")
(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "~/.ssh/config")))
(setq tramp-chunksize 2000)
(setq tramp-ssh-controlmaster-options
      (concat
       "-o ControlPath=/tmp/ssh-ControlPath-%%r@%%h:%%p "
       "-o ControlMaster=auto -o ControlPersist=yes"))

(defvar s3-bucket)
(defun s3cmd-put (filepath)
  (start-process "googlecloadput" nil "~/Downloads/google-cloud-sdk/bin/gsutil" "rsync" "/home/dany/org" "gs://dmh-org/"))

(advice-add 'save-buffer :after
            (lambda (&optional arg)
              (when (and (boundp 's3-bucket)
                         (buffer-file-name))
                (s3cmd-put (buffer-file-name)))
              (when (and (buffer-file-name)
                         (cl-search "gtd.org" (buffer-file-name)))
                (progn
                 (org-html-export-to-html)
                 (s3cmd-put (replace-regexp-in-string "gtd.org" "gtd.html" (buffer-file-name)))))))

(add-hook 'comint-mode-hook 'turn-off-show-smartparens-mode)

(setf sp-highlight-pair-overlay nil)

(beacon-mode -1)

(setq ivy-re-builders-alist
      '((t . ivy--regex-ignore-order)))
(setq ivy-initial-inputs-alist '())

(setq prelude-flyspell nil)

(add-hook 'after-make-frame-functions
          '(lambda (frame)
             (modify-frame-parameters frame
                                      '((vertical-scroll-bars . nil)
                                        (horizontal-scroll-bars . nil)))))

(toggle-scroll-bar -1)
(which-function-mode -1)

(setq prelude-guru nil)

(setf expand-region-fast-keys-enabled nil)

(load-theme 'spacemacs-dark)
(set-face-attribute 'default nil :font "Source Code Pro")

(size-indication-mode -1)

(setq-default mode-line-format '("%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification sml/pos-id-separator mode-line-position evil-mode-line-tag smartrep-mode-line-string sml/pre-modes-separator mode-line-modes mode-line-misc-info (:eval (magit-get-current-branch)) mode-line-end-spaces))

(condition-case nil
    (server-start)
  (error (server-running-p)))

(provide 'my-init)
