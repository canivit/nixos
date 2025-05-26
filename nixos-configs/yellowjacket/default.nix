{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../roles/standard
  ];

  networking.hostName = "yellowjacket";
  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
