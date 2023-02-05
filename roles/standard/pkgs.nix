{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    coreutils
    wget
    curl
    nano
    htop
    killall
    neofetch
    exa
    tree
    zip
    unzip
    exfat
    bootiso
    usbutils
    pciutils
    nixfmt
    openconnect
    mine.skindle
  ];
}
