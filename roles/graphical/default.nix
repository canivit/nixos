args@{ hidpi ? false, ... }:
{
  imports = [
    (
      import ./programs (
        args // { inherit hidpi; }
      )
    )
    (
      import ./x (
        args // { inherit hidpi; }
      )
    )
    #./searx
    ./virtualisation.nix
    ./fonts.nix
    (
      import ./gtk.nix (
        args // { inherit hidpi; }
      )
    )
    ./sound.nix
    ./opengl.nix
  ];
}
