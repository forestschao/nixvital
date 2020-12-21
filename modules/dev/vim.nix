{ config, pkgs, lib, ... }:

{
  environment.variables = { EDITOR = "vim"; };

  environment.systemPackages = with pkgs; [
    (neovim.override {
      vimAlias = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [ vim-lastplace vim-nix
                    vim-airline vim-airline-themes
                    vim-colors-solarized
                    vim-autoformat
                  ];
          opt = [];
        };
        customRC = ''
          " Use Vim settings, rather than Vi Settings
          set nocompatible

          " General settings
          set backspace=indent,eol,start
          set ruler
          set number
          set showcmd
          set tabstop=2
          set shiftwidth=2
          set expandtab
          set clipboard=unnamedplus
          set incsearch
          set hlsearch
          set ic
          set history=200
          set mouse=a

          " Turnoff the highlight
          nnoremap \\ :noh<return>

          " Solarized-dark colorscheme
          let g:solarized_termcolors=256
          set t_Co=256
          syntax enable
          set background=dark
          colorscheme solarized
          
          " Use the solarized theme for the Airline status bar
          let g:airline_theme='solarized'
        '';
      };
    }
  )];
}
