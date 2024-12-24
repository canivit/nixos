{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pcmanfm
    file-roller
  ];

  services.gvfs = {
    enable = true;
    package = pkgs.gnome.gvfs;
  };

  services.udisks2.enable = true;
  services.devmon.enable = true;
}
