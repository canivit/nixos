{ pkgs, vimPlugins, wrapLua, ... }:
{
  plugins = [ vimPlugins.nvim-lspconfig ];
  packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
  ];
  rc = wrapLua ./lsp.lua;
}
