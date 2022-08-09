{ pkgs, ... }:
let
  toggle_monitor = pkgs.writeShellScriptBin "toggle_monitor" ''
    if xrandr | grep "DP-3-3 connected"; then
      xrandr --output DP-3-3 --primary --mode 3840x2160 --pos 0x0 --rotate normal --output eDP-1 --off
    else
      xrandr --output eDP-1 --mode 3840x2400 --pos 0x0 --rotate normal --output DP-3-3 --off
    fi

    ${pkgs.i3-gaps}/bin/i3-msg restart
    updatelock
  '';
in
  {
    environment.systemPackages = with pkgs; [ toggle_monitor ];
  }

