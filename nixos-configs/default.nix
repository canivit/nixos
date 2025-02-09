{ makeNixosConfig, ... }:
{
  p1g5 = makeNixosConfig ./p1g5 "x86_64-linux";
}
