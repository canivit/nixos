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
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };
  };
}
