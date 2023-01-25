{ ... }:
let
  keys = builtins.fetchurl {
    url = "https://github.com/canivit.keys";
    sha256 = "sha256:025mp8c0c7aqy00wcmf68azickhqriq7gj1vypj252yhvrima87r";
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
