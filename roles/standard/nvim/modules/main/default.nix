{ pkgs, wrapLua, ... }:
{
  rc = wrapLua ./main.lua;
  packages = [ pkgs.xclip ];
}
