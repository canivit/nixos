{ lib, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.chromium ];

  programs.chromium = {
    enable = true;
    extensions = [
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "bcjindcccaagfpapjjmafapmmgkkhgoa" # JSON formatter
      #"hipekcciheckooncpjeljhnekcoolahp" # Tabliss
      "fmkadmapgofadopljbjfkapdkoienihi" # React Dev Tools
    ];
    
    extraOpts = {
      "PasswordManagerEnabled" = false;
      "DefaultBrowserSettingEnabled" = true;
      "BrowserThemeColor" = "#282c34";
    };
  };

  nixpkgs.config.chromium.commandLineArgs = lib.concatStringsSep " " [
    "--ignore-gpu-blocklist"              # force gpu acceleration
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    
    "--enable-features=VaapiVideoDecoder" # enable hardware accelerated video decoding
  ];
}
