-- Vim Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.updatetime = 200
vim.opt.timeoutlen = 500
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.mouse = "a"
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- vim.pack
vim.pack.add({
  "https://github.com/rose-pine/neovim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/neovim/nvim-lspconfig",
})

require("nvim-treesitter").install({ "bash", "lua", "markdown", "markdown_inline", "zsh" })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "lua", "markdown", "zsh" },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- LSPs
vim.lsp.enable({ "lua_ls" })

-- Theme
vim.cmd.colorscheme("rose-pine-moon")

-- Keymaps
-- global
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr><Esc>", { desc = "Clear Search Highlight" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- telescope specific
vim.keymap.set("n", "<leader> ", "<cmd>Telescope find_files hidden=true<CR>", { desc = "Find Files" })
vim.keymap.set("n", "<leader>.", "<cmd>Telescope buffers<CR>", { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<CR>", { desc = "Live Grep" })
-- netrw specific
vim.keymap.set("n", "<leader>e", "<cmd>Ex<CR>", { desc = "Explorer" })
vim.keymap.set("n", "<leader>r", "<cmd>Rex<CR>", { desc = "Return from Explorer" })
