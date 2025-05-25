{ ... }:
{
  imports = [
    ./programs
    ./x
    ./virtualisation.nix
    ./fonts.nix
    ./gtk.nix
    ./hardware-acceleration.nix
  ];

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  modules = {
    guiFileManager.thunar.enable = true;
    ios.enable = true;
    browser = {
      firefox = {
        enable = true;
        default = true;
      };
      brave = {
        enable = true;
      };
      chromium = {
        enable = true;
      };
    };
    sound.pipewire.enable = true;
  };

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
}
