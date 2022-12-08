{ pkgs, ... }:
{
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };

  users.users.can.extraGroups = [ "wireshark" ];
}
