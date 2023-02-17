{ writeShellScriptBin, xprop, xdotool, gawk, gnused }:
writeShellScriptBin "wmclass" ''
  if ACTIVE_WINDOW=$(${xdotool}/bin/xdotool getactivewindow 2> /dev/null); then
    echo $(${xprop}/bin/xprop -id $ACTIVE_WINDOW WM_CLASS | ${gawk}/bin/awk 'NF {print $NF}' | ${gnused}/bin/sed 's/"/ /g')
  else
    echo "Desktop"
  fi
''
