{ lib, ... }:
{
  imports = [
    ./thunar.nix
  ];
  options.modules.guiFileManager.cmd = lib.mkOption { type = lib.types.str; };
}
