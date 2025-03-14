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
          vim.opt_local.relativenumber = false
          vim.opt_local.number = false
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
    lazy = false,
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
}
