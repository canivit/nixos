{ pkgs, config, ... }:
let
  wmclass = pkgs.callPackage ./wmclass.nix { };
  dpiCfg =
    if config.modules.hidpi.enable then {
      height = "55";
      line-size = "6";
      dpi = "192";
      border-bottom-size = "2";
      tray-maxsize = "35";
    } else {
      height = "30";
      line-size = "3";
      dpi = "96";
      border-bottom-size = "1";
    };
in
{
  home-manager.users.can.services.polybar = {
    enable = true;

    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };

    script = ''
      polybar main &
    '';

    settings = {
      "color" = {
        bg = "#1e2127";
        bg-alt = "#3F444A";
        fg = "#BBC2CF";
        primary = "#51AFEF";
        red = "FF6C6B";
      };

      "bar/main" = {
        width = "100%";
        bottom = "false";
        fixed-center = "true";
        border-color = "#000000";
        background = "\${color.bg}";
        foreground = "\${color.fg}";
        cursor-click = "pointer";
        enable-ipc = "true";

        tray-position = "right";
        tray-detached = "false";
        tray-scale = "1";
        tray-padding = "15";

        modules-left = "workspaces wmclass";
        modules-center = "";
        modules-right = "kernel cpu memory backlight volume wired-network wireless-network battery date time";
        module-margin-left = "0";
        module-margin-right = "5";

        font-0 = "\"Open Sans:style=Bold:size=10.5;4\"";
        font-1 = "\"Font Awesome 6 Free,Font Awesome 6 Free Solid:style=Solid:size=10.5;4\"";
        font-2 = "\"Font Awesome 6 Free,Font Awesome 6 Free Regular:style=Regular:size=10.5;4\"";
        font-3 = "\"Font Awesome 6 Brands,Font Awesome 6 Brands Regular:style=Regular:size=10.5;4\"";
        font-4 = "\"Material Icons:style=Regular:size=10.5;4\"";
      } // dpiCfg;

      "module/workspaces" = {
        type = "internal/i3";
        pin-workspaces = "true";
        enable-click = "true";
        enable-scroll = "true";
        wrapping-scroll = "false";

        format = "<label-state> <label-mode>";

        label-mode = "%mode%";
        label-mode-padding = "4";
        label-mode-background = "\${color.primary}";
        label-mode-foreground = "\${color.bg}";

        label-focused = "%index%";
        label-focused-background = "\${color.bg-alt}";
        label-focused-underline = "\${color.primary}";
        label-focused-padding = "3";

        label-unfocused = "%index%";
        label-unfocused-padding = "3";

        label-urgent = "%index%";
        label-urgent-background = "\${color.red}";
        label-urgent-padding = "3";
      };

      "module/wmclass" = {
        type = "custom/script";
        interval = "1";
        exec = "${wmclass}/bin/wmclass";
      };

      "module/battery" = {
        type = "internal/battery";
        full-at = "99";
        time-format = "%H:%M";
        battery = "BAT0";
        adapter = "AC";
        poll-interval = "5";

        format-charging = "<animation-charging> <label-charging>";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-full = "<ramp-capacity> <label-full>";

        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "%percentage%%";

        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";

        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";

        animation-charging-framerate = "750";
      };

      "module/volume" = {
        type = "internal/pulseaudio";
        use-ui-max = "false";
        interval = "5";

        format-volume = "<ramp-volume> <label-volume>";
        format-muted = "<label-muted>";

        label-volume = "%percentage%%";
        label-muted = " MUTED";

        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
      };

      "module/backlight" = {
        type = "internal/backlight";
        card = "intel_backlight";

        format = "<label>";

        label = " %percentage%%";
      };

      "module/time" = {
        type = "internal/date";
        interval = "1";
        label = "%time% ";
        time = " %H:%M";
      };

      "module/date" = {
        type = "internal/date";
        interval = "1";
        label = "%date%";
        date = " %m/%d/%Y";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = "5";
        format = "<label>";
        label = " %percentage%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = "5";
        format = "<label>";
        label = " %gb_used%";
      };

      "module/kernel" = {
        type = "custom/script";
        exec = "${pkgs.coreutils}/bin/uname -r";
        tail = "false";
        interval = "1024";
        format = "<label>";
        label = " %output%";
      };

      "module/wireless-network" = {
        type = "internal/network";
        interface-type = "wireless";
        interval = "3.0";
        label-connected = " %local_ip%";
        label-disconnected = "";
      };

      "module/wired-network" = {
        type = "internal/network";
        interface-type = "wired";
        interval = "3.0";
        label-connected = " %local_ip%";
        label-disconnected = " Disconnected";
      };
    };
  };

  environment.systemPackages = [
    wmclass
  ];
}
