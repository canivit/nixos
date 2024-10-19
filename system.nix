{ pkgs, masterPkgs, home-manager, flakes }:
let
  makeMasterOverlay = system:
    (final: prev: {
      master = import masterPkgs {
        inherit system;
        config.allowUnfree = true;
      };
    });

  makeMyOverlay = system:
    import ./overlay {
      inherit flakes;
    };
in
host: system:
let
  masterOverlay = makeMasterOverlay system;
  myOverlay = makeMyOverlay system;
in
{
  ${host} = pkgs.lib.nixosSystem {
    inherit system;

    modules = [
      {
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [ masterOverlay myOverlay ];
      }

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
      }

      ./modules
      ./hosts/${host}
    ];
  };
}
