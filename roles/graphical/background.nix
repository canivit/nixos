{ pkgs }:
let
  directory = pkgs.fetchFromGitHub {
    repo = "background";
    owner = "canivit";
    rev = "dc2ce3ef4060e4df2bb5607c7af2c0e9b402ffc7";
    sha256 = "sha256-OLIlB1QqiI04NpdFpaaJY8P94y9CbO571zJYSYWsYug=";
  };
in
  {
    background = "${directory}/background.png";
    background_fhd = "${directory}/background_fhd.png";
    login = "${directory}/login.png";
  }
