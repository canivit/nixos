# Module to override system config to use NetworkManager
{ lib, ... }:
{
  imports = [ ./default.nix ];
  config = {
    modules.networking.wireless.enable = lib.mkForce false;
    networking.networkmanager.enable = true;
    networking.networkmanager.wifi.powersave = false;
    boot.loader.grub.configurationName = "NixOS (NetworkManager)";
  };
}
