{ pkgs }:
let
  directory = pkgs.fetchFromGitHub {
    repo = "background";
    owner = "canivit";
    rev = "1fca5cab3a655874b2278652140065ba1809fc5a";
    sha256 = "0v5h260lxasrjg7hli89wldq8la7nfllvqd1skqxcmq5g0rlfk40";
  };
in
  {
    background = "${directory}/background.png";
    login = "${directory}/login.png";
  }
