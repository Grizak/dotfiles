-- Options are automatically loaded before lazy.nvim startup.
require("config.remote_clipboard").setup()

if vim.env.SSH_TTY then
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      ["+"] = osc52.paste("+"),
      ["*"] = osc52.paste("*"),
    },
  }
end

vim.opt.clipboard = "unnamedplus"

vim.opt.relativenumber = false
vim.g.autoformat = false
