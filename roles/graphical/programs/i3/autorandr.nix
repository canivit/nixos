{ pkgs, ... }:
let
  eDP1Id = "00ffffffffffff004d101615000000000a1f0104b52215780a98a8af5032bc240b4f550000000101010101010101010101010101010172e700a0f06045903020360050d21000001828b900a0f06045903020360050d210000018000000fe004a4e4a5939804c513135365231000000000002410332011200000b010a202001de02030f00e3058000e606050160602800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000aa"; 

  DP33Id = "00ffffffffffff0010acb7414c304448291f0104b53c22783eee95a3544c99260f5054a54b00e1c0d100d1c0b300a94081808100714f4dd000a0f0703e803020350055502100001a000000ff00324b4c4d5947330a2020202020000000fd00184b1e8c36010a202020202020000000fc0044454c4c205532373230510a200175020324f14c101f2005140413121103020123097f0783010000e305ff01e6060701605628a36600a0f0703e803020350055502100001a565e00a0a0a029503020350055502100001a114400a0800025503020360055502100001a0000000000000000000000000000000000000000000000000000000000000000000000000014";

in
{
  services.autorandr = {
    enable = true;
    profiles = {
      "docked" = {
        fingerprint = {
          DP-3 = DP33Id;
          eDP-1 = eDP1Id;
        };
        config = {
          eDP-1 = {
            enable = true;
            mode = "3840x2400";
            position = "0x0";
            rotate = "normal";
          };
        };
      };

      "mobile" = {
        fingerprint = {
          eDP-1 = eDP1Id;
        };
        config = {
          eDP-1 = {
            enable = true;
            mode = "3840x2400";
            position = "0x0";
            rotate = "normal";
          };
        };
      };

    };
    #hooks.postswitch = "i3-msg-restart";
  };
}
