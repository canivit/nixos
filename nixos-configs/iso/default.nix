{ modulesPath, lib, pkgs, ... }:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-base.nix"
    ./autorandr.nix
    ./../../roles/standard
    ./../../roles/graphical
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.openssh.settings = {
    PasswordAuthentication = lib.mkForce true;
    PermitRootLogin = lib.mkForce "yes";
  };
  networking.wireless.enable = lib.mkForce false;
  users.extraUsers.root.initialPassword = "toor";
  modules.hidpi.enable = true;
}
