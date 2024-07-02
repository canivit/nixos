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

    podman = {
      enable = true;
    };

    # virtualbox.host.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    win-virtio
    spice-gtk
    vagrant
    distrobox
    xorg.xhost
  ];

  users.users.can.extraGroups = [ "libvirtd" "docker" ];
}
