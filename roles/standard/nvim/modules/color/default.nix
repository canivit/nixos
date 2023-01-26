{ vimPlugins, wrapLua, ... }:
{
  plugins = [ vimPlugins.onedark-nvim ];
  rc = wrapLua ./color.lua;
}
