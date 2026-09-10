# Host-specific NixOS settings; flake.nix also loads modules/system/core.nix.
{pkgs-unstable, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/nvidia.nix
    # Adds PRIME offload; GPU bus IDs are configured in this module for Katana.
    ../../modules/hardware/nvidia-prime.nix
    ../../modules/system/games.nix
    ../../modules/system/devices/laptop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the latest kernel provided by the flake's pinned nixpkgs-unstable input.
  boot.kernelPackages = pkgs-unstable.linuxPackages_latest;

  networking.hostName = "katana";

  # Compatibility baseline for stateful NixOS defaults; do not bump on routine upgrades.
  system.stateVersion = "26.05";
}
