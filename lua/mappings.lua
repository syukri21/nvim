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
map("n", "<leader>a", "<cmd>AerialToggle!<CR>")
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

