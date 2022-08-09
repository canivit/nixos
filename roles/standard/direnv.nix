{ pkgs, ... }:
{
  home-manager.users.can.programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    #enableFishIntegration = true;
  };

  home-manager.users.can.programs.git.ignores = [
    ".envrc"
    ".direnv"
  ];
}
