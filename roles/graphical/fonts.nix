{ pkgs, ... }:
{
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      corefonts
      open-sans
      jetbrains-mono
      fira-code
      iosevka
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
      material-icons
      font-awesome
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Times New Roman"];
        sansSerif = ["Open Sans"];
        monospace = ["FiraCode Nerd Font Mono"];
      };
    };
  };
}
