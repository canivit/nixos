{ pkgs, config, ... }:
let
  bg = import ./../../background.nix { inherit pkgs; };
in
{
  imports = [
    ./exclude.nix
  ];

  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      touchpad = {
        accelProfile = "adaptive";
        accelSpeed = "0.5";
        tapping = true;
        naturalScrolling = true;
        scrollMethod = "twofinger";
        disableWhileTyping = true;
      };
    };
    displayManager = {
      defaultSession = "gnome-xorg";
      gdm.enable = true;
    };
    desktopManager.gnome = {
      enable = true;
    };
  };

  programs.gnome-disks.enable = true;
  services.gnome.gnome-settings-daemon.enable = true;
  services.gnome.core-utilities.enable = true;
  services.gnome.core-shell.enable = true;
  services.gnome.core-os-services.enable = true;
  programs.file-roller.enable = true;
  qt5.platformTheme = "gnome";

  environment.systemPackages = with pkgs; [ 
    dconf2nix
    gnomeExtensions.appindicator 
    gnome.gnome-tweaks
  ];

   home-manager.users.can = { pkgs, ... }: {
    imports = [ ./dconf.nix ];
    home.file = {
      "background.png" = {
        source = bg.background;
      };
    };
  };
}
