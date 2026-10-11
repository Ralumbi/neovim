# Neovim Configuration

A clean, modern, and high-performance Neovim configuration featuring full IDE capabilities: Language Server Protocol (LSP), autocompletion, fuzzy finding, Treesitter syntax highlighting, code formatting, linting, integrated terminal utilities, and git integration.

---

## Prerequisites & Required Packages

To ensure all plugins, treesitter parsers, and Mason tools function properly, the following packages should be installed on your system.

### 1. Core System Tools
- **Neovim** (>= 0.9.0, recommended `0.10+`)
- **Git** (required for `lazy.nvim`, plugin updates, and git integrations)
- **C/C++ Compiler (`gcc` or `clang`) & `make`** (required for compiling Treesitter parsers and native C extensions)
- **`curl`**, **`tar`**, and **`unzip`** (required by Mason to download and extract language servers/tools)
- **`ripgrep` (`rg`)** (required by Telescope for `live_grep` and fast search)
- **`fd`** (recommended by Telescope for fast file indexing)
- **Clipboard Utility**:
  - Wayland: `wl-clipboard`
  - X11: `xclip` or `xsel`
  - macOS: built-in `pbcopy`/`pbpaste`
- **A Nerd Font** (e.g. JetBrainsMono Nerd Font, FiraCode Nerd Font) for icons via `nvim-web-devicons`.

### 2. Language Runtimes (for Mason LSPs & Formatters)
- **Node.js** & **npm** (required by Mason to run web/JS/TS/JSON/Python language servers like `pyright`, `ts_ls`, `prettier`, `eslint_d`, `marksman`, `bashls`, etc.)
- **Python 3** & **pip** / **venv** (for Python LSP, REPL, and tools like `black`, `isort`, `flake8`)
- **Go** (for `gopls`)
- **Clang / LLVM** (for `clangd` and `clang-format`)

### 3. Integrated Terminal Tools (invoked via `<leader>t`)
- **`lazygit`** (for the floating Git UI via `<leader>tg`)
- **`htop`** (for the process monitor via `<leader>tm`)
- **`python3`** (for the floating interactive Python REPL via `<leader>tp`)

---

## Installation by Operating System

### Arch Linux
```bash
sudo pacman -S --needed \
  neovim git gcc make curl tar unzip ripgrep fd \
  wl-clipboard xclip \
  nodejs npm python python-pip go clang \
  lazygit htop
```

### Ubuntu / Debian
```bash
sudo apt update
sudo apt install -y \
  neovim git build-essential curl tar unzip ripgrep fd-find \
  wl-clipboard xclip \
  nodejs npm python3 python3-pip python3-venv golang clang \
  htop

# Note: For lazygit on Ubuntu/Debian:
# Follow official instructions: https://github.com/jesseduffield/lazygit#ubuntu
```

### Fedora
```bash
sudo dnf install -y \
  neovim git gcc gcc-c++ make curl tar unzip ripgrep fd-find \
  wl-clipboard xclip \
  nodejs npm python3 python3-pip golang clang \
  lazygit htop
```

### macOS (Homebrew)
```bash
brew install \
  neovim git gcc make curl ripgrep fd \
  node python go llvm \
  lazygit htop
```

---

## Setup & First Launch

1. **Clone this repository into your Neovim config directory**:
   ```bash
   git clone https://github.com/Ralumbi/neovim.git ~/.config/nvim
   ```

2. **Start Neovim**:
   ```bash
   nvim
   ```

3. **Automatic Installation**:
   - `lazy.nvim` will bootstrap itself and install all required plugins.
   - `mason.nvim` and `mason-tool-installer` will automatically begin installing all configured LSPs, linters, and formatters.
   - `nvim-treesitter` will compile the language parsers.
   - Restart Neovim once the initial installation finishes.

---

## Included Languages & Tools

### Language Servers (LSP via Mason)
- **Go**: `gopls`
- **Lua**: `lua_ls`
- **Python**: `pyright`
- **TypeScript / JavaScript**: `ts_ls`
- **HTML / CSS**: `html`, `cssls`
- **Bash / Shell**: `bashls`
- **Prisma**: `prismals`
- **Markdown**: `marksman`
- **C / C++**: `clangd`

### Formatters (via Conform)
- `stylua` (Lua)
- `black` & `isort` (Python)
- `prettier` (JS, TS, HTML, CSS, Markdown)
- `clang-format` (C, C++)
- `shfmt` (Bash / Shell)

### Linters (via nvim-lint)
- `flake8` (Python)
- `eslint_d` (JS, TS)
- `shellcheck` (Bash / Shell)

---

## Keybindings Cheat Sheet

Leader key is mapped to `<Space>`.

### Navigation & Windows
| Key | Action |
| --- | --- |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Seamless window navigation (left, down, up, right) |
| `<C-Up>` / `<C-Down>` / `<C-Left>` / `<C-Right>` | Resize window splits |
| `<leader>sv` / `<leader>sh` | Split window vertically / horizontally |
| `<leader>se` / `<leader>sx` | Equalize splits / Close current split |
| `[b` / `]b` | Previous / Next buffer |
| `<leader>bd` | Delete current buffer |
| `<leader>w` / `<leader>q` | Quick save / Quick quit |
| `<leader>e` | Toggle file tree (`nvim-tree`) |

### Fuzzy Finder (`Telescope`)
| Key | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep project text |
| `<leader>fb` | Open buffers |
| `<leader>fo` | Recent files |
| `<leader>fs` | Grep word under cursor |
| `<leader>ft` | Find `TODO` / `FIXME` comments |
| `<leader>fc` | Browse Neovim config files |

### Terminal & Utilities (`ToggleTerm`)
| Key | Action |
| --- | --- |
| `<C-\>` | Toggle floating terminal |
| `<leader>tt` / `<leader>tf` | Toggle floating terminal |
| `<leader>th` / `<leader>tv` | Toggle horizontal / vertical terminal split |
| `<leader>tg` | Open **Lazygit** UI |
| `<leader>tm` | Open **htop** process monitor |
| `<leader>tp` | Open interactive **Python REPL** |
| `<Esc><Esc>` | Exit terminal mode to normal mode |

### LSP, Code Actions & Formatting
| Key | Action |
| --- | --- |
| `gd` / `K` | Go to definition / Hover documentation |
| `<leader>ca` | Code action |
| `<leader>cr` / `<leader>rn` | Rename symbol across project |
| `<leader>cf` / `<leader>fm` | Format current file or selection |
| `[d` / `]d` | Previous / Next diagnostic error/warning |
| `<leader>cd` | Floating diagnostic preview |

### Git (`Gitsigns`)
| Key | Action |
| --- | --- |
| `]h` / `[h` | Next / Previous git hunk |
| `<leader>gp` | Preview git hunk |
| `<leader>gb` | Full git blame line |
| `<leader>gd` | Diff current buffer |
| `<leader>gs` / `<leader>gu` | Stage / Undo stage hunk |
| `<leader>gr` / `<leader>gR` | Reset hunk / Reset buffer |
