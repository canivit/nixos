{
  description = "Can's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
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
      sops-nix,
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

                sops-nix.nixosModules.sops

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

        setupSopsKey = pkgs.writeShellScriptBin "setup_sops_key" (
          builtins.readFile ./scripts/setup_sops_key.sh
        );
      in
      {
        devShells.default = pkgs.mkShell {
          name = "nixos-config";
          buildInputs = with pkgs; [
            sops
            age
            nixfmt-rfc-style
            terraform
            setupSopsKey
          ];

          env = {
            SOPS_AGE_KEY_FILE = "/var/lib/sops/age/keys.txt";
          };
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
