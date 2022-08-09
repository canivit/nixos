{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    xclip
  ];

  home-manager.users.can.programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [ 
      lightline-vim
      onedark-vim
      vim-gitgutter
      vim-nix
      vim-devicons
      nerdtree
      vim-nerdtree-syntax-highlight
      nerdtree-git-plugin
      vim-fugitive
    ];
    extraConfig = lib.mkBefore ''
      set mouse=a
      set path+=**
      set wildmenu
      set incsearch
      set hidden
      set nobackup
      set noswapfile
      set t_Co=256
      set number
      set clipboard=unnamedplus
      set cursorline
      set mouse=a
      syntax enable
      filetype on
      filetype plugin on
      let g:rehash256 = 1
      set shiftwidth=2
      set tabstop=2
      set expandtab
      set autoindent
      set smartindent
      set termguicolors
      set background=dark
      let g:onedark_terminal_italics = 1
      colorscheme onedark
      let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }
      nnoremap <C-n> :NERDTreeToggle<CR>
      nnoremap <C-f> :NERDTreeFind<CR>
    '';
  };

  home-manager.users.can.home.sessionVariables.EDITOR = "nvim";
}
