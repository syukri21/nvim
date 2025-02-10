require "nvchad.options"

-- add yours here!

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
--
-- Set tab size to 4 spaces
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4

o.expandtab = true

vim.cmd [[filetype plugin indent on]]

o.smartindent = true
