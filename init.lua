-- 1. CORE SETTINGS
vim.g.mapleader = " " -- Set Space as the leader key
vim.opt.clipboard = "unnamedplus" -- System clipboard
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 4 -- 4 spaces for tabs
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true

vim.opt.undofile = true -- Persistent undo
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.cursorline = true -- Highlight the current line
vim.opt.updatetime = 250 -- Decrease update time


-- 2. BOOTSTRAP LAZY.NVIM (Plugin Manager)
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

-- 3. LOAD PLUGINS
require("lazy").setup({
  -- Theme
  { "folke/tokyonight.nvim", priority = 1000, config = function() vim.cmd([[colorscheme tokyonight-night]]) end },

  -- Syntax Highlighting
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
      require("nvim-treesitter").setup({ ensure_installed = { "go", "lua", "bash", "json", "python", "javascript", "typescript", "prisma", "markdown", "markdown_inline", "c", "cpp" }, highlight = { enable = true } })
    end
  },

  -- Sidepanel File Explorer
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function()
      require("nvim-tree").setup()
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle File Explorer" })
    end
  },

  -- Integrated Terminal
  { "akinsho/toggleterm.nvim", version = "*", config = function()
      require("toggleterm").setup({ open_mapping = [[<C-\>]], direction = "float" })
    end
  },

  -- UI & Quality of Life
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ 
        options = { theme = "tokyonight" },
        sections = {
          lualine_c = {
            { 'filename', path = 1 } -- Shows relative path instead of just filename
          }
        }
      })
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Fuzzy Finder (Telescope)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Telescope help tags" })
    end
  },

  -- Language Support (LSP & Autocomplete)
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
        lsp_zero.default_keymaps({buffer = bufnr})
      end)

      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "lua_ls", "pyright", "bashls", "html", "cssls", "ts_ls", "prismals", "marksman", "clangd" }, -- Auto-installs language servers
        handlers = { lsp_zero.default_setup },
      })

      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({select = true}), -- Enter to confirm autocomplete
          ['<C-Space>'] = cmp.mapping.complete(), -- Ctrl+Space to trigger autocomplete
        })
      })
    end
  },

  -- Formatters & Linters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier", "black", "isort", "clang-format", "shfmt", "stylua", -- formatters
          "flake8", "eslint_d", "shellcheck" -- linters
        },
      })
    end
  },
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
    end
  },
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
