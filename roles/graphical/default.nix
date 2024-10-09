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
  modules.browser.brave = {
    enable = true;
    default = true;
  };

  modules.browser.chromium.enable = true;
}
