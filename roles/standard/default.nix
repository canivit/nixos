{ ... }:
{
  imports = [
    ./nvim.nix
    ./shells.nix
    ./starship.nix
    ./direnv.nix
    ./git.nix
    ./ssh.nix
    ./sshd.nix
    ./isp.nix
    ./iplocation.nix
    ./nix.nix
    ./bat.nix
    ./pkgs.nix
  ];

  home-manager.users.can.home.stateVersion = "22.11";

  users.users.can = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "can";
  };

  home-manager.users.can.xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  time.timeZone = "America/New_York";
  time.hardwareClockInLocalTime = true;  
  
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.firewall.enable = true;
  networking.firewall.allowPing = false;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";
  services.fwupd.enable = true;
}
