{ pkgs, ... }:
let
  rendermd = pkgs.writeScriptBin "rendermd" (builtins.readFile
    (pkgs.substituteAll {
      src = ./rendermd.sh;
      grip = "${pkgs.python312Packages.grip}/bin/grip";
    }));
in
{
  environment.systemPackages = [ rendermd ];
}
