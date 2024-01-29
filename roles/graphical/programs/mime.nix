{ ... }:
{
  home-manager.users.can = {
    xdg.mime.enable = true;
    xdg.mimeApps.enable = true;
    xdg.mimeApps.defaultApplications = {
      "inode/directory" = [ "pcmanfm.desktop" ];
      "image/jpeg" = [ "sxiv.desktop" ];
      "image/png" = [ "sxiv.desktop" ];
      "application/pdf" = [ "zathura.desktop" ];
      "application/epub+zip" = [ "zathura.desktop" ];
      "text/plain" = [ "code.desktop" ];
      "x-scheme-handler/http" = [ "firefox-devedition.desktop" ];
      "x-scheme-handler/https" = [ "firefox-devedition.desktop" ];
      "x-scheme-handler/chrome" = [ "firefox-devedition.desktop" ];
      "application/x-extension-htm" = [ "firefox-devedition.desktop" ];
      "application/x-extension-html" = [ "firefox-devedition.desktop" ];
      "application/x-extension-shtml" = [ "firefox-devedition.desktop" ];
      "application/xhtml+xml" = [ "firefox-devedition.desktop" ];
      "application/x-extension-xhtml" = [ "firefox-devedition.desktop" ];
      "application/x-extension-xht" = [ "firefox-devedition.desktop" ];
    };
  };
}
