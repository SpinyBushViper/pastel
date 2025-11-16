for k in pairs(package.loaded) do
  if k:match('.*pastel.*') then
    package.loaded[k] = nil
  end
end

require('pastel').set_options('style', 'multiplex')
vim.o.background = 'dark'
require('pastel').colorscheme()
