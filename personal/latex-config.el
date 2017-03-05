(define-key LaTeX-mode-map (kbd "C-M-;")
  (lambda (start end)
    (interactive "r")
    (goto-char end)
    (forward-line -1)
    (while (> (point) start)
      (end-of-line)
      (insert "%")
      (forward-line -1))
    (end-of-line)
    (insert "%")))

(provide 'latex-config)