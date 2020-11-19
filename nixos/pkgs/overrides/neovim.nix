{ neovim, vimPlugins, ... }:

let
  customRC = builtins.readFile ../init.vim;
in
  neovim.override {
    vimAlias = true;
    configure = {
      plug.plugins = with vimPlugins; [
        neovim-sensible
        fugitive
        surround
        tagbar
        nerdtree
        nerdcommenter
        supertab
        easy-align
        closetag
        abolish
        indentLine
        fzf
        colorizer
        grepper
        # Language Support
        deoplete-nvim
        coc-nvim
        coc-css
        coc-html
        coc-tsserver
        rust-vim
      ];
    };
    customRC = customRC;
  }

