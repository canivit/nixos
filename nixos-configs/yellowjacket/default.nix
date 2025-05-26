{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../roles/standard
  ];

  networking.hostName = "yellowjacket";
  modules = {
    networking.wireless = {
      enable = true;
      interface = "wlo1";
    };
    auto-upgrade.enable = true;
  };

  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
