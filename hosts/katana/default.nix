{pkgs-unstable, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/hardware/nvidia.nix # Базовый драйвер NVIDIA
    ../../modules/hardware/nvidia-prime.nix # Дополняем гибридной графикой
    ../../modules/system/games.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs-unstable.linuxPackages_latest;

  networking.hostName = "katana"; # Define your hostname.

  system.stateVersion = "26.05";
}
