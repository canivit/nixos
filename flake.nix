{
  description = "Can's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    # use unstable channel for some packages
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    skindle.url = "github:canivit/skindle";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, flake-utils, skindle, ... }:
    let
      mkUnstableOverlay = system:
        final: prev: {
          unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };

      mkMyOverlay = system:
        import ./overlay {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          inherit skindle;
        };

      mkSystemConfig = host: system:
        let
          unstableOverlay = mkUnstableOverlay system;
          myOverlay = mkMyOverlay system;
        in
        {
          ${host} = nixpkgs.lib.nixosSystem {
            inherit system;

            modules = [
              {
                nixpkgs.config.allowUnfree = true;
                nixpkgs.overlays = [ unstableOverlay myOverlay ];
              }

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
              }

              ./hosts/${host}
            ];
          };
        };
    in
    {
      nixosConfigurations = { }
      // mkSystemConfig "uranus" "x86_64-linux"
      // mkSystemConfig "darterpro" "x86_64-linux"
      // mkSystemConfig "p1g5" "x86_64-linux";

    } //
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        nixboot = pkgs.writeShellScriptBin "nixboot" ''
          sudo nixos-rebuild boot --flake .
        '';
        nixswitch = pkgs.writeShellScriptBin "nixswitch" ''
          sudo nixos-rebuild switch --flake .
        '';
        nixupdate = pkgs.writeShellScriptBin "nixupdate" ''
          nix flake update
        '';
        nixupgrade = pkgs.writeShellScriptBin "nixupgrade" ''
          nix flake update && sudo nixos-rebuild switch --flake .
        '';
      in
      {
        formatter = pkgs.nixpkgs-fmt;
        devShell = pkgs.mkShell {
          name = "nixos-config";
          buildInputs = with pkgs; [
            nixpkgs-fmt
          ] ++ [
            nixboot
            nixswitch
            nixupdate
            nixupgrade
          ];
        };
      });
}
