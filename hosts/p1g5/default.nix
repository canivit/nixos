args@{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    (
      import ./autorandr.nix (
        args // { hidpi = true; }
      )
    )
    ./../../roles/standard
    (
      import ./../../roles/graphical (
        args // { hidpi = true; }
      )
    )
    ./../../roles/laptop
  ];

  networking.hostName = "p1g5";
  system.stateVersion = "22.11";
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
