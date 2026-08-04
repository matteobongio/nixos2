{...}: {
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
      handbrake
      tor-browser
      # media-downloader
      # octaveFull
      # muse
      # zip
      wifi-qr
      subsurface
      kdePackages.dolphin
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
}
