{ ... }:
{
  imports = [
    ./base-home.nix
  ];

  config = {
    home.stateVersion = "24.05";
    home.username = "rcanivit";
    home.homeDirectory = "/local/home/rcanivit";
  };
}
