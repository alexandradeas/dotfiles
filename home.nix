{ config, pkgs, ... }:

let
  tmux-super-fingers = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-super-fingers"; version = "unstable-2023-01-06";
    src = pkgs.fetchFromGitHub {
      owner = "artemave";
      repo = "tmux_super_fingers";
      rev = "2c12044984124e74e21a5a87d00f844083e4bdf7";
      sha256 = "sha256-cPZCV8xk9QpU49/7H8iGhQYK6JwWjviL29eWabuqruc=";
    };
  };
in {
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
    permittedInsecurePackages = [
      "electron-24.8.6"
      "nodejs-16.20.0"
    ];
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alexandra";
  home.homeDirectory = "/home/alexandra";

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    beeper
    claws-mail
		dbeaver
    neovide
    obsidian
    zathura
    sxiv
    spotify
    mpv
		ripgrep
		postman
		_1password
    _1password-gui
    slack
    zoom-us
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/nvim/init.lua".source = ./neovim/init.lua;
    # ".local/share/nvim/ftplugin/dart.vim".source = ./neovim/dart.vim;
    # ".local/share/nvim/ftplugin/make.vim".source = ./neovim/make.vim;
    # ".local/share/nvim/ftplugin/rust.vim".source = ./neovim/rust.vim;
    # ".local/share/nvim/ftplugin/typescript.vim".source = ./neovim/typescript.vim;


    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    envExtra = ''
      alias hmswitch="home-manager switch"
      eval "$(direnv hook zsh)"
    '';
  };
  
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fiosh_greeting # disable greeting
      direnv hook fish | source
    '';

    plugins = with pkgs.fishPlugins; [
      # grc
      # fzf
      # fzf-fish
      # {
      #   name = "replay";
      #   src = pkgs.fetchFromGithub {
      #     owner = "jorgebucaran";
      #     repo = "replay.fish";
      #     rev = "bd8e5b89ec78313538e747f0292fcaf631e87bd2";
      #     sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
      #   };
      # }
    ];
  };

  programs.git = {
    enable = true;
    userName = "Alexandra Deas";
    userEmail = "me@alexandradeas.co.uk";
    extraConfig = {
      init.defaultBranch = "main";
    };
    aliases = {
      pu = "push";
      co =  "checkout";
      cm = "commit";
    };
  };

  programs.neovim = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 100000;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      {
        plugin = catppuccin;
	extraConfig = ''
	  set -g @catpuccin_flavour 'frappe'
	  set -g @catpuccin_window_tabs_enabled on
	  set -g @catpuccin_date_time "%H:%M"
	'';
      }
      {
        plugin = resurrect;
	extraConfig = ''
	  set -g @resurrect-dir '~/.tmux/resurrect-sessions'
	  set -g @resurrect-strategy-vim 'session'
	  set -g @resurrect-strategy-nvim 'session'
	  set -g @resurrect-capture-pane-contents 'on'
	'';
      }
      {
        plugin = continuum;
	extraConfig = ''
	  set -g @continuum-restore 'on'
	  set -g @continuum-boot 'on'
	  set -g @continuum-save-interval '10'
	'';
      }
      {
        plugin = tmux-super-fingers;
	extraConfig = "set -g @super-fingers-key f";
      }
      {
        plugin = better-mouse-mode;
        extraConfig = ''
	  set -g mouse on
	'';
      }
    ];
    extraConfig = ''
      set -g default-terminal "screen-256color"
      set -s escape-time 10
      set -sg repeat-time 600
      set -s focus-events on

      setw -g automatic-rename on
      set -g renumber-windows

      set -g set-titles on

      set -g display-panes-time 

      set -g monitor-activity on
      set -g visual-activity off

      bind C-f command-prompt -p find-session 'switch-client -t %%'

      bind - split-window -v
      bind _ split-window -h

      # movement
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      # resizing
      bind -r H resize-pane -L 10
      bind -r J resize-pane -D 10
      bind -r K resize-pane -U 10
      bind -r L resize-pane -R 10

      # window navigation
      unbind n
      unbind p
      bind -r C-h previous-window
      bind -r C-l next-window
      bind Tab last-window

    '';
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;

  };

  # gtk = {
  #   enable = true;
  #   theme.name = "adw-gtk3";
  #   cursorTheme.name = "Bibata-Modern-Ice";
  #   iconTheme.name = "GruvboxPlus";
  # };

  xdg.mimeApps.defaultApplications = {
    "text/plain"      = [ "neovide.desktop" ];
    "application/pdf" = [ "zathura.desktop" ];
    "image/*"         = [ "sxiv.desktop" ];
    "video/png"       = [ "mpv.desktop" ];
    "video/jpg"       = [ "mpv.desktop" ];
    "video/*"         = [ "mpv.desktop" ];
  };
}
