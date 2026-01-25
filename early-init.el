;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;; Increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Disable UI elements early
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; Disable startup messages
(setq inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name
      initial-scratch-message nil)

;; Restore GC after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))))

;;; early-init.el ends here
