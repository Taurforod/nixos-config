# Host-specific NixOS settings; flake.nix also loads modules/system/core.nix.
{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/system/games.nix
    ../../modules/system/devices/laptop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the latest kernel provided by the flake's pinned stable nixpkgs input.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "thinkpadx13";

  # Compatibility baseline for stateful NixOS defaults; do not bump on routine upgrades.
  system.stateVersion = "26.05";

  services.power-profiles-daemon.enable = true;
}
