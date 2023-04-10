;;; org-modern-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "org-modern" "org-modern.el" (0 0 0 0))
;;; Generated autoloads from org-modern.el

(autoload 'org-modern-mode "org-modern" "\
Modern looks for Org.

If called interactively, enable Org-Modern mode if ARG is
positive, and disable it if ARG is zero or negative.  If called
from Lisp, also enable the mode if ARG is omitted or nil, and
toggle it if ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(autoload 'org-modern-agenda "org-modern" "\
Finalize Org agenda highlighting." nil nil)

(put 'global-org-modern-mode 'globalized-minor-mode t)

(defvar global-org-modern-mode nil "\
Non-nil if Global Org-Modern mode is enabled.
See the `global-org-modern-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-org-modern-mode'.")

(custom-autoload 'global-org-modern-mode "org-modern" nil)

(autoload 'global-org-modern-mode "org-modern" "\
Toggle Org-Modern mode in all buffers.
With prefix ARG, enable Global Org-Modern mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Org-Modern mode is enabled in all buffers where
`org-modern--on' would do it.
See `org-modern-mode' for more information on Org-Modern mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "org-modern" '("org-modern-")))

;;;***

;;;### (autoloads nil nil ("org-modern-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; org-modern-autoloads.el ends here
