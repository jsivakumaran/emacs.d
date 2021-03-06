(defmacro enable-eldoc-mode ()
  "After Emacs 24.4 `turn-on-eldoc-mode is obsoleted, use `eldoc-mode indeed.
  `eldoc-mode shows documentation in the minibuffer when writing code.
  http://www.emacswiki.org/emacs/ElDoc"
  `(if (and (>= emacs-major-version 24)
           (>= emacs-minor-version 4))
      'eldoc-mode
    'turn-on-eldoc-mode))

;; Automatically load paredit when editing a lisp file
;; More at http://www.emacswiki.org/emacs/ParEdit

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (enable-paredit-mode)
            (funcall (enable-eldoc-mode))
            (cond ((string= "*scratch*" (buffer-name))
                   (local-set-key (kbd "RET")
                                  (lambda () (interactive)
                                    (eval-print-last-sexp)
                                    (newline)))
                   (local-set-key (kbd "TAB")
                                  #'complete-symbol)))))

(cond
 ((eq system-type 'gnu/linux)
  (add-hook 'minibuffer-setup-hook
            #'enable-paredit-mode t))
 (t (add-hook 'eval-expression-minibuffer-setup-hook
              #'enable-paredit-mode)))

(add-hook 'ielm-mode-hook
          (lambda ()
            (enable-paredit-mode)
            (funcall (enable-eldoc-mode))))

(add-hook 'lisp-mode-hook
          #'enable-paredit-mode)

(add-hook 'lisp-interaction-mode-hook
          #'enable-paredit-mode)

(add-hook 'scheme-mode-hook
          (lambda ()
            (enable-paredit-mode)
            (funcall (enable-eldoc-mode))))

(add-hook 'inferior-scheme-mode-hook
          (lambda ()
            (enable-paredit-mode)
            (funcall (enable-eldoc-mode))))



