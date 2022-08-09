{ ... }:
let
  keys = builtins.fetchurl {
    url = "https://github.com/canivit.keys";
    sha256 = "sha256:1w9prgjh5vfbg8dkzngwkn57gzba5sp2g8nsy2m45zqjmp937gw3";
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
