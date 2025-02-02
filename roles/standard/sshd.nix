{ ... }:
let
  keys = builtins.fetchurl {
    url = "https://github.com/canivit.keys";
    sha256 = "sha256:1z714kmva3szywjv9wkbshcs2d7b5msvgdymqg9gmgk66h9xjgmd";
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
