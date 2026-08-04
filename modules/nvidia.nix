{...}: {
  flake.nixosModules.nvidia = {pkgs, ...} : {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    }; 
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;

    # TODO: check
    hardware.nvidia.modesetting.enable = true;
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };

  };
}
