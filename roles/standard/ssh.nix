{ config, ... }:
let
  home = config.users.users.can.home;
in
{
  home-manager.users.can.programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "${home}/.ssh/github";
        identitiesOnly = true;
      };
    };

    matchBlocks = {
      "github.khoury.northeastern.edu" = {
        hostname = "github.khoury.northeastern.edu";
        identityFile = "${home}/.ssh/github-khoury";
        identitiesOnly = true;
      };
    };

    matchBlocks = {
      "khoury" = {
        hostname = "login.ccs.neu.edu";
        port = 22;
        user = "canivit";
        identityFile = "${home}/.ssh/khoury-server";
        identitiesOnly = true;
      };
    };

    matchBlocks = {
      "warhead" = {
        hostname = "warhead.ccs.neu.edu";
        port = 10001;
        user = "hacker07";
        identityFile = "${home}/.ssh/warhead";
        identitiesOnly = true;
        proxyJump = "khoury";
      };
    };
  };
}
