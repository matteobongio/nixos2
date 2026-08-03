{inputs, self, ...}: {
  flake.nixosModules.matteob = {pkgs, ...}: {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.matteob = {
      isNormalUser = true;
      description = "Matteo Bongiovanni";
      extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
      ];
    };
  };
}

