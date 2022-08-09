{ ... }:
{
  home-manager.users.can.programs.zathura = {
    enable = true;
    extraConfig = '' 
      set font "Sans Regular 10"

      set default-bg "#282c34"
      set default-fg "#353b45"

      set statusbar-bg "#282c34"
      set statusbar-fg "#c8ccd4"

      set inputbar-bg "#282c34"
      set inputbar-fg "#c8ccd4"

      set notification-bg "#282c34"
      set notification-fg "#c8ccd4"

      set notification-error-bg "#282c34"
      set notification-error-fg "#e06c75"

      set notification-warning-bg "#282c34"
      set notification-warning-fg "#e06c75"

      set highlight-color "#61afef"
      set highlight-active-color "#61afef"

      set tabbar-focus-bg "#61afef"
      set tabbar-focus-fg "#c8ccd4"

      set completion-bg "#353b45"
      set completion-fg "#61afef"

      set completion-highlight-fg "#c8ccd4"
      set completion-highlight-bg "#61afef"

      set recolor-lightcolor "#282c34"
      set recolor-darkcolor "#b6bdca"
    '';
  };
}
