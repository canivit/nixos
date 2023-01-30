{ pkgs, vimPlugins, wrapLua, ... }:
{
  plugins = [ vimPlugins.telescope-nvim ];
  packages = [ pkgs.ripgrep ];
  rc = wrapLua ./telescope.lua;
}
