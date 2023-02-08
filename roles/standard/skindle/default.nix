{ pkgs, ... }:
let
  skin = pkgs.writeScriptBin "skin" (builtins.readFile
    (pkgs.substituteAll {
      src = ./skin.sh;
      fd = "${pkgs.fd}/bin/fd";
      fzf = "${pkgs.fzf}/bin/fzf";
      skindle = "${pkgs.mine.skindle}/bin/skindle";
    }));
in
{
  environment.systemPackages = [ skin ];
}
