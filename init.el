;;; init.el --- Emacs configuration with packages -*- lexical-binding: t -*-

;;; Package management (package.el)
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
(package-initialize)

;; Refresh package contents if needed
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if needed
(unless (package-installed-p 'use-package)
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

;; Load doom-dracula theme immediately
(require 'doom-themes)
(load-theme 'doom-dracula t)
(doom-themes-visual-bell-config)
(message ">>> doom-dracula theme loaded!")

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

;;; ============ FILE TREE ============

(use-package treemacs
  :bind (("C-c e" . treemacs)
         ("C-c E" . treemacs-select-window))
  :custom
  (treemacs-width 35)
  (treemacs-git-mode 'deferred)
  (treemacs-show-hidden-files t))

(use-package treemacs-nerd-icons
  :after (treemacs nerd-icons)
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package treemacs-magit
  :after (treemacs magit))

;;; ============ TERMINAL ============

;; Use eshell (built-in, always works)
(global-set-key (kbd "C-c t") 'eshell)

;; vterm disabled - was causing freezes
;; (use-package vterm
;;   :commands vterm
;;   :bind ("C-c t" . vterm)
;;   :custom
;;   (vterm-max-scrollback 10000)
;;   (vterm-shell "/bin/bash"))

;;; ============ GIT ============

;; Magit - install manually: M-x package-refresh-contents, then M-x package-install RET magit
(use-package magit
  :defer t
  :bind (("C-c g g" . magit-status)
         ("C-c g l" . magit-log-current)
         ("C-c g b" . magit-blame)
         ("C-c g d" . magit-diff-buffer-file)
         ("C-c g f" . magit-file-dispatch))
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  (magit-diff-refine-hunk 'all))

(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
         (text-mode . diff-hl-mode))
  :config
  (diff-hl-flydiff-mode)
  ;; Magit integration (when magit loads)
  (with-eval-after-load 'magit
    (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)))

;;; ============ ORG-MODE ============

(use-package org
  :ensure nil
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link))
  :custom
  ;; TODO states for Kanban
  (org-todo-keywords
   '((sequence "TODO(t)" "ACTIVE(a)" "WAIT(w)" "BLOCKED(b)" "|" "DONE(d)" "CANCELLED(c)")))
  ;; Colors for TODO states
  (org-todo-keyword-faces
   '(("TODO" . (:foreground "#ff79c6" :weight bold))
     ("ACTIVE" . (:foreground "#50fa7b" :weight bold))
     ("WAIT" . (:foreground "#ffb86c" :weight bold))
     ("BLOCKED" . (:foreground "#ff5555" :weight bold))
     ("DONE" . (:foreground "#6272a4" :weight bold))
     ("CANCELLED" . (:foreground "#6272a4" :strike-through t))))
  ;; Log completion time
  (org-log-done 'time)
  ;; Clocking
  (org-clock-persist t)
  ;; Pretty bullets
  (org-hide-leading-stars t)
  (org-startup-indented t)
  :config
  (org-clock-persistence-insinuate))

;; Pretty bullets for org
(use-package org-bullets
  :hook (org-mode . org-bullets-mode))

;;; ============ BROWSER ============

;; Use qutebrowser for opening URLs
(setq browse-url-generic-program "/usr/bin/qutebrowser")
(setq browse-url-browser-function 'browse-url-generic)

;;; ============ TELEGRAM ============

(use-package telega
  :commands telega
  :bind ("<f9>" . telega)
  :custom
  (telega-use-images t)
  (telega-emoji-use-images nil)
  (telega-chat-fill-column 80)
  (telega-proxies nil)
  ;; Use qutebrowser for links
  (telega-browse-url-alist '((".*" . (lambda (url &rest args)
                                        (start-process "qutebrowser" nil "qutebrowser" url))))))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(vterm yaml-mode which-key vertico rust-mode rainbow-delimiters orderless markdown-mode marginalia json-mode go-mode doom-themes doom-modeline dockerfile-mode diff-hl corfu consult)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
