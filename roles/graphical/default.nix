{ ... }:
{
  imports = [
    ./programs
    ./x
    ./virtualisation.nix
    ./fonts.nix
    ./gtk.nix
    ./sound.nix
    ./opengl.nix
  ];

  modules.guiFileManager.thunar.enable = true;
  modules.ios.enable = true;
  modules.browser = {
    brave = {
      enable = true;
      default = true;
    };

    chromium = {
      enable = true;
    };
  };
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
}
