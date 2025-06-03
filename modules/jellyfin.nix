{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.jellyfin;
  home = config.users.users.can.home;
  jellyfinDir = "${home}/jellyfin";
  transmissionDir = "${home}/transmission";
  sonarrDir = "${home}/sonarr";
  jackettDir = "${home}/jackett";
in
{

  options.modules.jellyfin = {
    enable = lib.mkEnableOption "enable ";
  };

  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      user = "can";
      group = "users";
      openFirewall = true;
      logDir = "${jellyfinDir}/log";
      cacheDir = "${jellyfinDir}/cache";
      dataDir = "${jellyfinDir}/data";
      configDir = "${jellyfinDir}/config";
    };

    services.transmission = {
      enable = true;
      user = "can";
      group = "users";
      openRPCPort = true;
      home = transmissionDir;
      settings = {
        watch-dir = "${transmissionDir}/watch";
        download-dir = "${transmissionDir}/downloads";
        incomplete-dir = "${transmissionDir}/incomplete";
        rpc-bind-address = "0.0.0.0";
        rpc-whitelist = "*";
      };
    };

    services.sonarr = {
      enable = true;
      user = "can";
      group = "users";
      openFirewall = true;
      dataDir = sonarrDir;
    };

    services.jackett = {
      enable = true;
      user = "can";
      group = "users";
      openFirewall = true;
      dataDir = jackettDir;
    };

    systemd.tmpfiles.rules = [
      "d ${jellyfinDir} 0755 can users -"
      "d ${jellyfinDir}/log 0755 can users -"
      "d ${jellyfinDir}/cache 0755 can users -"
      "d ${jellyfinDir}/data 0755 can users -"
      "d ${jellyfinDir}/config 0755 can users -"
      "d ${jellyfinDir}/media 0755 can users -"

      "d ${transmissionDir} 0755 can users -"
      "d ${transmissionDir}/watch 0755 can users -"
      "d ${transmissionDir}/downloads 0755 can users -"
      "d ${transmissionDir}/downloads/tv-sonarr 0755 can users -"
      "d ${transmissionDir}/incomplete 0755 can users -"

      "d ${sonarrDir} 0755 can users -"
      "d ${jackettDir} 0755 can users -"
    ];
  };
}
