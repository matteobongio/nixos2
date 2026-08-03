{...}: {
  flake.nixosModules.general = {pkgs, ...} : {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    programs.firefox.enable = true;
    programs.fish.enable = true;



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
  };
}
