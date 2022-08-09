{ ... }:
{
  home-manager.users.can.services.picom = {
    backend = "glx";
    enable = true;
    shadow = false;
    shadowExclude = [
      "class_g = 'Polybar'"
      "class_g = 'slop'"
    ];
    fade = true;
    fadeDelta = 2;
    extraOptions = ''
      xinerama-shadow-crop = true;
      shadow-exclude-reg = "x30+0+0";
      # glx-no-stencil = true;
      # glx-swap-method = "buffer-age";
      # xrender-sync-fence = true;
      # mark-wmwin-focused = true;
      # mark-ovredir-focused = true;
    '';
    vSync = true;
  };
}
