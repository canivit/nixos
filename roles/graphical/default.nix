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
      brave = {
        enable = true;
        default = true;
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
