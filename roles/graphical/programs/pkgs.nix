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
    jetbrains.idea-ultimate
    jetbrains.datagrip
    jetbrains.pycharm-professional
    jetbrains.clion   
    azuredatastudio
    github-desktop    

    (with dotnetCorePackages; combinePackages [
      sdk_6_0
      sdk_5_0
    ])
    
    vmware-horizon-client
  ];
}
