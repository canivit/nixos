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
    pipewire.enable = true;
  };

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
}
