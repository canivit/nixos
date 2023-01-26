{ vimPlugins, wrapLua, ... }:
{
  plugins = [ vimPlugins.telescope-nvim ];
  rc = wrapLua ./telescope.lua;
}
