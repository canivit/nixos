{ hidpi ? false, pkgs, ... }:
let
  bg = import ./../background.nix { inherit pkgs; };
  cursorSize = if hidpi then 48 else 24;
in
{
  services.xserver = {
    enable = true;
    layout = "us";
    dpi = if hidpi then 192 else 96;

    libinput = {
      enable = true;
      touchpad = {
        accelProfile = "adaptive";
        accelSpeed = if hidpi then "0.5" else null;
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
          size = cursorSize;
        };
      };
    };
  };

  home-manager.users.can.home.file.".background-image".source = bg.background_fhd;
  home-manager.users.can.xresources.extraConfig = builtins.readFile ./Xresources;

  home-manager.users.can.home.pointerCursor = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = cursorSize;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  environment.variables =
    if hidpi then {
      "GDK_SCALE" = "2";
      "XCURSOR_SIZE" = "48";
      "GDK_DPI_SCALE" = "0.5";
      "QT_SCALE_FACTOR" = "1";
      "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
      "QT_FONT_DPI" = "192";
    } else {
      "GDK_SCALE" = "1";
      "XCURSOR_SIZE" = "24";
      "GDK_DPI_SCALE" = "1";
      "QT_SCALE_FACTOR" = "1";
      "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
      "QT_FONT_DPI" = "96";
    };
}
