(global-unset-key (kbd "M-u"))

(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c DEL") 'winner-undo)
    (define-key map (kbd "C-x 4 2 f") 'split-horiz-find)
    (define-key map (kbd "C-x 4 3 f") 'split-vert-find)
    (define-key map (kbd "S-s-j") 'buf-move-left)
    (define-key map (kbd "S-s-;") 'buf-move-right)
    (define-key map (kbd "S-s-l") 'buf-move-up)
    (define-key map (kbd "S-s-k") 'buf-move-down)
    (define-key map (kbd "s-j") 'windmove-left)
    (define-key map (kbd "s-;") 'windmove-right)
    (define-key map (kbd "s-l") 'windmove-up)
    (define-key map (kbd "s-k") 'windmove-down)
    (define-key map (kbd "s-n") 'next-line)
    (define-key map (kbd "s-p") 'previous-line)
    (define-key map (kbd "C-SPC") 'my-set-mark)
    (define-key map (kbd "M-:") 'helm-eval-expression-with-eldoc)
    (define-key map (kbd "M-u") 'sp-splice-sexp-killing-backward)
    (define-key map (kbd "C-M-<backspace>") 'backward-kill-sexp)
    (define-key map (kbd "M-l") 'move-to-window-line-top-bottom)
    (define-key map (kbd "C-<return>") 'move-past-close-and-reindent)
    (define-key map (kbd "C-c t") 'multi-term)
    (define-key map (kbd "C-M-h") 'mark-to-end-of-paragraph)
    (define-key map (kbd "M-)") 'kill-to-end-of-sexp)
    (define-key map (kbd "M-(") 'kill-to-beginning-of-sexp)
    (define-key map (kbd "C-M-q") 'unfill-region)
    (define-key map (kbd "M-m") 'delete-indentation)
    (define-key map (kbd "M-n") 'next-logical-line)
    (define-key map (kbd "M-p") 'previous-logical-line)
    (define-key map (kbd "C-\\ C-\\") 'escreen-goto-next-screen)
    (define-key map (kbd "s-f") 'swiper)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter "")

(my-keys-minor-mode 1)

(defun copy-line ()
  (interactive)
  (save-excursion
    (back-to-indentation)
    (set-mark-command nil)
    (move-end-of-line nil)
    (kill-ring-save (mark) (point))))

(defun mark-at-end-or-copy-line ()
  (interactive)
  (if (use-region-p)
      (copy-line)
    (progn
      (set-mark-command nil)
      (move-end-of-line nil)
      (exchange-point-and-mark))))

(global-unset-key (kbd "s-y"))

(global-set-key (kbd "s-y") 'mark-at-end-or-copy-line)

(defun dh-get-relative-path ()
    (interactive)
    (insert (file-relative-name (read-string "Absolute Path: "))))

(defadvice keyboard-escape-quit (around my-keyboard-escape-quit activate)
  "Don't allow esc esc esc to destroy other windows"
  (let (orig-one-window-p)
    (fset 'orig-one-window-p (symbol-function 'one-window-p))
    (fset 'one-window-p (lambda (&optional nomini all-frames) t))
    (unwind-protect
        ad-do-it
      (fset 'one-window-p (symbol-function 'orig-one-window-p)))))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(require 'coffee-mode)
(define-key coffee-mode-map (kbd "C-c C-c r") 'coffee-compile-region)
(define-key coffee-mode-map (kbd "C-c C-c b") 'coffee-compile-buffer)

(define-key dired-mode-map (kbd "TAB") 'dired-subtree-toggle)

(define-key company-active-map (kbd "<escape>") 'company-abort)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)

(require 'helm-ag)

(define-key helm-ag-mode-map (kbd "n") 'next-logical-line)
(define-key helm-ag-mode-map (kbd "p") 'previous-logical-line)
(define-key helm-ag-mode-map (kbd "o") 'helm-ag-mode-jump-other-window)

(global-unset-key (kbd "s-e"))
(global-unset-key (kbd "s-r"))

(global-set-key (kbd "s-e") 'scroll-up-line)
(define-key prelude-mode-map (kbd "s-r") 'scroll-down-line)

(global-set-key (kbd "s-`") #'modalka-global-mode)

;;; Modalka Mode
(add-hook 'modalka-global-mode-hook
          (lambda ()
            (if modalka-global-mode
                (progn
                  (set-cursor-color "#3BBBBB"))
              (progn
                (set-cursor-color "#FFFFEF")))))

(modalka-remove-kbd "h")
(modalka-remove-kbd "j")
(modalka-remove-kbd "k")
(modalka-remove-kbd "l")

(modalka-define-kbd "h" "C-b")
(modalka-define-kbd "j" "C-n")
(modalka-define-kbd "k" "C-p")
(modalka-define-kbd "l" "C-f")

(modalka-define-kbd "M-h" "M-b")
(modalka-define-kbd "M-j" "M-e")
(modalka-define-kbd "M-k" "M-a")
(modalka-define-kbd "M-l" "M-f")

(modalka-define-kbd "s-h" "s-<left>")
(modalka-define-kbd "s-j" "s-<down>")
(modalka-define-kbd "s-k" "s-<up>")
(modalka-define-kbd "s-l" "s-<right>")

(setq modalka-cursor-type 'box)

(define-key prelude-mode-map (kbd "s-h") nil)
(define-key prelude-mode-map (kbd "s-j") nil)
(define-key prelude-mode-map (kbd "s-k") nil)
(define-key prelude-mode-map (kbd "s-l") nil)

(provide 'keybindings)
