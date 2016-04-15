(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

(setq org-agenda-files '("~/org/"))
(eval-after-load "org" (lambda ()
                         (org-defkey org-mode-map (kbd "RET") 'org-meta-return)
                         (org-defkey org-mode-map (kbd "C-M-u") 'org-up-element)
                         (org-defkey org-mode-map (kbd "C-M-d") 'org-down-element)
                         (org-defkey org-mode-map (kbd "C-M-n") 'org-next-visible-heading)
                         (org-defkey org-mode-map (kbd "C-M-p") 'org-previous-visible-heading)
                         (org-defkey org-mode-map (kbd "C-M-f") 'org-forward-element)
                         (org-defkey org-mode-map (kbd "C-M-b") 'org-backward-element)
                         (org-defkey org-mode-map (kbd "s-j") 'windmove-down)
                         (org-defkey org-mode-map (kbd "s-h") 'windmove-left)
                         (org-defkey org-mode-map (kbd "s-l") 'windmove-right)
                         (org-defkey org-mode-map (kbd "s-k") 'windmove-up)))
(setq org-src-fontify-natively t)

(setenv "PATH"
        (concat
         "/Library/TeX/texbin/" ":"
         (getenv "PATH")))

(add-hook 'org-mode-hook 'org-indent-mode)

(provide 'org-config)
