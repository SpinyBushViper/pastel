local M = {}

M.styles_list = { 'vulgaris', 'multiplex', 'light' }

---Change pastel option (vim.g.pastel_config.option)
---It can't be changed directly by modifying that field due to a Neovim lua bug with global variables (pastel_config is a global variable)
---@param opt string: option name
---@param value any: new value
function M.set_options(opt, value)
  local cfg = vim.g.pastel_config
  cfg[opt] = value
  vim.g.pastel_config = cfg
end

---Apply the colorscheme (same as ':colorscheme pastel')
function M.colorscheme()
  vim.cmd.hi('clear')
  if vim.fn.exists('syntax_on') then
    vim.cmd.syntax('reset')
  end
  vim.o.termguicolors = true
  vim.g.colors_name = 'pastel'
  if vim.o.background == 'light' then
    M.set_options('style', 'light')
  elseif vim.g.pastel_config.style == 'light' then
    M.set_options('style', 'vulgaris')
  end
  require('pastel.highlights').setup()
  require('pastel.terminal').setup()
end

---Toggle between pastel styles
function M.toggle()
  local index = vim.g.pastel_config.toggle_style_index + 1
  if index > #vim.g.pastel_config.toggle_style_list then
    index = 1
  end
  M.set_options('style', vim.g.pastel_config.toggle_style_list[index])
  M.set_options('toggle_style_index', index)
  vim.cmd.colorscheme('pastel-' .. vim.g.pastel_config.style)
end

local default_config = {
  -- Main options --
  style = 'vulgaris', -- choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
  toggle_style_key = nil,
  toggle_style_list = M.styles_list,
  transparent = false, -- don't set background
  dim_inactive = false, -- don't dim inactive windows
  term_colors = true, -- if true enable the terminal
  ending_tildes = false, -- show the end-of-buffer tildes
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- Changing Formats --
  code_style = {
    comments = { italic = true },
    conditionals = { italic = true },
    keywords = {},
    functions = {},
    namespaces = { italic = true },
    parameters = { italic = true },
    strings = {},
    variables = {},
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- center bar (c) transparency
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Related --
  diagnostics = {
    darker = false, -- darker colors for diagnostic
    undercurl = true, -- use undercurl for diagnostics
    background = true, -- use background color for virtual text
  },
}

---Setup pastel.nvim options, without applying colorscheme
---@param opts table?: a table containing options
function M.setup(opts)
  if not vim.g.pastel_config or not vim.g.pastel_config.loaded then -- if it's the first time setup() is called
    vim.g.pastel_config =
      vim.tbl_deep_extend('keep', vim.g.pastel_config or {}, default_config)
    M.set_options('loaded', true)
    M.set_options('toggle_style_index', 1)
  end
  if opts then
    vim.g.pastel_config =
      vim.tbl_deep_extend('force', vim.g.pastel_config, opts)
    -- these tables cannot be extended, they have to be replaced
    if opts.toggle_style_list then
      M.set_options('toggle_style_list', opts.toggle_style_list)
    end
    if opts.code_style then
      local cfg = vim.g.pastel_config
      cfg.code_style = vim.tbl_extend('force', cfg.code_style, opts.code_style)
      vim.g.pastel_config = cfg
    end
  end
  if vim.g.pastel_config.toggle_style_key then
    vim.api.nvim_set_keymap(
      'n',
      vim.g.pastel_config.toggle_style_key,
      '<cmd>lua require("pastel").toggle()<cr>',
      { noremap = true, silent = true }
    )
  end
end

function M.load()
  vim.cmd.colorscheme('pastel')
end

return M
