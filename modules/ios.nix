{ lib, config, pkgs, ... }:
let cfg = config.ios; in {
  options = {
    ios.enable = lib.mkEnableOption "ios usb mount/tether";
  };

  config = lib.mkIf cfg.enable {
    services.usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };

    environment.systemPackages = with pkgs; [
      libimobiledevice
      ifuse
    ];
  };
}
