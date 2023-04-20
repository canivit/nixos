{ pkgs, vimPlugins, wrapLua, ... }:
{
  plugins = with vimPlugins; [
    nvim-lspconfig
    null-ls-nvim
    luasnip
    cmp_luasnip
    nvim-cmp
    cmp-nvim-lsp
    nvim-code-action-menu
    pkgs.unstable.vimPlugins.rust-tools-nvim
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

    # JSON
    nodePackages.vscode-json-languageserver

    # TypeScript
    pkgs.unstable.nodePackages.typescript-language-server
    nodePackages.prettier

    # Markdown
    marksman
  ];

  rc = wrapLua ./lsp.lua;
}
