{ lib, config, pkgs, ... }:
let cfg = config.modules.browser.chromium; in {
  options.modules.browser.chromium = {
    enable = lib.mkEnableOption "enable chromium web browser";
    default = lib.mkEnableOption "set chromium as default browser";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.chromium ];
    modules.browser.default = lib.mkIf cfg.default {
      cmd = "chromium";
      desktop = "chromium.desktop";
    };

    programs.chromium = {
      enable = true;
      extensions = [
        "nngceckbapebfimnlniiiahkandclblb" # bitwarden
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "bcjindcccaagfpapjjmafapmmgkkhgoa" # JSON formatter
      ];

      extraOpts = {
        "PasswordManagerEnabled" = false;
        "DefaultBrowserSettingEnabled" = false;
      };
    };

    nixpkgs.config.chromium = {
      enableWideVine = true;
      commandLineArgs = lib.concatStringsSep " " [
        "--ignore-gpu-blocklist" # force gpu acceleration
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--enable-features=VaapiVideoDecoder" # enable hardware accelerated video decoding
      ];
    };
  };
}
