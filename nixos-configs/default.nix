{ makeNixosConfig, ... }:
{
  p1g5 = makeNixosConfig ./p1g5 "x86_64-linux";
  iso = makeNixosConfig ./iso "x86_64-linux";
  yellowjacket = makeNixosConfig ./yellowjacket "x86_64-linux";
}
