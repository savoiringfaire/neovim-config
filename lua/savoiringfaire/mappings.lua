vim.g.mapleader = " "
vim.keymap.set("n", "-", vim.cmd.Ex)

vim.api.nvim_set_keymap("n", "<leader><Tab>", '<C-^>', {noremap = true})
