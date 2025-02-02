{ pkgs, ... }:
{
  home-manager.users.can.programs.vscode = {
    enable = true;
    package = pkgs.master.vscode;
  };
}
