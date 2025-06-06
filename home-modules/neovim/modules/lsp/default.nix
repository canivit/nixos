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
    pkgs.master.vimPlugins.rust-tools-nvim
  ];

  packages = with pkgs; [
    # Rust
    cargo
    rustc
    rust-analyzer
    rustfmt

    # Nix
    nixd
    nixfmt-rfc-style

    # Ruby
    ruby_3_1
    rubyPackages_3_1.solargraph
    rubyPackages_3_1.rubocop

    # Lua
    lua-language-server

    # JSON
    nodePackages.vscode-json-languageserver

    # TypeScript
    pkgs.master.nodePackages.typescript-language-server
    nodePackages.prettier

    # Markdown
    marksman

    # C
    clang

    # Python
    # (python3.withPackages (ps: [ ps.python-lsp-server ]))
  ];

  rc = wrapLua ./lsp.lua;
}
