{ config, pkgs, ... }:
{
  services.logind = {
    lidSwitch = "suspend";
    extraConfig = ''
      HandlePowerKey=ignore
    '';
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
  ];

  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
