{ ... }:
{
  imports = [
    ./nvim
    ./tmux
    ./fzf.nix
    ./shells.nix
    ./starship.nix
    ./git.nix
    ./ssh.nix
    ./sshd.nix
    ./isp.nix
    ./iplocation.nix
    ./nix.nix
    ./bat.nix
    ./skindle
    # ./asdf.nix
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

  home-manager.backupFileExtension = "backup";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.firewall.enable = true;
  networking.firewall.allowPing = false;
  networking.firewall.checkReversePath = false;

  nixpkgs.config.packageOverrides = pkgs: {
    wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
      patches = attrs.patches ++ [ ./eduroam.patch ];
    });
  };

  services.ntp.enable = true;
  time.timeZone = "Turkey";

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.fstrim.enable = true;
  services.fstrim.interval = "weekly";
  services.fwupd.enable = true;

  modules.cache.enable = true;
  modules.direnv.enable = true;
}
