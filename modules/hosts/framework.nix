{
  inputs,
  self,
  lib,
  ...
}: {
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
      self.nixosModules.frameworkConfig
      self.nixosModules.frameworkHardware
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
      {programs.nix-index-database.comma.enable = true;}
      self.nixosModules.laptopDisko
    ];
  };
  flake.nixosModules.framworkConfig = {config, lib, pkgs, ...} : {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.initrd.systemd.enable = true;
    powerManagement.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;
    networking.hostName = "framework"; # Define your hostname.

    time.timeZone = "Europe/Amsterdam";

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    system.stateVersion = "26.05"; # DO NOT TOUCH UNDER ANY CIRCUMSTANCES
  };

  flake.nixosModules.frameworkHardware = { pkgs, ... }: {
      boot.kernelPackages = pkgs.linuxPackages_latest;

      boot.initrd.availableKernelModules = [
        "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod"
      ];
      boot.kernelModules = [ "kvm-intel" ];

      hardware.cpu.intel.updateMicrocode = true;
      hardware.enableRedistributableFirmware = true;

      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [ intel-media-driver vpl-gpu-rt ];
      };
      services.xserver.videoDrivers = [ "modesetting" ];

      services.fwupd.enable = true;
    };
}
