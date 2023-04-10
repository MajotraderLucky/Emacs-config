;; System-type definition
(defun system-is-linux()
    (string-equal system-type "gnu/linux"))
(defun system-is-windows()
    (string-equal system-type "windows-nt"))
;; Start Emacs as a server
(when (system-is-linux)
    (require 'server)
    (unless (server-running-p)
        (server-start))) ;; Запустить Emacs как сервер, если ОС - GNU/Linux
;; Unix path-variable
(when (system-is-linux)
    (setq unix-sbcl-bin          "/usr/bin/sbcl")
    (setq unix-init-path         "~/.emacs.d")
    (setq unix-init-ct-path      "~/.emacs.d/plugins/color-theme")
    (setq unix-init-ac-path      "~/.emacs.d/plugins/auto-complete")
    (setq unix-init-slime-path   "/usr/share/common-lisp/source/slime")
    (setq unix-init-ac-dict-path "~/.emacs.d/plugins/auto-complete/dict"))
;; My name and e-mail adress
(setq user-full-name   "%Sergey Ryazanov%")
(setq user-mail-adress "%ryazanov@majordomo.ru%")
;; Dired
(require 'dired)
(setq dired-recursive-deletes 'top) ;; чтобы можно было не пустые директории удалять...
;; Imenu
(require 'imenu)
(setq imenu-auto-rescan t)           ;; автоматически обновлять список функций в буфере
(setq imenu-use-popup-menu nil)      ;; диалоги Imenu только в минибуфере
(global-set-key (kbd "<f6>") 'imenu) ;; вызов Imenu на F6
;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")
;; Load path for plugins
(if (system-is-windows)
    (add-to-list 'load-path win-init-path)
    (add-to-list 'load-path unix-init-path))
;; Org-mode settings
(require 'org) ;; Вызвать org-mode
(global-set-key "\C-ca" 'org-agenda)   ;; определение клавиатурных комбинаций для внутренних
(global-set-key "\C-cb" 'org-iswitchb) ;; подрежимов org-mode
(global-set-key "\C-cl" 'org-store-link)
(add-to-list 'auto-mode-alist '("\\.org$" . Org-mode)) ;; ассоциируем *.org-файлы с org-mode
;; Inhibit startup/splash screen
(setq inhibit-splash-screen t)
(setq ingibit-startup-message t) ;; экран приветствия можно вызвать комбинацией C-h C-a
;; Show-paren-mode settings
(show-paren-mode t) ;; включить выделение выражений между {}, [], ()
;; Electric-modes settings
(electric-pair-mode t) ;; автозакрытие {}, [], () с переводом курсора внутрь скобок
(electric-indent-mode t) ;; отключить индентацию electric-indent-mod`ом (default in Emacs-24-4)
;; Delete selection
(delete-selection-mode t)
;; Disable GUI components
(tooltip-mode      -1)
(menu-bar-mode     -1) ;; отключаем графическое меню
(tool-bar-mode     -1) ;; отключаем tool-bar
(scroll-bar-mode   -1) ;; отключаем полосу прокрутки
(blink-cursor-mode -1) ;; курсор не мигает
(setq use-dialog-box     nil) ;; никаких графических диалогов и окон - всё через минибуфер
(setq redisplay-dont-pause t) ;; лучшая отрисовка буфера
(setq ring-bell-function 'ignore) ;;отключить звуковой сигнал
;; Disable backup/autosave files
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil) ;; я так привык... хотите включить - замените nil на t
;; Coding-system settings
(set-language-environment 'UTF-8)
(if (system-is-linux) ;; для GNU/Linux кодировка utf-8, для MS Windows - windows-1251
    (progn
        (setq default-buffer-file-coding-system        'utf-8)
        (setq-default coding-system-for-read           'utf-8)
        (setq file-name-coding-system                  'utf-8)
        (set-selection-coding-system                   'utf-8)
        (set-keyboard-coding-system               'utf-8-unix)
        (set-terminal-coding-system                    'utf-8)))
;; Linum plugin
(require 'linum) ;; вызвать Linum
(line-number-mode   t) ;; показать номер строки в mode-line
(global-linum-mode  t) ;; показывать номера строк во всех буферах
(column-number-mode t) ;; показать номер столбца в mode-line
(setq linum-format " %d") ;; задаём формат нумерации строк
;; Fring settings
(fringe-mode '(8 . 0)) ;; ограничитель текста только слева
(setq-default indicate-empty-lines t) ;; отсутствие строки выделить глифами рядом с полосой с номером строки
(setq-default indicate-buffer-boundaries 'left) ;; индикация только слева
;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode             t) ;; показывать часы в mode-line
(size-indication-mode          t) ;; размер файла в %-ах
;; Line wrapping
(setq word-wrap                t) ;; переносить по словам
(global-visual-line-mode       t)
;; Start window size
(when (window-system)
    (set-frame-size (selected-frame)100 50))
;; IDO plugin
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-virtual-buffers      t)
(setq ido-enable-flex-matching t)
;; Buffer Selection and ibuffer settings
(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer) ;; отдельный список буферов при нажатии C-x C-b
(global-set-key (kbd "<f2>")'bs-show) ;; запуск buffer selection кнопкой F2

;; Color-theme definition <http://www.emacswiki.org/emacs/ColorTheme>
(defun color-theme-init()
    (require 'color-theme)
    (color-theme-initialize)
    (setq color-theme-is-global t)
    (if (system-is-windows)
        (when (file-directory-p win-init-ct-path)
            (add-to-list 'load-path win-init-ct-path)
            (color-theme-init))
        (when (file-directory-p unix-init-ct-path)
            (add-to-list 'load-path unix-init-ct-path)
            (color-theme-init))))

;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode             t) ;; включено с версии Emacs-22. На всякий...
(setq font-lock-maximum-decoration t)
;; Indent settings
(setq-default indent-tabs-mode nil) ;; отключить возможность ставить отступы TAB'ом
(setq-default tab-width          4) ;; ширина табуляции - 4 пробельных символа
(setq-default c-basic-offset     4)
(setq-default standart-indent    4) ;; стандартная ширина отступа - 4 пробельных символа
(setq-default lisp-body-indent   4) ;; сдвигать Lisp-выражения на 4 пробельных символа
(global-set-key (kbd "RET") 'newline-and-indent) ;; при нажатии Enter перевести )
(setq lisp-indent-function 'common-lisp-indent-function)
;; Scrolling settings
(setq scroll-step               1) ;; вверх-вниз по 1 строке
(setq scroll-margin            10) ;; сдвигать буфер вверх/вниз когда курсор в 10 шагах от верхней/нижней границы
(setq scroll-conservatively 10000)
;; Short message
(defalias 'yes-or-no-p 'y-or-n-p)
;; Clipboard settings
(setq x-select-enable-clipboard t)
;; End of file newlines
(setq require-final-newline    t) ;; добавлять новую пустую строку в конец файла при сохранении
(setq next-line-add-newlines nil) ;; не добавлять новую строку в конец при смещении
;; курсора стрелками
;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)
;; Easy transition between buffers: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))

;; Пакет CEDET — работа с C/C++/Java
;; CEDET settings
(require 'cedet) ;; использую "вшитую" версию CEDET. Мне хватает...
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)
(semantic-mode   t)
(global-ede-mode t)
(require 'ede/generic)
(require 'semantic/ia)
(ede-enable-generic-projects)

;; SLIME settings
(defun run-slime()
    (require 'slime)
    (require 'slime-autoloads)
    (setq slime-net-coding-system 'utf-8-unix)
    (slime-setup '(slime-fancy slime-asdf slime-indentation))) ;; загрузить основные дополнения Slime
;;;; for MS Windows
(when (system-is-windows)
    (when (and (file-exists-p win-sbcl-exe) (file-directory-p win-init-slime-path))
        (setq inferior-lisp-program win-sbcl-exe)
        (add-to-list 'load-path win-init-slime-path)
        (run-slime)))
;;;; for GNU/Linux
(when (system-is-linux)
    (when (and (file-exists-p unix-sbcl-bin) (file-directory-p unix-init-slime-path))
        (setq inferior-lisp-program unix-sbcl-bin)
        (add-to-list 'load-path unix-init-slime-path)
        (run-slime)))

;; Bookmark settings
(require 'bookmark)
(setq bookmark-save-flag t) ;; автоматически сохранять закладки в файл
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t)) ;; попытаться найти и открыть файл с закладками
(global-set-key (kbd "<f3>") 'bookmark-set) ;; создать закладку по F3 
(global-set-key (kbd "<f4>") 'bookmark-jump) ;; прыгнуть на закладку по F4
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list) ;; открыть список закладок
(setq bookmark-default-file (concat user-emacs-directory "bookmarks")) ;; хранить закладки в файл bookmarks в .emacs.d
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(yasnippet company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/color-theme-ahungry/")

;; Only set this if you wish to retain your own font settings
;; otherwise, leave it out.
(setq ahungry-theme-font-settings nil)

(load-theme 'ahungry t)

(add-to-list 'load-path "~/.emacs.d/color-theme-ahungry/")
(require 'color-theme-ahungry)
(color-theme-ahungry)

;; Added Go-mode
(add-to-list 'load-path "/home/ryazanov/.emacs.d/plugins/go-mode.el-master")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; Flycheck checker
;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
(setq flycheck-gometalinter-vendor t)
;; only show errors
(setq flycheck-gometalinter-errors-only t)
;; only run fast linters
(setq flycheck-gometalinter-fast t)
;; use in tests files
(setq flycheck-gometalinter-tests t)
;; disable linters
(setq flycheck-gometalinter-disable-linters '("gotype" "gocyclo"))
;; Only enable selected linters
(setq flycheck-gometalinter-disable-all t)
(setq flycheck-gometalinter-enable-linters '("golint"))
;; Set different deadline (default: 5s)
(setq flycheck-gometalinter-deadline "10s")
;; Use a gometalinter configuration file (default: nil)
(setq flycheck-gometalinter-config "/path/to/gometalinter-config.json")

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)
(put 'upcase-region 'disabled nil)
