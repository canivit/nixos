{ pkgs, ... }:
let
  aliases = {
    ls = "eza --icons --group-directories-first -g -h";
    l = "eza --icons --group-directories-first -g -h -la";
    tree = "eza --icons -T";
    t = "eza --icons -T";
    cat = "bat";
  };
in
{
  programs.fish.enable = true;
  programs.zsh.enable = true;
  users.users.can.shell = pkgs.fish;

  home-manager.users.can.programs.fish = {
    enable = true;
    shellAliases = aliases;
    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings

      function open-finder
        tmux-sessionizer
      end

      function open-home
        tmux-sessionizer $HOME
      end

      bind -M insert \cF open-finder
      bind -M default \cF open-finder

      bind -M insert \cH open-home
      bind -M default \cH open-home
      
    '';
    # source ${pkgs.asdf-vm}/share/asdf-vm/asdf.fish
  };

  home-manager.users.can.programs.bash = {
    enable = true;
    shellAliases = aliases;
    initExtra = ''
    '';
  };
}
