{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox-devedition-bin
    polkit_gnome
    gparted
    vlc
    mpv
    inkscape
    gimp
    pavucontrol
    kdenlive
    torrential
    lxappearance
    sxiv
    vmware-horizon-client
    calibre

    # communication
    teams
    zoom-us
    discord
    slack

    # development
    racket
    jetbrains.rider
    dotnet-sdk_5
    jetbrains.idea-ultimate
    github-desktop

  ];
}
