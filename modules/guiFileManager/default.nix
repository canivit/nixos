{ lib, ... }:
{
  imports = [
    ./thunar.nix
  ];
  options.guiFileManager.cmd = lib.mkOption { type = lib.types.str; };
}
