{
  description = "Can's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    # use unstable channel for some packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }: 
  let
    system = "x86_64-linux";

    overlay-unstable = final: prev: {
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
  in {
    nixosConfigurations.uranus = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [ overlay-unstable ];
        }

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
        }

        ./hosts/uranus
      ];
    };
  };
}
