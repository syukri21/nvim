require "nvchad.mappings"

-- remove default <leader>h mapping for open new terminal
vim.api.nvim_set_keymap("n", "<leader>h", "<Nop>", { noremap = true, silent = true })

vim.opt.conceallevel = 1

local map = vim.keymap.set

map("n", "<leader>hp", "<cmd>lua require('harpoon.mark').add_file()<CR>", { desc = "Add file to harpoon" })
map("n", "<leader>ho", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Toggle harpoon quick menu" })
for i, key in ipairs { "h", "j", "k", "l", "n", "m", ";", "'", ",", "." } do
  map(
    "n",
    "<leader>h" .. key,
    string.format("<cmd>lua require('harpoon.ui').nav_file(%d)<CR>", i),
    { desc = "Navigate to harpoon file " .. i }
  )
end

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
map("n", "<leader>o", "<cmd>AerialToggle!<CR>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--

-- Rust-specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()

    -- Code action keymap
    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, { silent = true, buffer = bufnr })

    -- Enhanced hover keymap
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, { silent = true, buffer = bufnr })

    -- require("nvim-tree.api").tree.resize(150)
  end,
})

vim.keymap.set("n", "<leader>co", function()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= current_buf then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { desc = "Close all buffers except this one" })

-- place this in one of your configuration file(s)
local hop = require "hop"
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
  hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
end, { remap = true })
vim.keymap.set("", "F", function()
  hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
end, { remap = true })
vim.keymap.set("", "t", function()
  hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
end, { remap = true })
vim.keymap.set("", "T", function()
  hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
end, { remap = true })

vim.keymap.set("n", "F", "<cmd>HopPattern<CR>", { desc = "Hop to word" })

vim.keymap.set("n", "<leader>lf", function()
  vim.cmd "!leptosfmt %"
end, { desc = "Format Rust code with leptosfmt" })

-- create a keymap to copy relative file path to clipboardo
vim.keymap.set("n", "<leader>cp", function()
  local filepath = vim.fn.expand "%:."
  vim.fn.setreg("+", filepath)
  print("Copied relative file path to clipboard: " .. filepath)
end, { desc = "Copy relative file path to clipboard" })
