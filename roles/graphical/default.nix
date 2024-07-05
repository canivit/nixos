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

  guiFileManager.thunar.enable = true;
}
