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
    teams-for-linux
    discord
    slack

    # development
    racket
    jetbrains.rider
    jetbrains.idea-ultimate
    unstable.android-studio
    mongodb-compass
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
