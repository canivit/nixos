{ pkgs, ... }:
let
  modules = [
    ./main
    ./telescope
    ./appearance
    ./treesitter
    ./harpoon
    ./lsp
  ];

  wrapLua = p: "lua <<EOF\n${builtins.readFile p}\nEOF";

in
map
  (m: pkgs.callPackage m {
    inherit wrapLua;
  })
  modules

