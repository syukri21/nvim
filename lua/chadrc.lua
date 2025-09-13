-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "tundra",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }

M.plugins = {
  override = {
    ["ibhagwan/fzf-lua"] = {
      opts = {
        winopts = {
          height = 1.85, -- window height
          width = 0.80,  -- window width
          preview = {
            layout = "vertical", -- preview layout
            vertical = "up:45%", -- preview size
          },
        },
      },
    },
  },
}

-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
--}

return M
