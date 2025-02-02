{ vimPlugins, wrapLua, ... }:
{
  plugins = [ vimPlugins.nvim-treesitter.withAllGrammars ];
  rc = wrapLua ./treesitter.lua;
}
