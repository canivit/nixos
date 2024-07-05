{ pkgs, ... }: {
  imports = [
    ./../../roles/standard
    ./../../roles/graphical
  ];

  networking.hostName = "kvm";
  system.stateVersion = "24.05";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
