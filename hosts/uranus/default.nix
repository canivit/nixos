{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./../../roles/standard
    ./../../roles/graphical
    ./../../roles/laptop
    ./../../roles/nvidia
  ];

  networking.hostName = "uranus";
}
