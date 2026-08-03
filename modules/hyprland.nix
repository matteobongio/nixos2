{inputs, self, ...}: {
  flake.nixosModules.hyprland = {pkgs, ...}:

    let
      # Helper function to generate standardized graphical user services
      mkGraphicalService = { name, desc, exec, restart ? "on-failure" }: {
        name = name;
        value = {
          description = desc;
          partOf = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
          wantedBy = [ "graphical-session.target" ];
          serviceConfig = {
            ExecStart = exec;
            Restart = restart;
          };
        };
      };
    in
  {
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
    services.udisks2.enable = true; #dolphin

    security.polkit.enable = true;
    systemd.user.targets.graphical-session.wants = [ "hyprpolkitagent.service" ];

    # autostart
    systemd.user.services = builtins.listToAttrs [
      (mkGraphicalService {
       name = "swaync";
       desc = "Sway Notification Center";
       exec = "${pkgs.swaynotificationcenter}/bin/swaync";
       })
    (mkGraphicalService {
     name = "waybar";
     desc = "Waybar Status Bar";
     exec = "${pkgs.waybar}/bin/waybar";
     })
    (mkGraphicalService {
     name = "nm-applet";
     desc = "";
     exec = "${pkgs.networkmanagerapplet}/bin/nm-applet";
     })
    (mkGraphicalService {
     name = "awww";
     desc = "";
     exec = "${pkgs.awww}/bin/awww-daemon";
     })
    ];
  };
}
