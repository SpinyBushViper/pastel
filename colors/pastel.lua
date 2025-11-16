for k in pairs(package.loaded) do
  if k:match('.*pastel.*') then
    package.loaded[k] = nil
  end
end

require('pastel').setup()
require('pastel').colorscheme()
