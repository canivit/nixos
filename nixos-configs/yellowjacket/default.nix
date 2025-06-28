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
    jellyfin.enable = true;
  };

  networking.interfaces."enp3s0" = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "192.168.1.1";
        prefixLength = 24;
      }
    ];
  };

  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
