{inputs, self, ...}: {
  flake.nixosModules.hyprland = {pkgs, ...}: {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
    programs.uwsm.enable = true;
    environment.systemPackages = with pkgs; [
      hyprpolkitagent
      libsForQt5.qt5.qtwayland
      kdePackages.qtwayland


      waybar
      awww
      waypaper
      papirus-icon-theme
      notify-desktop
      swaynotificationcenter
      hyprshot
      pwvucontrol
      brightnessctl
      networkmanagerapplet
      wofi
    ];
    security.polkit.enable = true;
  };
}
