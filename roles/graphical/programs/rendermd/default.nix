{ pkgs, ... }:
let
  rendermd = pkgs.writeScriptBin "rendermd" (builtins.readFile
    (pkgs.substituteAll {
      src = ./rendermd.sh;
      grip = "${pkgs.python39Packages.grip}/bin/grip";
    }));
in
{
  environment.systemPackages = [ rendermd ];
}
