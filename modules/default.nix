{ ... }: {
  imports = [
    ./hidpi.nix
    ./guiFileManager
    ./ios.nix
    ./browser
    ./cache.nix
    ./direnv.nix
    ./pipewire.nix
  ];
}
