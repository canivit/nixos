{ ... }:
{
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
}
