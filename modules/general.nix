{...}: {
  flake.nixosModules.general = {pkgs, ...} : {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    programs.firefox.enable = true;



    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;
    networking.networkmanager.plugins = with pkgs; [
      networkmanager-openvpn
    ];

    programs.localsend.enable = true;

    programs.direnv = {
      enable = true;
      enableFishIntegration = true;
      nix-direnv.enable = true;
    };

    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
      font-awesome
    ];
    services.syncthing = {
      enable = true;
      user = "matteob";
      dataDir = "/home/matteob/Documents"; # Default folder for new synced folders
        configDir = "/home/matteob/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };
}
