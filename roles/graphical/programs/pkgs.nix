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
    libreoffice

    # communication
    teams
    zoom-us
    discord
    slack

    # development
    racket
    jetbrains.rider
    mine.dotnet-sdk_5
    jetbrains.idea-ultimate
    jetbrains.datagrip
    jetbrains.pycharm-professional
    jetbrains.clion   
    azuredatastudio
    github-desktop    
  ];
}
