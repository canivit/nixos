{
  pkgs,
  masterPkgs,
  home-manager,
  flakes,
}:
let
  makeMasterOverlay =
    system:
    (final: prev: {
      master = import masterPkgs {
        inherit system;
        config.allowUnfree = true;
      };
    });

  makeMyOverlay =
    system:
    import ./overlay {
      inherit flakes;
    };

  makeNixosConfig =
    name: system:
    let
      masterOverlay = makeMasterOverlay system;
      myOverlay = makeMyOverlay system;
    in
    pkgs.lib.nixosSystem {
      inherit system;

      modules = [
        {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [
            masterOverlay
            myOverlay
          ];
        }

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }

        ./modules
        ./hosts/${name}
      ];
    };

  makeNixosConfigs =
    hosts:
    builtins.listToAttrs (
      map (host: {
        name = host.name;
        value = makeNixosConfig host.name host.system;
      }) hosts
    );
in
makeNixosConfigs
