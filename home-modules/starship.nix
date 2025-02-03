{
  lib,
  config,
  ...
}:
let
  cfg = config.myModules.starship;
in
{
  options.myModules.starship.enable = lib.mkEnableOption "starship shell prompt";
  config = lib.mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
          vicmd_symbol = "[λ](bold blue)";
        };
      };
    };
  };
}
