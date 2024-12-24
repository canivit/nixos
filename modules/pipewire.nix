{ lib, config, ... }:
let cfg = config.modules.pipewire; in {
  options.modules.pipewire.enable = lib.mkEnableOption "pipewire";

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    hardware.pulseaudio.enable = false;
  };
}
