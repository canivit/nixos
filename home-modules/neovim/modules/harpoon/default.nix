{ vimPlugins, wrapLua, ... }:
{
  plugins = [ vimPlugins.harpoon ];
  rc = wrapLua ./harpoon.lua;
}
