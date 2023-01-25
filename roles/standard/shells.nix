{ pkgs, ... }:
let
  aliases = {
    ls = "exa --icons --group-directories-first -g -h";
    l = "exa --icons --group-directories-first -g -h -la";
    tree = "exa --icons -T";
    t = "exa --icons -T";
    cat = "bat";
  };
in {
  programs.fish.enable = true;
  users.users.can.shell = pkgs.fish;

  home-manager.users.can.programs.fish = {
    enable = true;
    shellAliases = aliases;
    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings
    '';
  };

  home-manager.users.can.programs.bash = {
    enable = true;
    shellAliases = aliases;
    initExtra = ''
    '';
  };
}
