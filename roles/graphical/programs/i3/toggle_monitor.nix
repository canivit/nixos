{ pkgs, ... }:
let
  toggle_monitor = pkgs.writeShellScriptBin "toggle_monitor" ''
    if xrandr | grep "DP-1-3 connected"; then
      xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-3 --mode 1920x1080 --pos 0x0 --rotate normal
    else
      xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1-3 --off
    fi
  '';
in
  {
    environment.systemPackages = with pkgs; [ toggle_monitor ];
  }

