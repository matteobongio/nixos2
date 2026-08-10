{inputs, self, ...}: {
  flake.nixosModules.stdPkgs = {pkgs, ...} : {
    environment.systemPackages = with pkgs; [
      thunderbird
      joplin-desktop
      appflowy
      protonmail-bridge-gui
      proton-vpn
      calibre
      discord
      texliveBasic
      yacreader
      qbittorrent
      mpv
      bottles
      filezilla
      rustdesk-flutter
      popsicle

      pcloud
      pomodoro-gtk
      #distrobox
      signal-desktop
      planify
      #libheif
      qdirstat
      krita
      gimp
      pinta
      obsidian
      #wonderdraft
      nicotine-plus
      strawberry
      self.packages."x86_64-linux".fixedHandbrake
      tor-browser
      # media-downloader
      # octaveFull
      # muse
      # zip
      wifi-qr
      subsurface
      kdePackages.okular
      kdePackages.ark
      kdePackages.gwenview
      kdePackages.partitionmanager

      typst
      onlyoffice-desktopeditors
      slack
      deskflow
    ];
  };



  flake.packages."x86_64-linux".fixedHandbrake =
    let
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
      };
    in
      (pkgs.handbrake.overrideAttrs(old: {
        nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
          pkgs.autoAddDriverRunpath
        ];
      }));

  flake.nixosModules.dolphin = {pkgs, ...} : {
    environment.systemPackages = with pkgs; [
      kdePackages.dolphin

      kdePackages.kio
      kdePackages.kio-fuse
      kdePackages.kio-admin
      kdePackages.kio-gdrive
      kdePackages.kio-extras
      kdePackages.kservice
      kdePackages.kdegraphics-thumbnailers
      kdePackages.kdf
      kdePackages.qtwayland
      kdePackages.plasma-integration
      kdePackages.qtsvg
      shared-mime-info
      kdePackages.qqc2-desktop-style
    ];

    environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  };
}
