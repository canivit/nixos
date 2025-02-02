{ vimPlugins, wrapLua, ... }:
{
  plugins = with vimPlugins; [
    comment-nvim
  ];
  rc = wrapLua ./comment.lua;
}
