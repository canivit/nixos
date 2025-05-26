{ pkgs, ... }:
{
  services.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  users.users.can.extraGroups = [ "audio" ];
}
