local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "3rd/image.nvim",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = { "markdown" },
            highlight = { enable = true },
          })
        end,
      },
    },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          sizing_strategy = "auto",
          download_remote_images = true,
          clear_in_insert_mode = false,
        },
        neorg = {
          enabled = true,
          download_remote_images = true,
          clear_in_insert_mode = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      kitty_method = "normal",
      kitty_tmux_write_delay = 10,
    },
  },
})

vim.opt.number = true
vim.opt.conceallevel = 2
vim.opt.winbar = "image.nvim demo"
vim.opt.signcolumn = "yes:2"

local content = [[
# Hello World

![This is a remote image](https://gist.ro/s/remote.png)
]]

local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(buf, 0, -1, true, vim.split(content, "\n"))
vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
vim.api.nvim_set_current_buf(buf)
