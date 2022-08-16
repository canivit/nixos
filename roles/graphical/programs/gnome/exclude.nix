{ pkgs, ... }:
{
  environment.gnome.excludePackages = with pkgs; [ 
    gnome.cheese 
    gnome-photos 
    gnome.gnome-music 
    gnome.gnome-terminal 
    gnome.gedit 
    epiphany 
    gnome.gnome-characters 
    gnome.totem 
    gnome.tali 
    gnome.iagno 
    gnome.hitori 
    gnome.atomix 
    gnome-tour  
    gnome.geary 
  ];
}
