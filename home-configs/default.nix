{ makeHomeConfig, ... }:
{
  workCloud = makeHomeConfig ./work-cloud.nix "x86_64-linux";
}
