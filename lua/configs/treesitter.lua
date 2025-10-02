local ts = require "nvim-treesitter.configs"

-- Override default rust parser with combined rust_with_rstml grammar
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.rust_with_rstml = {
  install_info = {
    url = "https://github.com/rayliwell/tree-sitter-rstml",
    files = { "rust_with_rstml/src/parser.c", "rust_with_rstml/src/scanner.c" },
    branch = "main",
  },
  used_by = { "rust" },
}

-- Explicitly register the combined grammar for rust (older Neovim compatibility)
if vim.treesitter and vim.treesitter.language and vim.treesitter.language.register then
  pcall(vim.treesitter.language.register, "rust_with_rstml", "rust")
end

-- Ensure parser install dir is on runtimepath so queries load
local site = vim.fn.stdpath('data') .. '/site'
if not string.find(vim.o.runtimepath, site, 1, true) then
  vim.opt.rtp:append(site)
end

ts.setup {
  install_dir = vim.fn.stdpath('data') .. '/site',
  ensure_installed = {
    "jinja",
    "javascript",
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "php",
    "rust_with_rstml",
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gs",
      node_incremental = "n",
      scope_incremental = "N",
      node_decremental = "m",
    },
  },
}
