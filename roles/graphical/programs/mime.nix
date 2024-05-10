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
      "x-scheme-handler/http" = [ "chromium.desktop" ];
      "x-scheme-handler/https" = [ "chromium.desktop" ];
      "x-scheme-handler/chrome" = [ "chromium.desktop" ];
      "application/x-extension-htm" = [ "chromium.desktop" ];
      "application/x-extension-html" = [ "chromium.desktop" ];
      "application/x-extension-shtml" = [ "chromium.desktop" ];
      "application/xhtml+xml" = [ "chromium.desktop" ];
      "application/x-extension-xhtml" = [ "chromium.desktop" ];
      "application/x-extension-xht" = [ "chromium.desktop" ];
    };
  };
}
