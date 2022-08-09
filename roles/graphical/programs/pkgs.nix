{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    firefox
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
    mate.eom

    # communication
    teams
    zoom-us
    discord
    slack

    # development
    racket
    jetbrains.rider
    jetbrains.idea-ultimate
    jetbrains.datagrip
    jetbrains.pycharm-professional
    jetbrains.clion   
    azuredatastudio
    github-desktop    
  ];
}