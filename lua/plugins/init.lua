return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- harpoon
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup {}
    end,
  },

  {

    "williamboman/nvim-lsp-installer",
    opts = {
      ensure_installed = { "lua_ls" },
    },
    config = function()
      require("nvim-lsp-installer").setup {}
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jinja_lsp = {
          filetypes = { "jinja", "html" },
        },
      },
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "configs.treesitter"
    end,
  },

  {

    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "marksman",
        "server",
      },
    },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },

      -- see below for full list of options 👇
    },
    config = function()
      require "configs.obsidian"
    end,
  },
  {
    "stevearc/aerial.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "github/copilot.vim",
    event = "BufEnter",
    config = function()
      vim.keymap.set("i", "<C-g>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    branch = "main",
    build = "make tiktoken",
    cmd = "CopilotChat",
    opts = function()
      return require "configs.copilot_chat"
    end,
    keys = {
      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>aq",
        function()
          vim.ui.input({
            prompt = "Quick Chat: ",
          }, function(input)
            if input ~= "" then
              require("CopilotChat").ask(input)
            end
          end)
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>ap",
        function()
          require("CopilotChat").select_prompt()
        end,
        desc = "Prompt Actions (CopilotChat)",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local chat = require "CopilotChat"

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = false
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.opt_local.breakindent = true
        end,
      })

      chat.setup(opts)
    end,
  },

  {
    "nvim-java/nvim-java",
    config = function()
      require("java").setup {
        {
          --  list of file that exists in root of the project
          root_markers = {
            "settings.gradle",
            "settings.gradle.kts",
            "pom.xml",
            "build.gradle",
            "mvnw",
            "gradlew",
            "build.gradle",
            "build.gradle.kts",
            ".git",
          },

          jdtls = {
            version = "v1.43.0",
          },

          lombok = {
            version = "nightly",
          },

          -- load java test plugins
          java_test = {
            enable = true,
            version = "0.43.0",
          },

          -- load java debugger plugins
          java_debug_adapter = {
            enable = true,
            version = "0.58.1",
          },

          spring_boot_tools = {
            enable = true,
            version = "1.59.0",
          },

          jdk = {
            -- install jdk using mason.nvim
            auto_install = true,
            version = "17.0.2",
          },

          notifications = {
            -- enable 'Configuring DAP' & 'DAP configured' messages on start up
            dap = true,
          },

          -- We do multiple verifications to make sure things are in place to run this
          -- plugin
          verification = {
            -- nvim-java checks for the order of execution of following
            -- * require('java').setup()
            -- * require('lspconfig').jdtls.setup()
            -- IF they are not executed in the correct order, you will see a error
            -- notification.
            -- Set following to false to disable the notification if you know what you
            -- are doing
            invalid_order = true,

            -- nvim-java checks if the require('java').setup() is called multiple
            -- times.
            -- IF there are multiple setup calls are executed, an error will be shown
            -- Set following property value to false to disable the notification if
            -- you know what you are doing
            duplicate_setup_calls = true,

            -- nvim-java checks if nvim-java/mason-registry is added correctly to
            -- mason.nvim plugin.
            -- IF it's not registered correctly, an error will be thrown and nvim-java
            -- will stop setup
            invalid_mason_registry = false,
          },
        },
      }
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      require("telescope").setup {
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          layout_config = {
            horizontal = {
              preview_width = 0.3,
            },
            vertical = {
              mirror = false,
            },
            width = 0.9,
            height = 0.8,
          },
          sorting_strategy = "ascending",
          winblend = 10,
        },
        config = {
          fzf = {
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      }
    end,
  },
  {
    "StanAngeloff/php.vim",
    ft = "php",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    cmd = { "RenderMarkdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      require("obsidian").get_client().opts.ui.enable = false
      -- vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()["ObsidianUI"], 0, -1)

      require("render-markdown").setup {
        heading = {
          -- Useful context to have when evaluating values.
          -- | level    | the number of '#' in the heading marker         |
          -- | sections | for each level how deeply nested the heading is |

          -- Turn on / off heading icon & background rendering.
          enabled = true,
          -- Additional modes to render headings.
          render_modes = false,
          -- Turn on / off atx heading rendering.
          atx = true,
          -- Turn on / off setext heading rendering.
          setext = true,
          -- Turn on / off sign column related rendering.
          sign = true,
          -- Replaces '#+' of 'atx_h._marker'.
          -- Output is evaluated depending on the type.
          -- | function | value(context)              |
          -- | string[] | cycle(value, context.level) |
          icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
          -- Determines how icons fill the available space.
          -- | right   | '#'s are concealed and icon is appended to right side                      |
          -- | inline  | '#'s are concealed and icon is inlined on left side                        |
          -- | overlay | icon is left padded with spaces and inserted on left hiding additional '#' |
          position = "overlay",
          -- Added to the sign column if enabled.
          -- Output is evaluated by cycle(value, context.level).
          signs = { "󰫎 " },
          -- Width of the heading background.
          -- | block | width of the heading text |
          -- | full  | full width of the window  |
          -- Can also be a list of the above values evaluated by clamp(value, context.level).
          width = "full",
          -- Amount of margin to add to the left of headings.
          -- Margin available space is computed after accounting for padding.
          -- If a float < 1 is provided it is treated as a percentage of available window space.
          -- Can also be a list of numbers evaluated by clamp(value, context.level).
          left_margin = 0,
          -- Amount of padding to add to the left of headings.
          -- Output is evaluated using the same logic as 'left_margin'.
          left_pad = 0,
          -- Amount of padding to add to the right of headings when width is 'block'.
          -- Output is evaluated using the same logic as 'left_margin'.
          right_pad = 0,
          -- Minimum width to use for headings when width is 'block'.
          -- Can also be a list of integers evaluated by clamp(value, context.level).
          min_width = 0,
          -- Determines if a border is added above and below headings.
          -- Can also be a list of booleans evaluated by clamp(value, context.level).
          border = false,
          -- Always use virtual lines for heading borders instead of attempting to use empty lines.
          border_virtual = false,
          -- Highlight the start of the border using the foreground highlight.
          border_prefix = false,
          -- Used above heading for border.
          above = "▄",
          -- Used below heading for border.
          below = "▀",
          -- Highlight for the heading icon and extends through the entire line.
          -- Output is evaluated by clamp(value, context.level).
          backgrounds = {
            "RenderMarkdownH1Bg",
            "RenderMarkdownH2Bg",
            "RenderMarkdownH3Bg",
            "RenderMarkdownH4Bg",
            "RenderMarkdownH5Bg",
            "RenderMarkdownH6Bg",
          },
          -- Highlight for the heading and sign icons.
          -- Output is evaluated using the same logic as 'backgrounds'.
          foregrounds = {
            "RenderMarkdownH1",
            "RenderMarkdownH2",
            "RenderMarkdownH3",
            "RenderMarkdownH4",
            "RenderMarkdownH5",
            "RenderMarkdownH6",
          },
          -- Define custom heading patterns which allow you to override various properties based on
          -- the contents of a heading.
          -- The key is for healthcheck and to allow users to change its values, value type below.
          -- | pattern    | matched against the heading text @see :h lua-patterns |
          -- | icon       | optional override for the icon                        |
          -- | background | optional override for the background                  |
          -- | foreground | optional override for the foreground                  |
          custom = {},
        },
      }
    end,
  },
  {
    "willothy/leptos.nvim",
    event = "VeryLazy",
  },
  {
    "rayliwell/tree-sitter-rstml",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    build = ":TSUpdate rstml",
    config = function()
      require("tree-sitter-rstml").setup()
    end,
  },
  -- Automatic tag closing and renaming (optional but highly recommended)
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- tailwind-tools.lua
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
      "neovim/nvim-lspconfig", -- optional
    },
    opts = {}, -- your configuration
    config = function(_, opts)
      require("tailwind-tools").setup(opts)
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = { "fugitive" },
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      -- options
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    "rayliwell/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
}
