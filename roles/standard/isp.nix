{ pkgs, ... }:

let
  isp = pkgs.writeShellScriptBin "isp" ''
    ${pkgs.curl}/bin/curl -sSL ipinfo.io
  '';
in
{
  environment.systemPackages = with pkgs; [ isp ];
}
