args@{ hidpi ? false, ... }:
{
  imports = [
    (
      import ./i3 (
        args // { inherit hidpi; }
      )
    )
    ./rofi.nix
    (
      import ./alacritty.nix (
        args // { inherit hidpi; }
      )
    )

    ./vscode
    ./chromium.nix
    ./mpv.nix
    ./zathura.nix
    ./pcmanfm.nix
    ./wireshark.nix
    ./pkgs.nix
    ./mime.nix
    ./docread
    ./rendermd
    ./kdeconnect.nix
    ./redshift.nix
  ];
}
