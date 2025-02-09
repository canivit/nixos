{ ... }:
{
  imports = [
    ./base-home.nix
  ];

  config = {
    home.username = "rcanivit";
    home.homeDirectory = "/local/home/rcanivit";
  };
}
