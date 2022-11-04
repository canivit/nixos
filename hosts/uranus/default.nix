{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./../../roles/standard
    ./../../roles/graphical
    ./../../roles/laptop
  ];

  networking.hostName = "uranus";
}
