{ flakes }:
final: prev:
let
  inherit (prev) callPackage;
  inherit (prev.lib) mapAttrs;
  inherit (prev) system;
  flakePkgs = mapAttrs (name: value: value.defaultPackage.${system}) flakes;
in
{
  mine = {
    dotnet-sdk_5 = callPackage ./dotnet-sdk_5.nix { };
    rars = callPackage ./rars.nix { };
  } // flakePkgs;
}
