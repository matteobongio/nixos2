{...}: {
  flake.nixosModules.nvidia = {pkgs, ...}: {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.open = true;

    environment.systemPackages = with pkgs; [
      nvidia-vaapi-driver
    ];

    # TODO: check
    hardware.nvidia.modesetting.enable = true;
    # environment.sessionVariables = {
    #   LIBVA_DRIVER_NAME = "nvidia";
    #   XDG_SESSION_TYPE = "wayland";
    #   GBM_BACKEND = "nvidia-drm";
    #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #   NVD_BACKEND = "direct";
    # };

    nix.settings = {
      substituters = [
        "https://cache.flox.dev"
        "https://cache.nixos-cuda.org"
      ];

      trusted-public-keys = [
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };
    nixpkgs.config.cudaSupport = true;
  };
}
