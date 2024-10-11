{ lib, config, ... }:
let cfg = config.modules.ios; in {
  options.modules.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    home-manager.users.can.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
