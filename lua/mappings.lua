require "nvchad.mappings"

-- add yours here

vim.opt.conceallevel = 1

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

require("aerial").setup {
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    map("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    map("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,
}
-- You probably also want to set a keymap to toggle aerial
map("n", "<leader>a", "<cmd>AerialToggle!<CR>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
