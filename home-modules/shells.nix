{
  lib,
  config,
  ...
}:
let
  fishCfg = config.myModules.shells.fish;
  zshCfg = config.myModules.shells.zsh;
  bashCfg = config.myModules.shells.bash;
  workCfg = config.myModules.shells.work;
in
{
  options.myModules.shells = {
    fish.enable = lib.mkEnableOption "fish shell";
    zsh.enable = lib.mkEnableOption "zsh shell";
    bash.enable = lib.mkEnableOption "bash shell";
    work.enable = lib.mkEnableOption "setup shells for work";
  };
  config =
    let
      enableAnyShell = fishCfg.enable || zshCfg.enable || bashCfg.enable;
      aliasGroups = [
        {
          enable = enableAnyShell;
          value = {
            ls = "eza --icons --group-directories-first -g -h --git";
            l = "eza --icons --group-directories-first -g -h -la --git";
            tree = "eza --icons -T";
            t = "eza --icons -T";
            cat = "bat";
          };
        }

        {
          enable = workCfg.enable;
          value = {
            bb = "brazil-build";
            bba = "brazil-build apollo-pkg";
            bre = "brazil-runtime-exec";
            brc = "brazil-recursive-cmd";
            bws = "brazil ws";
            bwsuse = "bws use -p";
            bwscreate = "bws create -n";
            bbr = "brc brazil-build";
            bball = "brc --allPackages";
            bbb = "brc --allPackages brazil-build";
            bbra = "bbr apollo-pkg";
          };
        }
      ];

      aliases = builtins.foldl' (
        acc: item: if item.enable then (acc // item.value) else acc
      ) { } aliasGroups;

      extraFishConfigs = [
        {
          enable = fishCfg.enable;
          value = ''
            set fish_greeting
            fish_vi_key_bindings
          '';
        }

        {
          enable = config.myModules.tmux.enable;
          value = ''
            function open-home
              tmux-sessionizer $HOME
            end

            function open-finder
              tmux-sessionizer
            end

            bind -M insert \cF open-finder
            bind -M default \cF open-finder

            bind -M insert \cH open-home
            bind -M default \cH open-home
          '';
        }

        {
          enable = workCfg.enable;
          value = ''
            set -x PATH /apollo/env/ApolloCommandLine/bin $PATH
            set -x PATH $HOME/.toolbox/bin $PATH
            set -x PATH /apollo/env/envImprovement/bin $PATH
            set -x PATH /home/rcanivit/.cargo/bin $PATH

            alias vi='nvim'
            alias vim='nvim'
          '';
        }
      ];

      extraFishConfig = builtins.foldl' (
        acc: item: if item.enable then (acc + item.value) else acc
      ) "" extraFishConfigs;

      extraZshConfigs = [
        {
          enable = zshCfg.enable;
          value = '''';
        }

        {
          enable = workCfg.enable;
          value = ''
            export PATH=/apollo/env/ApolloCommandLine/bin:$PATH
            export PATH=$HOME/.toolbox/bin:$PATH
            export PATH=/apollo/env/envImprovement/bin:$PATH
            export PATH=/home/rcanivit/.cargo/bin:$PATH

            source /home/rcanivit/.brazil_completion/zsh_completion

            alias vi='nvim'
            alias vim='nvim'

            exec fish
          '';
        }
      ];

      extraZshConfig = builtins.foldl' (
        acc: item: if item.enable then (acc + item.value) else acc
      ) "" extraZshConfigs;

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
        interactiveShellInit = extraFishConfig;
      };

      programs.zsh = lib.mkIf zshCfg.enable {
        enable = true;
        shellAliases = aliases;
        initExtra = extraZshConfig;
      };

      programs.bash = lib.mkIf bashCfg.enable {
        enable = true;
        shellAliases = aliases;
      };
    };
}
