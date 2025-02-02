{ vimPlugins, wrapLua, ... }:
{
  plugins = [ vimPlugins.gitsigns-nvim ];
  rc = wrapLua ./git.lua;
}
