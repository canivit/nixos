{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.networking;
in
{

  options.modules.networking.wireless = {
    enable = lib.mkEnableOption "enable wpa_supplicant";
    interface = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.wireless.enable {
    networking.wireless = {
      enable = true;
      interfaces = [ cfg.wireless.interface ];
      secretsFile = "${config.users.users.can.home}/secrets/wireless.conf";
      networks = {
        ivit = {
          # read PSK from the variable psk_ivit, defined in secretsFile
          # this won't leak into /nix/store
          pskRaw = "ext:psk_ivit";
        };
      };
    };
  };
}
