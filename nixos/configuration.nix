{ config, pkgs, ... }:

let
  vimRC = builtins.readFile ./config/init.vim;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/tower.nix
    ];

  hardware = {
    pulseaudio.enable = true;
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        pkgs.amdvlk
        pkgs.rocm-opencl-icd
      ];
    };
  };

  time.timeZone = "Europe/London";

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "multivac";
    wireless.enable = true; 
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
  };

  environment = {
    systemPackages = with pkgs; [
      curl
      ctags
      firefox
      git
      vim
      nodejs
      python
      python3
      wget
      spotify
      ack
      oh-my-zsh
      fzf
      fzf-zsh
      zsh-completions
      nix-zsh-completions
      (neovim.override {
        configure = {
          # viAlias = true;
          # vimAlias = true;
          packages.myPackage = with pkgs.vimPlugins; {
            start = [
              neovim-sensible
              fugitive
              surround
              tagbar
              nerdtree
              nerdcommenter
              supertab
              easy-align
              vim-closetag
              vim-abolish
              vim-addon-nix
              indentLine
              fzf
              coc-fzf
              colorizer
              vim-grepper
              deoplete-nvim
              coc-nvim
              coc-css
              coc-html
              coc-tsserver
              rust-vim
            ];

            opt = [
              onedark-vim
            ];
          };
          customRC = vimRC;
        };
      })
    ];

    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };

  # Enable sound.
  sound.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alexandra = {
    isNormalUser = true;
    home = "/home/alexandra";
    description = "Alexandra Deas";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # Permit non-free packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "aws"
          "colorize"
          "command-not-found"
          "common-aliases"
          "docker"
          "git"
          "git-extras"
          "gitfast"
          "git-flow"
          "github"
          "gitignore"
          "kubectl"
          "node"
          "npm"
          "yarn"
        ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}


