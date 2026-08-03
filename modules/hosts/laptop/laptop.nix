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
  flake.nixosModules.laptopConfig = import ../../../configuration.nix;
  flake.nixosModules.laptopDisko = import ../../../disko.nix;
  flake.nixosModules.laptopHardware = import ../../../hardware-configuration.nix;
}

