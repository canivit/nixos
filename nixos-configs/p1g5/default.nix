{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./autorandr.nix
    ./../../roles/standard
    ./../../roles/graphical
    ./../../roles/laptop
  ];

  networking.hostName = "p1g5";
  system.stateVersion = "22.11";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  modules = {
    hidpi.enable = true;
    networking = {
      wireless = {
        enable = true;
        interface = "wlp0s20f3";
      };
    };
  };

  networking.interfaces."enp0s13f0u1u1u2" = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "192.168.1.2";
        prefixLength = 24;
      }
    ];
  };

  boot.loader.grub.configurationName = "NixOS (Default)";
}
