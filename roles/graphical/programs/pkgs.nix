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
    sxiv

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
    
    vmware-horizon-client
  ];
}
