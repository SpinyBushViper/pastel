for k in pairs(package.loaded) do
  if k:match('.*pastel.*') then
    package.loaded[k] = nil
  end
end

require('pastel').set_options('style', 'light')
vim.o.background = 'light'
require('pastel').colorscheme()
