{ config, pkgs, ... }: 

{
  home-manager.darwinModules.home-manager {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.isacskoglund = {
      # Home Manager needs a bit of information about you and the paths it should
      # manage.
      home.username = "isacskoglund";
      home.homeDirectory = "/Users/isacskoglund";

      # This value determines the Home Manager release that your configuration is
      # compatible with. This helps avoid breakage when a new Home Manager release
      # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
      # want to update the value, then make sure to first check the Home Manager
      # release notes.
      home.stateVersion = "24.05"; # Please read the comment before changing.

      # The home.packages option allows you to install Nix packages into your
      # environment.
      home.packages = with pkgs; [
        pure-prompt
        gh
        jq
        lf
      ];

      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
      home.file = {
        ".fzf".source = ../../.fzf;
        ".config/nvim".source = ../nvim;
        ".config/alacritty".source = ../alacritty;
        ".config/karabiner".source = ../karabiner;
      };

      home.sessionVariables = {
        EDITOR = "nvim";
        SSH_AUTH_SOCK = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;

      programs.git = {
        enable = true;
        userName = "Isac Skoglund";
        userEmail = "isacskoglund02@gmail.com";
        extraConfig = {
          credential = {
            # Allow git to use the credentials from gh cli when pushing to github
            helper = "!gh auth git-credential";
          };
        };
        aliases = {
          st = "status";
          co = "checkout";
          br = "branch";
          cm = "commit -m";
          df = "diff";
          lg = "log --oneline --graph --decorate";
          lga = "log --oneline --graph --decorate --all";
          lga1 = "log --oneline --graph --decorate --all -n 1";
          lga2 = "log --oneline --graph --decorate --all -n 2";
        };
      };

      # Setup zsh
      programs.zsh.enable = true;
      programs.zsh.history = {
        save = 10000;
        size = 10000;
        path = "${config.home.homeDirectory}/.cache/zsh/history";
      };
      programs.zsh = {
        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;
        shellAliases = {
          tf = "terraform";
          t = "tmux";
          ta = "tmux new-session -A -s default";
          # TODO: Avoid hardcoding the path to the flake, use a variable in ~/.zshenv or similar
          switch = "nix run nix-darwin -- switch --flake ~/Repos/dotfiles/.config/nix";
        };
        initContent = builtins.readFile ../../.zshrc.extra.sh;
      };

      # Configure fzf
      programs.fzf = {
        enable = true;
      };

      programs.neovim = {
        enable = true;

        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

        extraPackages = with pkgs; [
          gopls
          rust-analyzer
          typescript-language-server
          pyright
          lua-language-server
          nil
          ripgrep
          fzf
        ];

        plugins = with pkgs.vimPlugins; [
          nvim-lspconfig
          telescope-nvim
          catppuccin-nvim
          lualine-nvim
          nvim-treesitter.withAllGrammars
          gitsigns-nvim
          nvim-tree-lua
          nvim-web-devicons
          nvim-lspconfig
          nvim-cmp
          cmp-path
          cmp-nvim-lsp
          vim-tmux-navigator
          neogit
        ];
      };

      programs.tmux = {
        enable = true;

        plugins = with pkgs.tmuxPlugins; [
          sensible
          yank
          vim-tmux-navigator 
          catppuccin
        ];

        extraConfig = (builtins.readFile ../tmux/tmux.conf) + "set -g default-command ${pkgs.zsh}/bin/zsh\n";
      };
    };
  }
}

