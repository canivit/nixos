{ writeShellScriptBin, xprop, xdotool, gawk, gnused }:
writeShellScriptBin "wmclass" ''
  WM_DESKTOP=$(${xdotool}/bin/xdotool getwindowfocus)

  if [ $WM_DESKTOP == "14680164" ]; then
    echo "Desktop"

  else
    WM_CLASS=$(${xprop}/bin/xprop -id $(${xdotool}/bin/xdotool getactivewindow) WM_CLASS | ${gawk}/bin/awk 'NF {print $NF}' | ${gnused}/bin/sed 's/"/ /g')
    echo $WM_CLASS
  fi
''
