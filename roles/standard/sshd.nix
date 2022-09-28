{ ... }:
let
  keys = builtins.fetchurl {
    url = "https://github.com/canivit.keys";
    sha256 = "sha256:1bzw4633051yyhrpaqafqc28kmba06bkkg49mninc7sxiafgazm6";
  };
in
{
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    forwardX11 = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
  users.users.can.openssh.authorizedKeys.keyFiles = [ keys ];
}
