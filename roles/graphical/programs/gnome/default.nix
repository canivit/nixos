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
        disableWhileTyping = false;
      };
    };
    displayManager = {
      defaultSession = "gnome";
      gdm.enable = true;
    };
    desktopManager.gnome = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [ 
    arc-theme
    papirus-icon-theme
    dconf2nix
    gnomeExtensions.appindicator 
    gnome.gnome-tweaks
    gnomeExtensions.paperwm
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
