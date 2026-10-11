-- ==============================================================================
-- 1. CORE SETTINGS
-- ==============================================================================
vim.g.mapleader = " "              -- Set Space as the leader key
vim.g.maplocalleader = " "          -- Set Local Leader to Space as well

vim.opt.clipboard = "unnamedplus"   -- Sync with system clipboard
vim.opt.number = true               -- Show line numbers
vim.opt.relativenumber = true       -- Relative line numbers
vim.opt.tabstop = 4                 -- 4 spaces for tabs
vim.opt.shiftwidth = 4
vim.opt.expandtab = true            -- Convert tabs to spaces
vim.opt.smartindent = true

vim.opt.undofile = true             -- Persistent undo history across sessions
vim.opt.ignorecase = true           -- Case insensitive searching
vim.opt.smartcase = true            -- Case sensitive if uppercase letter is present
vim.opt.cursorline = true           -- Highlight the current line
vim.opt.updatetime = 250            -- Faster completion & gitsigns refresh
vim.opt.timeoutlen = 300            -- Faster which-key popup and key response

vim.opt.signcolumn = "yes"          -- Always show signcolumn to prevent layout shifts
vim.opt.scrolloff = 8               -- Keep 8 lines above/below cursor when scrolling
vim.opt.sidescrolloff = 8           -- Keep 8 columns to the left/right of cursor
vim.opt.splitbelow = true           -- Force horizontal splits below current window
vim.opt.splitright = true           -- Force vertical splits right of current window
vim.opt.termguicolors = true        -- True color support in terminals
vim.opt.wrap = false                -- Disable line wrapping by default
vim.opt.inccommand = "split"        -- Live interactive preview of substitutions
vim.opt.swapfile = false            -- Disable annoying swapfile prompts (undofile handles safety)
vim.opt.pumheight = 10              -- Max items in autocomplete pop-up menu


-- ==============================================================================
-- 2. GENERAL KEYMAPS & ERGONOMICS
-- ==============================================================================
-- Clear search highlights with Esc
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Fast buffer save & quit
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })

-- Seamless Window Navigation (<C-h>, <C-j>, <C-k>, <C-l>)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Window Management (<leader>s...)
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split Window Vertically" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split Window Horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize Window Sizes" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close Current Split" })

-- Window Resizing (Ctrl + Arrow keys)
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })

-- Buffer Navigation (<leader>b... or [b / ]b)
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Current Buffer" })

-- Visual Mode Line Movement (J / K moves selected lines)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })

-- Better Indentation (stay in visual mode)
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left & Keep Selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right & Keep Selection" })

-- Centered Scrolling & Searching
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down & Center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up & Center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search Match & Center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Search Match & Center" })

-- Diagnostics Navigation
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics Popup" })


-- ==============================================================================
-- 3. BOOTSTRAP LAZY.NVIM (Plugin Manager)
-- ==============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- ==============================================================================
-- 4. LOAD & CONFIGURE PLUGINS
-- ==============================================================================
require("lazy").setup({
  -- ---------------------------------------------------------------------------
  -- Theme
  -- ---------------------------------------------------------------------------
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end
  },

  -- ---------------------------------------------------------------------------
  -- Syntax Highlighting (Treesitter)
  -- ---------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "go", "lua", "bash", "json", "python", "javascript",
          "typescript", "prisma", "markdown", "markdown_inline", "c", "cpp"
        },
        highlight = { enable = true }
      })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Sidepanel File Explorer (nvim-tree)
  -- ---------------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")
        -- Keep all default nvim-tree keymaps
        api.config.mappings.default_on_attach(bufnr)
        -- Ensure Ctrl+k navigates to upper window rather than showing tree Info
        vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Go to Upper Window", buffer = bufnr, nowait = true })
      end

      require("nvim-tree").setup({
        on_attach = on_attach,
      })
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle File Explorer" })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Integrated Terminal (ToggleTerm) with rich <leader>t options
  -- ---------------------------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.4)
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        persist_mode = true,
        direction = "float",
        close_on_exit = true,
        float_opts = {
          border = "curved",
          winblend = 0,
        },
      })

      -- Keymaps inside terminal mode
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- Double Esc to exit terminal mode back to normal mode
        vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], opts)
        -- Seamless window navigation directly out of terminal split
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          set_terminal_keymaps()
        end,
      })

      -- Dedicated Terminal instances
      local Terminal = require("toggleterm.terminal").Terminal

      -- 1. Lazygit (Floating Git client)
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = { border = "curved" },
      })

      -- 2. Process Monitor (htop)
      local htop = Terminal:new({
        cmd = "htop",
        hidden = true,
        direction = "float",
        float_opts = { border = "curved" },
      })

      -- 3. Interactive Python REPL
      local python = Terminal:new({
        cmd = "python3",
        hidden = true,
        direction = "float",
        float_opts = { border = "curved" },
      })

      -- Keybindings under <leader>t:
      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle Floating Terminal" })
      vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle Floating Terminal" })
      vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<CR>", { desc = "Toggle Horizontal Terminal" })
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm size=60 direction=vertical<CR>", { desc = "Toggle Vertical Terminal" })
      vim.keymap.set("n", "<leader>tb", "<cmd>ToggleTerm direction=tab<CR>", { desc = "Toggle Tab Terminal" })
      vim.keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Toggle Lazygit (Git UI)" })
      vim.keymap.set("n", "<leader>tm", function() htop:toggle() end, { desc = "Toggle Process Monitor (htop)" })
      vim.keymap.set("n", "<leader>tp", function() python:toggle() end, { desc = "Toggle Python REPL" })
      vim.keymap.set("n", "<leader>t1", "<cmd>1ToggleTerm<CR>", { desc = "Toggle Terminal #1" })
      vim.keymap.set("n", "<leader>t2", "<cmd>2ToggleTerm<CR>", { desc = "Toggle Terminal #2" })
      vim.keymap.set("n", "<leader>t3", "<cmd>3ToggleTerm<CR>", { desc = "Toggle Terminal #3" })
      vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle All Terminals" })
      vim.keymap.set("n", "<leader>tl", "<cmd>ToggleTermSendCurrentLine<CR>", { desc = "Send Line to Terminal" })
      vim.keymap.set("v", "<leader>ts", "<cmd>ToggleTermSendVisualSelection<CR>", { desc = "Send Selection to Terminal" })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Statusline (Lualine)
  -- ---------------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight" },
        sections = {
          lualine_c = {
            { 'filename', path = 1 } -- Relative path
          }
        }
      })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Keybinding Helper & Guide (Which-Key)
  -- ---------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
      })
      wk.add({
        { "<leader>t", group = "Terminal" },
        { "<leader>f", group = "Find / Telescope" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Splits / Windows" },
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code / LSP" },
      })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Git Integrations & Signs (Gitsigns)
  -- ---------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      local gs = require("gitsigns")
      gs.setup({
        on_attach = function(bufnr)
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation between hunks
          map('n', ']h', function()
            if vim.wo.diff then return ']h' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = "Next Git Hunk" })

          map('n', '[h', function()
            if vim.wo.diff then return '[h' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, desc = "Previous Git Hunk" })

          -- Git Actions (<leader>g...)
          map('n', '<leader>gp', gs.preview_hunk, { desc = "Preview Hunk" })
          map('n', '<leader>gb', function() gs.blame_line{ full = true } end, { desc = "Blame Line (Full)" })
          map('n', '<leader>gd', gs.diffthis, { desc = "Diff Current Buffer" })
          map('n', '<leader>gs', gs.stage_hunk, { desc = "Stage Hunk" })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
          map('n', '<leader>gr', gs.reset_hunk, { desc = "Reset Hunk" })
          map('n', '<leader>gR', gs.reset_buffer, { desc = "Reset Buffer" })
          map('v', '<leader>gs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Stage Selected Lines" })
          map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, { desc = "Reset Selected Lines" })
        end
      })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Autopairs
  -- ---------------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },

  -- ---------------------------------------------------------------------------
  -- Indentation Guides
  -- ---------------------------------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- ---------------------------------------------------------------------------
  -- Fast Surround Text Manipulation (nvim-surround)
  -- e.g. ysiw" (add quotes around word), cs"' (change " to '), ds" (delete ")
  -- ---------------------------------------------------------------------------
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true
  },

  -- ---------------------------------------------------------------------------
  -- Modern Modal UI for Input & Select (Dressing.nvim)
  -- ---------------------------------------------------------------------------
  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  -- ---------------------------------------------------------------------------
  -- TODO / FIXME Comment Highlighting & Search
  -- ---------------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- ---------------------------------------------------------------------------
  -- Fuzzy Finder (Telescope)
  -- ---------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      -- Find files & text
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find Open Buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = "Recent Files" })
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Grep String Under Cursor" })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Search Keymaps" })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = "Search Diagnostics" })
      vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<CR>', { desc = "Search TODO / FIXME Comments" })

      -- Config & Git
      vim.keymap.set('n', '<leader>fc', function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "Find Neovim Config Files" })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Search Git Commits" })
      vim.keymap.set('n', '<leader>gS', builtin.git_status, { desc = "Git Status Picker" })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Language Support (LSP & Autocomplete)
  -- ---------------------------------------------------------------------------
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })

        -- Additional Code Action & Rename shortcuts
        local opts = { buffer = bufnr }
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = "Code Action" }))
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = "Rename Symbol" }))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = "Rename Symbol" }))
      end)

      -- Clean rounded diagnostic borders
      vim.diagnostic.config({
        float = { border = "rounded" },
      })

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls", "lua_ls", "pyright", "bashls", "html",
          "cssls", "ts_ls", "prismals", "marksman", "clangd"
        },
        handlers = { lsp_zero.default_setup },
      })

      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        })
      })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Formatters & Linters Tool Installer
  -- ---------------------------------------------------------------------------
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier", "black", "isort", "clang-format", "shfmt", "stylua",
          "flake8", "eslint_d", "shellcheck"
        },
      })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Formatter Runner (Conform)
  -- ---------------------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          markdown = { "prettier" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          sh = { "shfmt" },
          bash = { "shfmt" },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
      end, { desc = "Format file or range" })
      vim.keymap.set({ "n", "v" }, "<leader>cf", function()
        require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
      end, { desc = "Format file or range" })
    end
  },

  -- ---------------------------------------------------------------------------
  -- Linter Runner (nvim-lint)
  -- ---------------------------------------------------------------------------
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "flake8" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      }
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end
  }
})
