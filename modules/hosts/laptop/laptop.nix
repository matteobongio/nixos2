{inputs, self, ...}: {
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.unfree
      inputs.disko.nixosModules.disko
      self.nixosModules.laptopConfig
      self.nixosModules.laptopDisko
      self.nixosModules.laptopHardware
    ];

  };
  flake.nixosModules.laptopConfig = import ./_old/configuration.nix;
  flake.nixosModules.laptopDisko = import ./_old/disko.nix;
  flake.nixosModules.laptopHardware = import ./_old/hardware-configuration.nix;
}

