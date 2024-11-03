{ modulesPath, pkgs, ... }:

{
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
  ];

  documentation.enable = false;

  nix = {
    settings = {
      trusted-users = [ "@wheel" ];
      auto-optimise-store = true;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "14:00";
      options = "--delete-older-than 7d";
    };
  };


  environment.systemPackages = with pkgs; [
    cachix
    tmux
  ];

  system.stateVersion = "24.05";
}
