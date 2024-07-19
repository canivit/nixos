{ ... }:
let
  keys = builtins.fetchurl {
    url = "https://github.com/canivit.keys";
    sha256 = "sha256:0s5r3f6x7xigx2fq675jyj91vqjc2lis6jqamffrpsa1j5bfva2z";
  };
in
{
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  users.users.can.openssh.authorizedKeys.keyFiles = [ keys ];
}
