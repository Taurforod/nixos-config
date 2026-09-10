# Shared NVIDIA configuration for Desktop and Katana.
{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    # Enable graphics support for 32-bit applications, including games.
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    # Enable NVIDIA power management for suspend and resume.
    powerManagement.enable = true;

    # Use NVIDIA's open-source kernel modules.
    open = true;
    nvidiaSettings = true;

    # Select the driver from the host's chosen kernel package set.
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  environment.sessionVariables = {
    # Select NVIDIA backends for VA-API and GLX.
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # Request native Wayland support in applications that honor this Nixpkgs flag.
    NIXOS_OZONE_WL = "1";
  };
}
