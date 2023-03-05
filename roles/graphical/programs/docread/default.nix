{ pkgs, ... }:
let
  docread = pkgs.writeScriptBin "docread" (builtins.readFile
    (pkgs.substituteAll {
      src = ./docread.sh;
      fd = "${pkgs.fd}/bin/fd";
      fzf = "${pkgs.fzf}/bin/fzf";
      zathura = "${pkgs.zathura}/bin/zathura";
    }));
in
{
  environment.systemPackages = [ docread ];
}
