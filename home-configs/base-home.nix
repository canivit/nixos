{ ... }:
{
  myModules = {
    fish.enable = true;
    bash.enable = true;
    starship.enable = true;
    neovim.enable = true;
    tmux = {
      enable = true;
      searchPaths = [ "~/workplace" ];
    };
  };
}
