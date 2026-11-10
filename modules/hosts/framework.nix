{inputs, self, lib, ...}: {
  flake.nixosConfigurations.framework = inputs.nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };
    modules = [
      self.nixosModules.general
      self.nixosModules.hyprland
      self.nixosModules.matteob
      self.nixosModules.stdPkgs
      self.nixosModules.dolphin
      self.nixosModules.neovim
      self.nixosModules.games
      self.nixosModules.terminal
      self.nixosModules.docker
      self.nixosModules.tudelft
      inputs.disko.nixosModules.disko
      inputs.nix-index-database.nixosModules.default
      { programs.nix-index-database.comma.enable = true; }
      self.nixosModules.laptopDisko
    ];

  };
  flake.nixosModules.frameworkConfig = { config, lib, pkgs, ... }: {

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  powerManagement.enable = true;

  networking.hostName = "framework"; # Define your hostname.

  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  #bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "26.05"; # DO NOT TOUCH UNDER ANY CIRCUMSTANCES
};
