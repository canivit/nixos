{ ... }:
{
  programs.home-manager.enable = true;
  systemd.user.enable = true;
  myModules = {
    shells = {
      fish.enable = true;
      zsh.enable = true;
      bash.enable = false;
      work.enable = true;
    };
    starship.enable = true;
    neovim.enable = true;
    tmux = {
      enable = true;
      searchPaths = [ "~/workplace" ];
    };
  };
}
