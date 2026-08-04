{...}: {
  flake.nixosModules.terminal = {pkgs, ...} : {
    programs.fish.enable = true;
    environment.systemPackages = with pkgs; [
      kitty
      fastfetch
      eza
      fd
      zoxide
      bat
      yazi
      starship
      gh
      lazygit
      chezmoi
      yadm
      git
      delta
      jq
      just
      rclone
      rsync
      rhash
      television

      gdb
      gdbgui
      valgrind

      # godot_4
      # jetbrains.clion
      # jetbrains.idea

      alejandra
      ghc #haskell
      rustup
      go
      c3c
    ];
  };
  flake.nixosModules.docker = {pkgs, ...} : {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    environment.systemPackages = with pkgs; [
      dive # look into docker image layers
      podman-tui # status of containers in the terminal
      docker-compose # start group of containers for dev
    ];
    # virtualisation.docker.rootless = {
    #   enable = true;
    #   setSocketVariable = true;
    # };
  };
  flake.nixosModules.neovim = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
    };
    # programs.nix-ld.enable = true;
    # programs.nix-ld.libraries = with pkgs; [stdenv.cc.cc];
    environment.systemPackages = with pkgs; [
      tree-sitter
      neovide
      ripgrep
      wget
      git
      gcc
      unzip
      wl-clipboard
      xxd
      fzf
      clang-tools
      gnumake
      nodejs #markdown preview

      #lsp
      nil
      lua-language-server
      haskell-language-server
      tinymist
    ];
  };
}
