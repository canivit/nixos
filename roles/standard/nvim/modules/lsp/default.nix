{ pkgs, vimPlugins, wrapLua, ... }:
{
  plugins = with vimPlugins; [ 
    nvim-lspconfig
    luasnip
    cmp_luasnip
    nvim-cmp
    cmp-nvim-lsp
    nvim-code-action-menu
  ];

  packages = with pkgs; [
    # Rust
    cargo
    rustc
    rust-analyzer
    rustfmt

    # Nix
    rnix-lsp

    # Ruby
    ruby_3_1
    rubyPackages_3_1.solargraph
    rubyPackages_3_1.rubocop

    # Lua
    sumneko-lua-language-server
  ];

  rc = wrapLua ./lsp.lua;
}
