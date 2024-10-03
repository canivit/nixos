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
    obs-studio
    zotero
    spotify

    # communication
    zoom-us
    teams-for-linux
    discord
    slack
    thunderbird

    # development
    racket
    jetbrains.rider
    jetbrains.idea-ultimate
    jetbrains.pycharm-community
    jetbrains.rust-rover
    unstable.android-studio
    jetbrains.clion
    gnumake
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
  };
}
