{ pkgs, vimPlugins, wrapLua, ... }:
{
  plugins = with vimPlugins; [ 
    nvim-lspconfig
    luasnip
    cmp_luasnip
    nvim-cmp
    cmp-nvim-lsp
  ];

  packages = with pkgs; [
    cargo
    rustc
    rust-analyzer
    rustfmt
  ];

  rc = wrapLua ./lsp.lua;
}
