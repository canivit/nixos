{ pkgs, ...}:
let
  bg = import ./../../background.nix { inherit pkgs; };
  background = bg.background;

  locker = "${pkgs.multilockscreen}/bin/multilockscreen"; 

  updatelock = pkgs.writeShellScriptBin "updatelock" ''
    ${locker} -u ${background};
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
