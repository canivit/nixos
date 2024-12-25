{
  description = "Can's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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

          makeNixosConfigs = import ./system.nix {
            pkgs = nixpkgs;
            masterPkgs = nixpkgs-master;
            inherit home-manager;
            inherit flakes;
          };
        in
        makeNixosConfigs [
          { name = "p1g5"; system = "x86_64-linux"; }
          { name = "builder1"; system = "x86_64-linux"; }
        ];
    }
    //
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.default = pkgs.mkShell {
        name = "nixos-config";
        buildInputs = with pkgs; [
          nixfmt-rfc-style
          terraform
        ];
      };

      formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

    });

  nixConfig = {
    extra-substituters = [ "https://canivit.cachix.org" ];

    extra-trusted-public-keys = [
      "canivit.cachix.org-1:oqZfaVHqqURB1CjMm5ZFUt/oYI1LvIpFp1VSG1U9tG0="
    ];
  };
}

