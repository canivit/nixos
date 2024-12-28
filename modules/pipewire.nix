{ lib, config, pkgs, ... }:
let cfg = config.modules.sound.pipewire; in {
  options.modules.sound = {
    pipewire.enable = lib.mkEnableOption "pipewire";
    volumeUpCmd = lib.mkOption { type = lib.types.str; };
    volumeDownCmd = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    hardware.pulseaudio.enable = false;
    environment.systemPackages = with pkgs; [ pamixer pamix ];
    modules.sound.volumeUpCmd = "pamixer -i 1";
    modules.sound.volumeDownCmd = "pamixer -d 1";
  };
}
