{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          package = pkgs.OVMFFull;
        };
        swtpm = {
          enable = true;
        };
      };
    };
    spiceUSBRedirection.enable = true;

    docker = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    win-virtio
    spice-gtk
  ];

  users.users.can.extraGroups = [ "libvirtd" "docker" ];
}
