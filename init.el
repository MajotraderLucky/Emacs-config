;;; init.el --- Minimal Emacs config (no external packages) -*- lexical-binding: t -*-

;; UTF-8
(prefer-coding-system 'utf-8)

;; Line numbers
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Highlight current line
(global-hl-line-mode 1)

;; No backup files
(setq make-backup-files nil
      create-lockfiles nil)

;; y/n instead of yes/no
(setq use-short-answers t)

;; CUA mode (Ctrl+C/V/X)
(cua-mode 1)

;; Theme
(load-theme 'modus-vivendi t)

;; Window navigation
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)

;; Show matching parens
(show-paren-mode 1)

;; Recent files
(recentf-mode 1)

;; Eglot (built-in LSP)
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(go-mode . ("gopls")))
  (add-to-list 'eglot-server-programs '(python-mode . ("pyright-langserver" "--stdio"))))

(add-hook 'go-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'eglot-ensure)

(message "Init loaded successfully!")
;;; init.el ends here
