{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.cache;
in
{
  options.modules.cache = {
    enable = lib.mkEnableOption "enable cache";
    server.enable = lib.mkEnableOption "enable cache server";
  };

  config = {
    nix.settings = lib.mkIf cfg.enable {
      substituters = [
        "https://canivit.cachix.org"
      ] ++ lib.optional (!cfg.server.enable) "http://10.0.0.10:5000";

      trusted-public-keys = [
        "canivit.cachix.org-1:oqZfaVHqqURB1CjMm5ZFUt/oYI1LvIpFp1VSG1U9tG0="
      ] ++ lib.optional (!cfg.server.enable) "yellowjacket:klK6k/HcdDvqi3zZfFOqB7G67EBWI75B7JwhgxmVtj8=";
    };

    environment.systemPackages = lib.mkIf cfg.enable (
      with pkgs;
      [
        cachix
      ]
    );

    services.nix-serve = lib.mkIf cfg.server.enable {
      enable = true;
      package = pkgs.nix-serve-ng;
      bindAddress = "10.0.0.10";
      port = 5000;
      openFirewall = true;
      secretKeyFile = "/run/secrets/nix_cache_server_private_key";
    };
  };
}
