{ pkgs, skindle }:
final: prev:
let
  inherit (prev) callPackage;
in
{
  inherit (pkgs);

  mine = {
    dotnet-sdk_5 = callPackage ./dotnet-sdk_5.nix { };
    rars = callPackage ./rars.nix { };
    skindle = skindle.defaultPackage.${pkgs.system};
  };
}
