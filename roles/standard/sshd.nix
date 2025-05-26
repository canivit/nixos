{ ... }:
let
  keys = builtins.fetchurl {
    url = "https://github.com/canivit.keys";
    sha256 = "sha256:15rz539kc2p8w98kzkldj91r3xa0iqiy4gb4b8g6f1qy73svxy88";
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
