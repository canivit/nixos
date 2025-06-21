{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.sops;
in
{
  options.modules.sops.enable = lib.mkEnableOption "sops secret management";

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = ./../secrets.yaml;
      age = {
        keyFile = "/var/lib/sops/age/keys.txt";
      };
      secrets =
        let
          permissions = {
            mode = "440";
            owner = config.users.users.can.name;
            group = config.users.users.can.group;
          };
        in
        {
          wifi_passwords = permissions;
        };
    };
  };
}
