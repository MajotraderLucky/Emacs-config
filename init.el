;;; init.el --- Emacs configuration with packages -*- lexical-binding: t -*-

;;; Package management (package.el)
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

;; Install use-package if needed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; ============ BASIC SETTINGS ============

;; UTF-8
(prefer-coding-system 'utf-8)

;; Line numbers
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)

;; Highlight current line
(global-hl-line-mode 1)

;; Indentation
(setq-default indent-tabs-mode nil
              tab-width 4)

;; No backup files
(setq make-backup-files nil
      create-lockfiles nil
      auto-save-default nil)

;; y/n instead of yes/no
(setq use-short-answers t)

;; Disable bell
(setq ring-bell-function 'ignore)

;; CUA mode (Ctrl+C/V/X)
(cua-mode 1)

;; Delete selection when typing
(delete-selection-mode 1)

;; Recent files
(recentf-mode 1)
(setq recentf-max-saved-items 100)

;; Auto-revert files
(global-auto-revert-mode 1)

;; Show matching parens
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Smooth scrolling
(setq scroll-conservatively 101
      scroll-margin 3)

;; Save minibuffer history
(savehist-mode 1)

;; Remember cursor position
(save-place-mode 1)

;;; ============ THEME ============

(use-package doom-themes
  :config
  (load-theme 'doom-tokyo-night t)
  (doom-themes-visual-bell-config))

;;; ============ COMPLETION ============

(use-package vertico
  :init (vertico-mode)
  :custom
  (vertico-count 15)
  (vertico-cycle t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil))

(use-package marginalia
  :init (marginalia-mode))

(use-package consult
  :bind (("C-c f f" . consult-find)
         ("C-c f g" . consult-ripgrep)
         ("C-c f r" . consult-recent-file)
         ("C-c f l" . consult-line)
         ("C-c f o" . consult-outline)
         ("C-x b" . consult-buffer)
         ("M-g g" . consult-goto-line)
         ("M-g i" . consult-imenu)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)))

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.2)
  (corfu-cycle t)
  :init (global-corfu-mode))

;;; ============ UI ============

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 28)
  (doom-modeline-buffer-encoding nil))

(use-package which-key
  :config (which-key-mode)
  :custom
  (which-key-idle-delay 0.5))

(use-package nerd-icons)

;;; ============ EDITOR ============

;; Rainbow delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Auto-pairs
(electric-pair-mode 1)

;;; ============ LSP (EGLOT) ============

(use-package eglot
  :ensure nil
  :hook ((go-mode python-mode rust-mode) . eglot-ensure)
  :bind (:map eglot-mode-map
         ("M-." . xref-find-definitions)
         ("M-?" . xref-find-references)
         ("C-c l r" . eglot-rename)
         ("C-c l a" . eglot-code-actions)
         ("C-c l f" . eglot-format-buffer))
  :config
  (setq eglot-autoshutdown t))

;;; ============ LANGUAGES ============

(use-package go-mode
  :hook (go-mode . (lambda ()
                     (add-hook 'before-save-hook #'eglot-format-buffer nil t))))

(use-package rust-mode)
(use-package yaml-mode)
(use-package markdown-mode)
(use-package json-mode)
(use-package dockerfile-mode)

;;; ============ GIT ============

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (text-mode . diff-hl-mode))
  :config
  (diff-hl-flydiff-mode))

;;; ============ KEYBINDINGS ============

;; Window navigation
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)

;; Buffer navigation
(global-set-key (kbd "C-x <right>") 'next-buffer)
(global-set-key (kbd "C-x <left>") 'previous-buffer)

;; Kill buffer
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; Comment
(global-set-key (kbd "C-c /") 'comment-line)

;; Diagnostics
(global-set-key (kbd "M-g n") 'flymake-goto-next-error)
(global-set-key (kbd "M-g p") 'flymake-goto-prev-error)

(message "Init loaded successfully!")
;;; init.el ends here
