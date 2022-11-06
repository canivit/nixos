{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./../../roles/standard
    ./../../roles/graphical
    ./../../roles/laptop
  ];

  networking.hostName = "darterpro";
  system.stateVersion = "22.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
