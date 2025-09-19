require("lazy").setup({
  {
    "AstroNvim/AstroNvim",
    version = "^5", 
    import = "astronvim.plugins",
    opts = {
      mapleader = " ",
      maplocalleader = ",",
      icons_enabled = true,
      pin_plugins = nil,
      update_notifications = true,
    },
  },
  {
    "Exafunction/windsurf.vim",
    event = "BufEnter",
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {"Rigellute/shades-of-purple.vim", priority = 1000},
  { import = "community" },
  { import = "plugins" },
}, {
  install = { colorscheme = { "astrotheme", "shades_of_purple" } },
  ui = { backdrop = 100 },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
})
