{ makeNixosConfig, ... }:
{
  p1g5 = makeNixosConfig ./p1g5 "x86_64-linux";
  p1g5NetworkManager = makeNixosConfig ./p1g5/network-manager.nix "x86_64-linux";
  iso = makeNixosConfig ./iso "x86_64-linux";
  yellowjacket = makeNixosConfig ./yellowjacket "x86_64-linux";
}
