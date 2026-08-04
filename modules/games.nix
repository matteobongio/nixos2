{...}: {
  flake.nixosModules.games = {pkgs, ...} : {
    environment.systemPackages = with pkgs; [
      mangohud
      protonup-ng
      prismlauncher
      limo
      #lutris
      heroic
      # melonds
      # gzdoom
      # wine
      # winetricks
    ];

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      protontricks.enable = true;
    };
    programs.gamescope.enable = true;
    programs.gamemode.enable = true;



    #NOTE: EA game launcher fix:
    # for var in $(printenv | awk -F= 'length($2) > 2000 {print $1}'); do export $var=$(echo ${!var} | rev | cut -c 1-2000 | rev); done ; %command%

    #mirrors edge catalyst
    networking.hosts = {
      "127.0.0.1" = ["winter15.gosredirector.ea.com"];
    };

  };
}
