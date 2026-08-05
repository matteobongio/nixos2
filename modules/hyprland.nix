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
    programs.regreet.enable = true;
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
      self.packages."x86_64-linux".myWofi
      pwvucontrol
      brightnessctl
      kdePackages.gwenview

      # gnome-system-monitor
      # kdePackages.kimageformats
      # hypridle
      # hyprshot
      # eww

      #theming
      kdePackages.breeze
      kdePackages.breeze-gtk
      qt6Packages.qt6ct
      libsForQt5.qt5ct
      libsForQt5.qt5.qtwayland
      kdePackages.qtwayland
      themechanger
      nwg-look

      #keychain
      gnome-keyring
      libsecret
      seahorse
    ];


    programs.hyprlock.enable = false; #todo

    services.gvfs.enable = true; #enable mtp
    services.udisks2.enable = true; #dolphin
    programs.dconf.enable = true;
    environment.pathsToLink = [ "/share/color-schemes" ];

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
     desc = "Network manager applet";
     exec = "${pkgs.networkmanagerapplet}/bin/nm-applet";
     })
    (mkGraphicalService {
     name = "awww";
     desc = "Wallpaper daemon";
     exec = "${pkgs.awww}/bin/awww-daemon";
     })
    (mkGraphicalService {
     name = "pcloud";
     desc = "";
     exec = "${pkgs.pcloud}/bin/pcloud";
     })
    (mkGraphicalService {
     name = "protonmail-bridge";
     desc = "";
     exec = "${pkgs.protonmail-bridge-gui}/bin/protonmail-bridge-gui --no-window";
     })
    ];

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
  };

  flake.packages.x86_64-linux.myWofi =
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
      };
    in
    inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.wofi;
      flags = {
        "--conf" = ../config/wofi/config;
        "--style" = ../config/wofi/style.css;
      };
    };

}
