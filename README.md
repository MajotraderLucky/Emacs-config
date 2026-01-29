# Emacs Configuration

Personal Emacs configuration with modern completion, LSP support, and git integration.

## Structure

```
~/.config/emacs/
├── init.el          # Main configuration
├── early-init.el    # Early init (UI optimization, GC tuning)
├── custom.el        # Emacs customize system (auto-generated)
├── elpa/            # Installed packages
└── README.md        # This file
```

## Package Management

Uses built-in `package.el` with `use-package` for declarative configuration.

**Repositories:**
- MELPA (https://melpa.org/packages/)
- GNU ELPA (https://elpa.gnu.org/packages/)
- NonGNU ELPA (https://elpa.nongnu.org/nongnu/)

## Installed Packages

### Completion Stack

| Package    | Purpose                              |
|------------|--------------------------------------|
| vertico    | Vertical completion UI               |
| orderless  | Fuzzy/orderless matching             |
| marginalia | Rich annotations in minibuffer       |
| consult    | Enhanced search commands             |
| corfu      | In-buffer completion popup           |

### UI

| Package       | Purpose                           |
|---------------|-----------------------------------|
| doom-themes   | Theme collection (doom-dracula)   |
| doom-modeline | Modern modeline                   |
| which-key     | Keybinding hints                  |
| nerd-icons    | Icons for UI elements             |

### Editor

| Package            | Purpose                        |
|--------------------|--------------------------------|
| rainbow-delimiters | Colored parentheses            |
| electric-pair-mode | Auto-close brackets (built-in) |

### LSP & Languages

| Package         | Purpose                          |
|-----------------|----------------------------------|
| eglot           | LSP client (built-in)            |
| go-mode         | Go language support              |
| rust-mode       | Rust language support            |
| yaml-mode       | YAML support                     |
| markdown-mode   | Markdown support                 |
| json-mode       | JSON support                     |
| dockerfile-mode | Dockerfile support               |

### File Management

| Package             | Purpose                         |
|---------------------|---------------------------------|
| treemacs            | File tree sidebar               |
| treemacs-nerd-icons | Icons for treemacs              |
| treemacs-magit      | Treemacs + magit integration    |

### Git

| Package | Purpose                              |
|---------|--------------------------------------|
| magit   | Git porcelain                        |
| diff-hl | Git diff indicators in gutter        |

### Terminal

| Package | Purpose                  |
|---------|--------------------------|
| vterm   | Full terminal emulator   |

## Keybindings

### File & Search (C-c f)

| Key       | Command             | Description          |
|-----------|---------------------|----------------------|
| C-c f f   | consult-find        | Find file by name    |
| C-c f g   | consult-ripgrep     | Search in files      |
| C-c f r   | consult-recent-file | Recent files         |
| C-c f l   | consult-line        | Search in buffer     |
| C-c f o   | consult-outline     | Jump to heading      |

### Git (C-c g)

| Key       | Command                | Description          |
|-----------|------------------------|----------------------|
| C-c g g   | magit-status           | Git status (main)    |
| C-c g l   | magit-log-current      | Git log              |
| C-c g b   | magit-blame            | Git blame            |
| C-c g d   | magit-diff-buffer-file | Diff current file    |
| C-c g f   | magit-file-dispatch    | File actions menu    |

### LSP (C-c l)

| Key       | Command               | Description          |
|-----------|-----------------------|----------------------|
| M-.       | xref-find-definitions | Go to definition     |
| M-?       | xref-find-references  | Find references      |
| C-c l r   | eglot-rename          | Rename symbol        |
| C-c l a   | eglot-code-actions    | Code actions         |
| C-c l f   | eglot-format-buffer   | Format buffer        |

### Navigation

| Key       | Command             | Description          |
|-----------|---------------------|----------------------|
| M-h       | windmove-left       | Window left          |
| M-j       | windmove-down       | Window down          |
| M-k       | windmove-up         | Window up            |
| M-l       | windmove-right      | Window right         |
| C-x b     | consult-buffer      | Switch buffer        |
| M-g g     | consult-goto-line   | Go to line           |
| M-g i     | consult-imenu       | Jump to symbol       |

### Diagnostics

| Key       | Command                 | Description        |
|-----------|-------------------------|--------------------|
| M-g n     | flymake-goto-next-error | Next error         |
| M-g p     | flymake-goto-prev-error | Previous error     |

### Other

| Key       | Command                | Description          |
|-----------|------------------------|----------------------|
| C-c e     | treemacs               | Toggle file tree     |
| C-c E     | treemacs-select-window | Focus file tree      |
| C-c t     | vterm                  | Open terminal        |
| C-c /     | comment-line           | Toggle comment       |
| C-x k     | kill-current-buffer    | Close buffer         |

## Magit Quick Reference

In `magit-status` buffer (C-c g g):

| Key   | Action                    |
|-------|---------------------------|
| s     | Stage file/hunk           |
| u     | Unstage file/hunk         |
| c c   | Commit                    |
| P p   | Push                      |
| F p   | Pull                      |
| b b   | Checkout branch           |
| b c   | Create branch             |
| l l   | Log current branch        |
| d d   | Diff                      |
| g     | Refresh                   |
| q     | Quit                      |
| ?     | Show all keybindings      |

## Basic Settings

- **Encoding:** UTF-8
- **Line numbers:** Relative (prog-mode, text-mode)
- **Indentation:** Spaces, tab-width 4
- **Theme:** doom-dracula
- **CUA mode:** Enabled (Ctrl+C/V/X work as expected)
- **Backup files:** Disabled
- **Auto-save:** Disabled

## LSP Servers

Eglot automatically connects to LSP servers. Install them separately:

```bash
# Go
go install golang.org/x/tools/gopls@latest

# Python
pip install python-lsp-server

# Rust
rustup component add rust-analyzer
```

## Adding New Packages

```elisp
;; In init.el, add:
(use-package package-name
  :ensure t
  :config
  ;; configuration here
  )
```

Then restart Emacs or run `M-x package-install`.

## Troubleshooting

**Packages not installing:**
```
M-x package-refresh-contents
```

**Check startup errors:**
```bash
emacs --debug-init
```

**Reload configuration:**
```
M-x eval-buffer  # in init.el buffer
```
