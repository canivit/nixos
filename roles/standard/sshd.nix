{ ... }:
let
  keys = builtins.fetchurl {
    url = "https://github.com/canivit.keys";
    sha256 = "sha256:12kmmhh8d71xdpn8x269c12vdzr3dfbi7bdqa9sgc5vn9x0q5ph7";
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
