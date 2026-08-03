{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs: 
   inputs.flake-parts.lib.mkFlake { inherit inputs; }
      (inputs.import-tree ./modules);
  #{
  #  nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
  #    modules = [
  #      disko.nixosModules.disko
  #      ./disko.nix
  #      ./configuration.nix
  #      ./hardware-configuration.nix
  #      { nixpkgs.config.allowUnfree = true; }
  #    ];
  #  };
  #};
}
