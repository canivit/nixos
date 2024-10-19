{
  description = "Can's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    skindle.url = "github:canivit/skindle";
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-master
    , home-manager
    , skindle
    , flake-utils
    , ...
    }:
    {
      nixosConfigurations =
        let
          flakes = {
            inherit skindle;
          };

          makeSystemConfig = import ./system.nix {
            pkgs = nixpkgs;
            masterPkgs = nixpkgs-master;
            inherit home-manager;
            inherit flakes;
          };
        in
        makeSystemConfig "p1g5" "x86_64-linux";
    }
    //
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      formatter = pkgs.nixpkgs-fmt;
      devShells.default = pkgs.mkShell {
        name = "nixos-config";
        buildInputs = with pkgs; [
          nixpkgs-fmt
        ];
      };

    });
}

