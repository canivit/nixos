{ pkgs, ... }:
let
  bg = import ./../background.nix { inherit pkgs; };
in
  {
    services.xserver = {
      enable = true;
      layout = "us";
      dpi = 96;

      libinput = {
        enable = true;
        touchpad = {
          accelProfile = "adaptive";
          #accelSpeed = "0.5";
          tapping = true;
          naturalScrolling = true;
          scrollMethod = "twofinger";
          disableWhileTyping = true;
        };
      };

      # desktopManager.wallpaper.mode = "center";

      displayManager.lightdm = {
        enable = true;
        background = bg.login;
        greeters.gtk = {
          enable = true;
          theme = {
            package = pkgs.arc-theme;
            name = "Arc-Dark";
          };
          iconTheme = {
            package = pkgs.papirus-icon-theme;
            name = "Papirus-Dark";
          };
          cursorTheme = {
            package = pkgs.gnome.adwaita-icon-theme;
            name = "Adwaita";
            size = 24;
          };
        };
      };
    };

    hardware.video.hidpi.enable = false;

    home-manager.users.can.home.file.".background-image".source = bg.background_fhd;
    home-manager.users.can.xresources.extraConfig = builtins.readFile ./Xresources;

    home-manager.users.can.home.pointerCursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
    };

    #environment.variables = {
    #  "GDK_SCALE" = "1";
    #  "XCURSOR_SIZE" = "24";
    #  "GDK_DPI_SCALE" = "1";
    #  "QT_SCALE_FACTOR" = "1.5";
    #};
  }
