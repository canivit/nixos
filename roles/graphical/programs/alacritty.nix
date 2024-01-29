{ hidpi ? false, ... }:
{
  home-manager.users.can.home.sessionVariables.TERMINAL = "alacritty";
  home-manager.users.can.home.sessionVariables.TERM = "xterm-256color";

  home-manager.users.can.programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
        WINIT_X11_SCALE_FACTOR = if hidpi then "2" else "1";
      };

      window = {
        padding = {
          x = 4;
          y = 4;
        };
        decorations = "Full";
        startup_mode = "Maximized";
      };

      scrolling = {
        history = 100000;
      };

      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "FiraCode Nerd Font";
          style = "Bold Italic";
        };
        size = 12;
      };

      colors = {
        primary = {
          background = "0x282c34";
          foreground = "0xbbc2cf";
        };

        normal = {
          black = "0x282c34";
          red = "0xff6c6b";
          green = "0x98be65";
          yellow = "0xecbe7b";
          blue = "0x51afef";
          magenta = "0xc678dd";
          cyan = "0x46d9ff";
          white = "0xbbc2cf";
        };
      };
    };
  };
}
