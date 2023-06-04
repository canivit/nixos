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
    rclone

    # communication
    zoom-us
    discord
    slack

    # development
    racket
    jetbrains.rider
    jetbrains.idea-ultimate
  ];
}
