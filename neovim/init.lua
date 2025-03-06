require("config.lazy")          -- Leader mappings are set up in here
require("lualine").setup()

vim.opt.termguicolors = true
require("bufferline").setup()

-- Basic vim setup defaults
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.wrapscan = true
vim.opt.incsearch = true        -- incremental search (search as you type)
vim.opt.number = true           -- line numbering
vim.opt.ruler = true            -- setup and show ruler
vim.opt.textwidth = 78
vim.opt.colorcolumn = "100"
vim.opt.formatoptions = qrn1
vim.opt.cursorline = true       -- highlight cursorline
vim.opt.showmode = true         -- show mode in status bar
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.cmdheight = 2
vim.opt.ignorecase = smartcase
vim.opt.showtabline = 2
vim.opt.numberwidth = 5
vim.opt.winwidth = 79
vim.opt.switchbuf = useopen
vim.opt.list = true

-- Time to wait after ESC or leader immediate mode command
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 150

-- Enable syntax autocompletion
vim.opt.omnifunc = 'syntaxcomplete#Complete'
vim.opt.completeopt = 'menu,preview'

-- Tree sitter folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#fold_expr()'

-- Custom keymappings
vim.keymap.set({'n', 'o'}, '<leader>sw', ':SudaWrite<CR>', {remap=true})

-- Line numbering toggle
vim.keymap.set('n', '<leader>gn', ':set invnu<CR>')

-- Edit nvim init.lua
vim.keymap.set('n', '<leader>rc', ':e $HOME/.config/nvim/init.lua<CR>')

-- Buffer navigation
vim.keymap.set('n', '<leader>bp', 'BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>bn', 'BufferLineCycleNext<CR>')

-- Use ctrl-motion to switch between windows
vim.keymap.set({'n', 'o'}, '<C-h>', '<C-w>h', {remap=true})
vim.keymap.set({'n', 'o'}, '<C-j>', '<C-w>j', {remap=true})
vim.keymap.set({'n', 'o'}, '<C-k>', '<C-w>k', {remap=true})
vim.keymap.set({'n', 'o'}, '<C-l>', '<C-w>l', {remap=true})
