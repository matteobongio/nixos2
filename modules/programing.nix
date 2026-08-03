{...}: {
  flake.nixosModules.programing = {pkgs, ...} : {
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
    ];
  };
}
