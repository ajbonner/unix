return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Theme
    vim.cmd[[colorscheme tokyonight-moon]]
    vim.opt.background = dark
  end,
  opts = {},
}
