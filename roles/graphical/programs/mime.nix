{ lib, config, ... }:
let
  mimeTypes = {
    web = [
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "x-scheme-handler/chrome"
      "application/x-extension-htm"
      "application/x-extension-html"
      "application/x-extension-shtml"
      "application/xhtml+xml"
      "application/x-extension-xhtml"
      "application/x-extension-xht"
    ];
  };

  browser = config.modules.browser.default.desktop;
in
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
    } //
    lib.genAttrs mimeTypes.web (_: [ browser ]);
  };
}
