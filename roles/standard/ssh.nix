{ ... }:
{
  home-manager.users.can.programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "/home/can/.ssh/github";
        identitiesOnly = true;
      };
    };
  };
}
