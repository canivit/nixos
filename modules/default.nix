{ ... }:
{
  imports = [
    ./hidpi.nix
    ./guiFileManager
    ./ios.nix
    ./browser
    ./cache.nix
    ./direnv.nix
    ./pipewire.nix
    ./networking.nix
    ./auto-upgrade.nix
    ./jellyfin.nix
    ./sops.nix
  ];
}
