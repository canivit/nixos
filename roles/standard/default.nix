{ pkgs, ... }:
{
  imports = [
    ./fzf.nix
    ./git.nix
    ./ssh.nix
    ./sshd.nix
    ./isp.nix
    ./iplocation.nix
    ./nix.nix
    ./skindle
    ./pkgs.nix
  ];

  users.users.can = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    initialPassword = "can";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  networking.firewall.enable = true;
  networking.firewall.allowPing = false;
  networking.firewall.checkReversePath = false;

  nixpkgs.config.packageOverrides = pkgs: {
    wpa_supplicant = pkgs.wpa_supplicant.overrideAttrs (attrs: {
      patches = attrs.patches ++ [ ./eduroam.patch ];
    });
  };

  services.ntp.enable = true;
  time.timeZone = "America/Los_Angeles";

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
  modules.sops.enable = true;

  home-manager.backupFileExtension = "backup";
  home-manager.users.can = {
    home.stateVersion = "22.11";
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };
    myModules = {
      shells = {
        fish.enable = true;
        bash.enable = true;
      };
      starship.enable = true;
      neovim.enable = true;
      tmux = {
        enable = true;
        searchPaths = [ "~/workspace ~/neu" ];
      };
    };
  };

  programs.fish.enable = true;
  users.users.can.shell = pkgs.fish;
}
