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
    eza
    tree
    zip
    unzip
    exfat
    bootiso
    usbutils
    pciutils
    nixpkgs-fmt
    openconnect
    awscli2
  ];
}
