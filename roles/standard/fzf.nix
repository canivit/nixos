{ ... }:
{
  home-manager.users.can.programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    tmux.enableShellIntegration = true;
  };
}
