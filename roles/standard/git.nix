{ pkgs, ... }:
{
  home-manager.users.can.programs.git = {
    enable = true;
    userName = "Can Ivit";
    userEmail = "canivit@users.noreply.github.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };


  home-manager.users.can.programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      aliases = { };
    };
  };
}
