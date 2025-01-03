{ lib, ... }:
{
  imports = [
    ./brave.nix
    ./chromium.nix
    ./firefox.nix
  ];
  options.modules.browser.default = {
    cmd = lib.mkOption { type = lib.types.str; };
    desktop = lib.mkOption { type = lib.types.str; };
  };
}
