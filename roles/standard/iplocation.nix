{ pkgs, ... }:

let
  iplocation = pkgs.writeShellScriptBin "iplocation" ''
    ${pkgs.curl}/bin/curl -sSL http://ip-api.com/json/$1 | ${pkgs.jq}/bin/jq
  '';
in
{
  environment.systemPackages = with pkgs; [ iplocation ];
}
