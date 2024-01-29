{ pkgs, ... }:
let
  tmux-sessionizer = pkgs.writeScriptBin "tmux-sessionizer" (builtins.readFile
    (pkgs.substituteAll {
      src = ./tmux-sessionizer.sh;
      fd = "${pkgs.fd}/bin/fd";
      fzf = "${pkgs.fzf}/bin/fzf";
      tmux = "${pkgs.tmux}/bin/tmux";
      basename = "${pkgs.coreutils}/bin/basename";
      tr = "${pkgs.coreutils}/bin/tr";
      pgrep = "${pkgs.procps}/bin/pgrep";
    }));
in
{
  home-manager.users.can.programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    shortcut = "a";
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    baseIndex = 1;
    resizeAmount = 2;
    escapeTime = 10;
    historyLimit = 100000;
    extraConfig = ''
      set -g mouse on

      bind-key "|" split-window -h -c "#{pane_current_path}"
      bind-key "\\" split-window -fh -c "#{pane_current_path}"

      bind-key "-" split-window -v -c "#{pane_current_path}"
      bind-key "_" split-window -fv -c "#{pane_current_path}"

      bind > swap-pane -D
      bind < swap-pane -U

      set -sg repeat-time 600

      set -g default-terminal "xterm-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g base-index 1
      setw -g pane-base-index 1

      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = onedark-theme;
        extraConfig = "";
      }
    ];
  };

  environment.systemPackages = [ tmux-sessionizer ];
}
