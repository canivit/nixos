{ pkgs, lib, ... }:
let
  lock = "${pkgs.systemd}/bin/loginctl lock-session";
in {
  imports = [
    ./lock.nix
    ./polybar
    ./systray.nix
    ./picom.nix
    ./toggle_monitor.nix
    #./autorandr.nix
  ];

  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };

  home-manager.users.can.xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    config = rec {
      modifier = "Mod4";

      terminal = "alacritty";

      fonts = {
        names = [ "Open Sans" ];
        style = "Bold";
        size = 10.0;
      };

      bars = [];

      focus.followMouse = false;

      window = {
        titlebar = false;
        border = 2;
        commands = [
          { command = "focus"; criteria = { urgent = "latest"; }; }
        ];
      };

      gaps = {
        inner = 10;
        outer = 0;
        smartGaps = true;
        smartBorders = "on";
      };

      workspaceAutoBackAndForth = true;

      floating.criteria = [
        { class = "Pavucontrol"; }
        { class = "pavucontrol"; }
        { class = ".blueman-manager-wrapped"; }
        { class = ".arandr-wrapped"; }
        { class = "nm-connection-editor"; }
        { class = "zoom"; }
      ];

      modes = {
        resize = {
          h = "resize grow width 5 px or 5 ppt";
          j = "resize grow height 5 px or 5 ppt";
          k = "resize shrink height 5 px or 5 ppt";
          l = "resize shrink width 5 px or 5 ppt";
          Return = "mode default";
          Escape = "mode default";
        };

        power = {
          l = "exit";
          r = "exec systemctl reboot";
          p = "exec systemctl poweroff";
          h = "exec --no-startup-id systemctl hibernate ; mode default";
          s = "exec --no-startup-id systemctl suspend ; mode default";
          Return = "mode default";
          Escape = "mode default";
        };
      };

      startup = [
        { 
         command = "i3-msg workspace 1"; 
         always = true; 
         notification = false; 
        }
        
        { 
          command = "${pkgs.systemd}/bin/systemctl --user restart polybar"; 
          always = true; 
          notification = false; 
        }

        { 
          command = "${pkgs.autorandr}/bin/autorandr -c"; 
          always = true; 
          notification = false; 
        }

        { 
          command = "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1";
          always = false; 
          notification = false; 
        }
      ];

      keybindings = {
        "${modifier}+1" = "workspace 1";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+0" = "workspace 10";

        "${modifier}+Shift+1" = "move container to workspace 1";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5";
        "${modifier}+Shift+6" = "move container to workspace 6";
        "${modifier}+Shift+7" = "move container to workspace 7";
        "${modifier}+Shift+8" = "move container to workspace 8";
        "${modifier}+Shift+9" = "move container to workspace 9";
        "${modifier}+Shift+0" = "move container to workspace 10";

       
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+a" = "focus parent";
        "${modifier}+Shift+a" = "focus child";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+q" = "kill";

        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+i" = "split h";
        "${modifier}+o" = "split v";
        "${modifier}+s" = "layout toggle split";
        "${modifier}+Tab" = "layout toggle tabbed splith";
        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+r" = "mode resize";
        "${modifier}+Escape" = "mode power";

        "${modifier}+Shift+c" = "reload";
        "${modifier}+Shift+r" = "restart";
        # "${modifier}+Shift+m" = "exec --no-startup-id toggle_monitor";

        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "XF86MonBrightnessUp" = "exec --no-startup-id light -A 5";
        "XF86MonBrightnessDown" = "exec --no-startup-id light -U 5";

        "${modifier}+Delete" = "exec --no-startup-id ${lock}";

        "${modifier}+Return" = "exec --no-startup-id alacritty";
        "${modifier}+Shift+Return" = "exec --no-startup-id alacritty -e ssh khoury";
        "${modifier}+backslash" = "exec --no-startup-id ${pkgs.firefox}/bin/firefox";
        "${modifier}+BackSpace" = "exec --no-startup-id ${pkgs.pcmanfm}/bin/pcmanfm";
        "${modifier}+d" = "exec --no-startup-id rofi -show drun";

        "${modifier}+n" = "exec ${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
        "${modifier}+m" = "exec ${pkgs.arandr}/bin/arandr";
        "${modifier}+p" = "exec --no-startup-id ${pkgs.pavucontrol}/bin/pavucontrol";
        "${modifier}+b" = "exec --no-startup-id ${pkgs.blueman}/bin/blueman-manager";
      };

      colors = {
        focused = {
          border = "#000000";
          background = "#51afef";
          text = "#282c34";
          indicator = "#51afef";
          childBorder = "#51afef";
        };

        focusedInactive = {
          border = "#000000";
          background = "#21242b";
          text = "#3f444a";
          indicator = "#3f444a";
          childBorder = "#3f444a";
        };

        unfocused = {
          border = "#000000";
          background = "#21242b";
          text = "#3f444a";
          indicator = "#3f444a";
          childBorder = "#3f444a";
        };

        urgent = {
          border = "#000000";
          background = "#ff6c6b";
          text = "#282c34";
          indicator = "#ff6c6b";
          childBorder = "#ff6c6b";
        };

        placeholder = {
          border = "#000000";
          background = "#000000";
          text = "#000000";
          indicator = "#000000";
          childBorder = "#000000";
        };

        background = "#000000";
      };
    };
  };

  programs.light.enable = true;
  users.users.can.extraGroups = [ "video" ];

  programs.nm-applet.enable = true;
  programs.nm-applet.indicator = true;

  environment.pathsToLink = [ "/libexec" ];
}
