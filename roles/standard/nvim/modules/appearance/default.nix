{ vimPlugins, wrapLua, ... }:
{
  plugins = with vimPlugins; [
    onedark-nvim
    lualine-nvim
    nvim-web-devicons
  ];
  rc = wrapLua ./appearance.lua;
}
