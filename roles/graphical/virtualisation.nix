{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull ];
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

    virtualbox.host.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    win-virtio
    spice-gtk
    vagrant
  ];

  users.users.can.extraGroups = [ "libvirtd" "docker" ];
}
