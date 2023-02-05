{ pkgs, lib, ... }:
let
  modules = pkgs.callPackage ./modules {};
  moduleDefaults = { plugins = []; packages = []; rc = ""; };
  lstToString = lib.lists.foldr (a: b: a + "\n" + b) "";
  getModulePlugins = module: (moduleDefaults // module).plugins;
  getModulePackages = module: (moduleDefaults // module).packages;
  getModuleRC = module: (moduleDefaults // module).rc;
  modulesPlugins = lib.lists.concatMap getModulePlugins modules;
  modulesPackages = lib.lists.concatMap getModulePackages modules;
  modulesRC = lstToString (map getModuleRC modules);
in
{
  home-manager.users.can.programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = modulesPlugins;
    extraPackages = modulesPackages;
    extraConfig = modulesRC;
  };

  home-manager.users.can.home.sessionVariables.EDITOR = "nvim";
}
