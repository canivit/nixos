{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      corefonts
      open-sans
      jetbrains-mono
      fira-code
      iosevka
      nerd-fonts.fira-code
      material-icons
      font-awesome
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Times New Roman" ];
        sansSerif = [ "Open Sans" ];
        monospace = [ "FiraCode Nerd Font Mono" ];
      };
    };
  };
}
