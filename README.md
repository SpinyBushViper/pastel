# pastel.nvim

A warm, muted color theme for Neovim $\ge$ 0.9 based on bamboo.nvim. This theme features a carefully curated palette of soft, pastel colors designed for comfortable long coding sessions.

## Color Palette

The theme is built around these core colors:
- **Primary Background**: `#2f2e2d` - Deep warm gray
- **Secondary Background**: `#4a4845` - Medium warm gray  
- **Tertiary Background**: `#4d4d4d` - Neutral gray
- **Primary Text**: `#efefef` - Soft white
- **Accent**: `#e4c9af` - Warm cream

### Extended Palette
- **Blue tones**: `#7fa5bd`, `#a1bdce`, `#B3DEEF` - Soft blues for keywords and UI elements
- **Green tones**: `#8adbb4`, `#90a57d`, `#afbea2` - Muted greens for strings and success states
- **Warm tones**: `#d7af87`, `#e4c9af` - Creams and light browns for highlights
- **Purple tones**: `#c79ec4`, `#d7beda` - Soft purples for special elements
- **Red tones**: `#a36666`, `#d78787` - Muted reds for errors and warnings

## Features

- Warm, muted color palette designed to reduce eye strain
- Excellent contrast ratios for readability
- Consistent color usage across syntax elements
- _Many_ semantic highlighting tokens are handled and colored nicely
- Light and dark variants
  - Light mode only applies when `vim.o.background = 'light'`
- Multiple plugins are supported with hand-picked, proper colors
- Colors, highlights, and code style of the theme can be customized as you like
- Integration with other applications

### Dark Mode (`vulgaris` and `multiplex`)

The dark variants use the warm gray backgrounds with cream and soft blue accents. Perfect for low-light coding sessions.

### Light Mode (`light`)

The light variant inverts the palette, using cream backgrounds with dark gray text, maintaining the same warm, comfortable aesthetic.

<!-- End of previews. -->

> [!NOTE]
>
> The above screenshots utilize Tree-sitter parsers for `lua`, `luap`,
> `comment`, `markdown`, `markdown_inline`, `mermaid`, and `latex`.

The `lua` file screenshot also uses a custom query to highlight the `vim` global
as a builtin variable rather than a constant, changing it from pink to red. If
you want this behavior, add the following to a `queries/lua/highlights.scm` file
in your config directory (the `extends` comment is necessary):

```query
; extends
((identifier) @variable.builtin
  (#eq? @variable.builtin "vim")
  (#set! "priority" 128))
```

## Installation

Install via your favorite package manager:

```lua
-- Using lazy.nvim (local theme)
{
  dir = '/path/to/your/pastel/theme', -- Update this path
  name = 'pastel',
  lazy = false,
  priority = 1000,
  config = function()
    require('pastel').setup {
      -- optional configuration here
    }
    require('pastel').load()
  end,
},
```

> [!TIP]
>
> For best results, use (rounded) borders for float windows (or change their
> background to a slightly different color than the main editor background).

## Configuration

### Enable theme

```lua
-- Lua
require('pastel').load()
```

```vim
" Vim
colorscheme pastel
```

> Note: The theme uses the 'pastel' name and custom pastel color palette.

## Default Configuration

```lua
-- Lua
require('pastel').setup {
  -- Main options --
  -- NOTE: to use the light theme, set `vim.o.background = 'light'`
  style = 'vulgaris', -- Choose between 'vulgaris' (regular), 'multiplex' (same as vulgaris), and 'light'
  toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
  toggle_style_list = { 'vulgaris', 'multiplex', 'light' }, -- List of styles to toggle between
  transparent = false, -- Show/hide background
  dim_inactive = false, -- Dim inactive windows/buffers
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- Change code style ---
  -- Options are anything that can be passed to the `vim.api.nvim_set_hl` table
  -- You can also configure styles with a string, e.g. keywords = 'italic,bold'
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
    transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Config --
  diagnostics = {
    darker = false, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}
```

### Vimscript Configuration

Bamboo can be configured also with Vimscript, using the global dictionary
`g:bamboo_config`. **NOTE**: when setting boolean values use `v:true` and
`v:false` instead of 0 and 1.

Example:

```vim
let g:bamboo_config = {
  \ 'ending_tildes': v:true,
  \ 'diagnostics': {
    \ 'darker': v:true,
    \ 'background': v:false,
  \ },
\ }
colorscheme bamboo
```

## Customization

Example using custom colors and highlights:

```lua
require('bamboo').setup {
  colors = {
    bright_orange = '#ff8800', -- define a new color
    green = '#00ffaa', -- redefine an existing color
  },
  highlights = {
    -- make comments blend nicely with background, similar to other color schemes
    ['@comment'] = { fg = '$grey' },

    ['@keyword'] = { fg = '$green' },
    ['@string'] = { fg = '$bright_orange', bg = '#00ff00', fmt = 'bold' },
    ['@function'] = { fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic' },
    ['@function.builtin'] = { fg = '#0059ff' },
  },
}
```

Note that Tree-sitter keywords have been changed after Neovim version 0.8 and
onwards. TS prefix is trimmed and lowercase words are separated with `.`.

The old way before neovim 0.8 looks like this. All highlights used in this
colorscheme can be found in
[this file](https://github.com/ribru17/bamboo.nvim/blob/master/lua/bamboo/highlights.lua).

```lua
require('bamboo').setup {
  colors = {
    bright_orange = '#ff8800', -- define a new color
    green = '#00ffaa', -- redefine an existing color
  },
  highlights = {
    TSKeyword = { fg = '$green' },
    TSString = { fg = '$bright_orange', bg = '#00ff00', fmt = 'bold' },
    TSFunction = { fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic' },
    TSFuncBuiltin = { fg = '#0059ff' },
  },
}
```

## Plugins Supported

- [Tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [LSPDiagnostics](https://neovim.io/doc/user/lsp.html)
- [NvimTree](https://github.com/kyazdani42/nvim-tree.lua)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [WhichKey](https://github.com/folke/which-key.nvim)
- [Dashboard](https://github.com/glepnir/dashboard-nvim)
- [Lualine](https://github.com/hoob3rt/lualine.nvim)
- [GitGutter](https://github.com/airblade/vim-gitgutter)
- [GitSigns](https://github.com/lewis6991/gitsigns.nvim)
- [VimFugitive](https://github.com/tpope/vim-fugitive)
- [DiffView](https://github.com/sindrets/diffview.nvim)
- [Hop](https://github.com/phaazon/hop.nvim)
- [Mini](https://github.com/echasnovski/mini.nvim)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [Neotest](https://github.com/nvim-neotest/neotest)
- [Barbecue](https://github.com/utilyre/barbecue.nvim)
- [ALE](https://github.com/dense-analysis/ale)
- [barbar.nvim](https://github.com/romgrk/barbar.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [coc.nvim](https://github.com/neoclide/coc.nvim)
- [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- [aerial.nvim](https://github.com/stevearc/aerial.nvim)
- [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
- Every major rainbow bracket plugin
- Much more!

## Reference

- [onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [Catppuccin for Neovim](https://github.com/catppuccin/nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim)

## License

[MIT](https://choosealicense.com/licenses/mit/)
# Pastel-Nvim
