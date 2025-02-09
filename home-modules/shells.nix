{
  lib,
  config,
  ...
}:
let
  fishCfg = config.myModules.fish;
  zshCfg = config.myModules.zsh;
  bashCfg = config.myModules.bash;
in
{
  options.myModules.fish.enable = lib.mkEnableOption "fish shell";
  options.myModules.zsh.enable = lib.mkEnableOption "zsh shell";
  options.myModules.bash.enable = lib.mkEnableOption "bash shell";
  config =
    let
      aliases = {
        ls = "eza --icons --group-directories-first -g -h --git";
        l = "eza --icons --group-directories-first -g -h -la --git";
        tree = "eza --icons -T";
        t = "eza --icons -T";
        cat = "bat";
      };
      enableAnyShell = fishCfg.enable || zshCfg.enable || bashCfg.enable;
    in
    {
      programs.bat = lib.mkIf enableAnyShell {
        enable = true;
        config = {
          theme = "TwoDark";
        };
      };

      programs.eza = lib.mkIf enableAnyShell {
        enable = true;
      };

      programs.fish = lib.mkIf fishCfg.enable {
        enable = true;
        shellAliases = aliases;
        interactiveShellInit =
          let
            base = ''
              set fish_greeting
              fish_vi_key_bindings


              function open-home
                tmux-sessionizer $HOME
              end

              bind -M insert \cF open-finder
              bind -M default \cF open-finder

              bind -M insert \cH open-home
              bind -M default \cH open-home

            '';

            tmuxBinding = ''
              function open-finder
                tmux-sessionizer
              end
            '';
          in
          if config.myModules.tmux.enable then (base + tmuxBinding) else base;
      };

      programs.zsh = lib.mkIf zshCfg.enable {
        enable = true;
        shellAliases = aliases;
      };

      programs.bash = lib.mkIf bashCfg.enable {
        enable = true;
        shellAliases = aliases;
      };
    };
}
