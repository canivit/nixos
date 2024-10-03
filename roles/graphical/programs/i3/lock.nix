{ pkgs, config, ... }:
let
  bg = import ./../../background.nix { inherit pkgs; };
  wallpaper = if config.modules.hidpi.enable then bg.background_uhd else bg.background_fhd;
  locker = "${pkgs.multilockscreen}/bin/multilockscreen";

  updatelock = pkgs.writeShellScriptBin "updatelock" ''
    ${locker} -u ${wallpaper};
  '';
in
{
  home-manager.users.can = {
    home.packages = [ updatelock ];
    services.screen-locker = {
      enable = true;
      inactiveInterval = 30;
      lockCmd = "${locker} -l";
    };
  };
}
