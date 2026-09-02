{pkgs-unstable, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/hardware/nvidia.nix # Базовый драйвер NVIDIA
    ../../modules/system/games.nix
    ../../modules/system/docker.nix
    ../../modules/system/ollama.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs-unstable.linuxPackages_zen;

  networking.hostName = "desktop"; # Define your hostname.

  system.stateVersion = "26.05";

  programs.coolercontrol.enable = true;
}
