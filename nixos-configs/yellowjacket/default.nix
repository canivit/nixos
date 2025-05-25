{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../roles/standard
  ];

  networking.hostName = "yellowjacket";
  system.stateVersion = "24.11";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
