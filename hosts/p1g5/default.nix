{ pkgs, ... }: {
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
  modules.hidpi.enable = true;
}
