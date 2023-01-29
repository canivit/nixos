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
    # Rust
    cargo
    rustc
    rust-analyzer
    rustfmt

    # Nix
    rnix-lsp
  ];

  rc = wrapLua ./lsp.lua;
}
