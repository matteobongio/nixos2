{inputs, self, ...}: {
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
    ];
  };
}
