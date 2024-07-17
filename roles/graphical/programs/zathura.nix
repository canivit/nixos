{ ... }:
{
  home-manager.users.can.programs.zathura = {
    enable = true;
    options = {
      font = "Sans Regular 10";
      selection-clipboard = "clipboard";
    };
  };
}
