{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pcmanfm
    gnome.file-roller
  ];

  services.gvfs = {
    enable = true;
    package = pkgs.gnome3.gvfs;
  };

  services.udisks2.enable = true;
  services.devmon.enable = true;
}