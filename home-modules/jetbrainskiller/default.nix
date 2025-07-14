{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.myModules.jetbrainskiller;
in
{
  # Useful when remote IDE hangs
  options.myModules.jetbrainskiller.enable = lib.mkEnableOption "script to forcefully shutdown jetbrains processes";
  config = lib.mkIf cfg.enable (
    let
      killjetbrains = pkgs.writeScriptBin "killjetbrains" ''
        #!${pkgs.bash}/bin/bash
        ${builtins.readFile ./killjetbrains.sh}
      '';
    in
    {
      home.packages = [ killjetbrains ];
    }
  );
}
