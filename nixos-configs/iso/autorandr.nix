{ config, ... }:
let
  cfg =
    if config.modules.hidpi.enable then
      {
        builtinRes = "3840x2400";
        externalRes = "3840x2160";
      }
    else
      {

        builtinRes = "1920x1200";
        externalRes = "1920x1080";
      };
in
{
  services.autorandr = {
    enable = true;
    defaultTarget = "monitor";
    hooks.postswitch = {
      updatelock = "updatelock";
    };
    ignoreLid = true;
    profiles = {
      monitor = {
        fingerprint = {
          DP-1 = "00ffffffffffff0010ac7942554b4d4421220104b53c22783adf15ad5044ad250f5054a54b00d100d1c0b300a94081808100714fe1c04dd000a0f0703e803020350055502100001a000000ff00344244314733340a2020202020000000fc0044454c4c20553237323351450a000000fd0017560f8c36010a202020202020013d020317f14a101f20041312110302012309070783010000a36600a0f0701f803020350055502100001a565e00a0a0a029503020350055502100001a114400a080001f503020360055502100001abf1600a08038134030203a0055502100001a0000000000000000000000000000000000000000000000000000000000000000a9";
        };

        config = {
          DP-1 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = cfg.externalRes;
            rotate = "normal";
            rate = "60.00";
          };
        };
      };
    };
  };
}
