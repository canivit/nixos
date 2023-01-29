{ pkgs, vimPlugins, wrapLua, ... }:
{
  plugins = [ vimPlugins.nvim-lspconfig ];
  packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    rustfmt
  ];
  rc = wrapLua ./lsp.lua;
}
