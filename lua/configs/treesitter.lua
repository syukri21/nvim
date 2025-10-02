local ts = require "nvim-treesitter.configs"

-- Register rstml parser if not already provided by the plugin
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
if not parser_config.rstml then
  parser_config.rstml = {
    install_info = {
      url = "https://github.com/rayliwell/tree-sitter-rstml",
      files = { "src/parser.c", "src/scanner.c" },
      branch = "main",
    },
    filetype = "rstml",
  }
end

ts.setup {
  ensure_installed = {
    "jinja",
    "javascript",
    "vim",
    "lua",
    "vimdoc",
    "html",
    "css",
    "rust",
    "php",
    "rstml",
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
