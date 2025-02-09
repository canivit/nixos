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
    {
      self,
      nixpkgs,
      nixpkgs-master,
      home-manager,
      skindle,
      flake-utils,
      ...
    }:
    let
      myOverlay = import ./overlay {
        flakes = {
          inherit skindle;
        };
      };

      makeMasterOverlay =
        system:
        (final: prev: {
          master = import nixpkgs-master {
            inherit system;
            config.allowUnfree = true;
          };
        });
    in
    {
      nixosConfigurations =
        let
          makeNixosConfig =
            cfg: system:
            nixpkgs.lib.nixosSystem {
              inherit system;

              modules = [
                {
                  nixpkgs.config.allowUnfree = true;
                  nixpkgs.overlays = [
                    (makeMasterOverlay system)
                    myOverlay
                  ];
                }

                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                }

                {
                  home-manager.sharedModules = [
                    (import ./home-modules)
                  ];
                }

                ./modules
                cfg
              ];
            };
        in
        import ./nixos-configs { inherit makeNixosConfig; };

      homeConfigurations =
        let
          makeHomeConfig =
            cfg: system:
            home-manager.lib.homeManagerConfiguration {
              pkgs = import nixpkgs {
                system = "x86_64-linux";
                overlays = [
                  myOverlay
                  (makeMasterOverlay system)
                ];
                config.allowUnfree = true;
              };
              modules = [
                (import ./home-modules)
                cfg
              ];
            };
        in
        import ./home-configs { inherit makeHomeConfig; };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
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

      }
    );

  nixConfig = {
    extra-substituters = [ "https://canivit.cachix.org" ];

    extra-trusted-public-keys = [
      "canivit.cachix.org-1:oqZfaVHqqURB1CjMm5ZFUt/oYI1LvIpFp1VSG1U9tG0="
    ];
  };
}
