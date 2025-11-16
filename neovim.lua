return {
  dir = vim.fn.expand("/home/user/.config/omarchy/themes/pastel/nvim-pastel"),
  name = "pastel",
  lazy = false,
  priority = 1000,
  config = function()
    require("pastel").setup({
      style = "vulgaris", -- Use your custom pastel colors
    })
    require("pastel").load()
  end,
}
