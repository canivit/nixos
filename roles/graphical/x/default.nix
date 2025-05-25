{ pkgs, config, ... }:
let
  bg = import ./../background.nix { inherit pkgs; };
  cfg =
    if config.modules.hidpi.enable then {
      dpi = 192;
      cursorSize = 48;
      accelSpeed = "0.5";
      env = {
        "GDK_SCALE" = "2";
        "XCURSOR_SIZE" = "48";
        "GDK_DPI_SCALE" = "0.5";
        "QT_SCALE_FACTOR" = "1";
        "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
        "QT_FONT_DPI" = "192";
      };
    } else {
      dpi = 96;
      cursorSize = 24;
      accelSpeed = null;
      env = {
        "GDK_SCALE" = "1";
        "XCURSOR_SIZE" = "24";
        "GDK_DPI_SCALE" = "1";
        "QT_SCALE_FACTOR" = "1";
        "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
        "QT_FONT_DPI" = "96";
      };
    };
in
{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    dpi = cfg.dpi;


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
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
          size = cfg.cursorSize;
        };
      };
    };
  };

  services.libinput = {
    enable = true;
    touchpad = {
      accelProfile = "adaptive";
      accelSpeed = cfg.accelSpeed;
      tapping = true;
      naturalScrolling = true;
      scrollMethod = "twofinger";
      disableWhileTyping = true;
    };
  };

  home-manager.users.can.home.file.".background-image".source = bg.background_fhd;
  home-manager.users.can.xresources.extraConfig = builtins.readFile ./Xresources;

  home-manager.users.can.home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = cfg.cursorSize;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  environment.variables = cfg.env;
}
