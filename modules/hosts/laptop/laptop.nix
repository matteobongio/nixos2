{inputs, self, ...}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.general
      self.nixosModules.hyprland
      self.nixosModules.matteob
      self.nixosModules.stdPkgs
      self.nixosModules.neovim
      self.nixosModules.programing
      self.nixosModules.laptopConfig
      self.nixosModules.laptopHardware
      inputs.disko.nixosModules.disko
      self.nixosModules.laptopDisko
    ];

  };
  flake.nixosModules.laptopConfig = import ./_old/configuration.nix;
  flake.nixosModules.laptopDisko = import ./_old/disko.nix;
  flake.nixosModules.laptopHardware = import ./_old/hardware-configuration.nix;
}

