{ ... }:
let
  keys = builtins.fetchurl {
    url = "https://github.com/canivit.keys";
    sha256 = "sha256:0cy2jav8qk79816yms827xh3ryi01z92f50xihasdgii4j60jf8r";
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
