{ ... }:
{
  services.autorandr = {
    enable = true;
    defaultTarget = "laptop";
    profiles = {
      laptop = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0030e4aa0600000000f11e0104b5221578e3c068a75533b5241050570000000101010101010101010101010101010178e700a0f06045903020360058d71000001a000000fd00303c94943c010a202020202020000000fe004c4720446973706c61790a2020000000fe004c503136305551312d53504231013802030f00e3058000e6060501737342000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006a";
        };

        config = {
          eDP-1 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1200";
            rotate = "normal";
            rate = "60.00";
          };
          DP-1.enable = false;
          DP-2.enable = false;
          DP-3.enable = false;
          DP-4.enable = false;
          HDMI-1.enable = false;
        };
      };

      monitor = {
        fingerprint = {
          eDP-1 = "00ffffffffffff0030e4aa0600000000f11e0104b5221578e3c068a75533b5241050570000000101010101010101010101010101010178e700a0f06045903020360058d71000001a000000fd00303c94943c010a202020202020000000fe004c4720446973706c61790a2020000000fe004c503136305551312d53504231013802030f00e3058000e6060501737342000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006a";
          DP-1 = "00ffffffffffff0030aea26200000000131e0104b54627783ae5a5ae4f43ab260c5054a10800d100d1c0b30081c081809500a9c081004dd000a0f0703e8030203500b9882100001a000000fd00174c1ea03c010a202020202020000000fc004c454e20503332702d32300a20000000ff00564e41344e4232410a2020202001d002031bf14e61605f101f05140413121103020123097f0783010000a36600a0f0701f8030203500b9882100001a565e00a0a0a0295030203500b9882100001a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c";
        };

        config = {
          eDP-1 = {
            enable = true;
            primary = false;
            position = "0x0";
            mode = "1920x1080";
            rotate = "normal";
            rate = "60.00";
          };

          DP-1 = {
            enable = true;
            primary = true;
            position = "0x0";
            mode = "1920x1080";
            rotate = "normal";
            rate = "60.00";
          };

          DP-2.enable = false;
          DP-3.enable = false;
          DP-4.enable = false;
          HDMI-1.enable = false;
        };
      };
    };
  };
}
