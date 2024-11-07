{
  description = "Matt's Darwin Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          pkgs.neovim
          pkgs.uv
        ];

      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
          "/Applications/iTerm.app"
          "/Applications/Brave Browser.app"
          "/Applications/Visual Studio Code.app"
          "/Applications/Ableton Live 12 Suite.app"
        ];
        # column view by default in Finder
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
      };

      homebrew = {
        enable = true;
        brews = [
          "asdf"
          "bat"
          "bat-extras"
          "chezmoi"
          "clang-format"
          "cmake"
          "colima"
          "criterion"
          "docker"
          "docker-compose"
          "doxygen"
          "dust"
          "fd"
          "ffmpeg"
          "fzf"
          "gh"
          "graphviz"
          "hugo"
          "igraph"
          "imagemagick"
          "jq"
          "kubernetes-cli"
          "lazygit"
          "mas"
          "neovim"
          "ninja"
          "pkg-config"
          "postgresql"
          "qpdf"
          "raylib"
          "ripgrep"
          "sox"
          "spotify_player"
          "spotifyd"
          "starship"
          "tmux"
          "tree"
          "yq"
          "zoxide"
        ];
        casks = [
        ];

        # example Mac App Store application installation
        # masApps = [
          # "Yoink" = 457622435
        # ];

        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mbp" = nix-darwin.lib.darwinSystem {
      modules = [ configuration
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "hosack";
            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."mbp".pkgs;
  };
}

