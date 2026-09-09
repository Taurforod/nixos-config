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

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/e38eb377-fbdb-4692-a992-442ceabed2d4";
    fsType = "btrfs";
    options = [
      "rw"
      "noatime"
      "compress=zstd:3"
      "autodefrag"
      "discard=async"
    ];
  };

  fileSystems."/mnt/Data" = {
    device = "/dev/disk/by-uuid/091C3BAA320C467E";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "nofail"
      "uid=1000"
      "gid=100"
      "dmask=022"
      "fmask=113"
    ];
  };

  fileSystems."/mnt/Storage" = {
    device = "/dev/disk/by-uuid/664093E54093BA6F";
    fsType = "ntfs-3g";
    options = [
      "rw"
      "nofail"
      "uid=1000"
      "gid=100"
      "dmask=022"
      "fmask=113"
    ];
  };

  networking.hostName = "desktop"; # Define your hostname.

  system.stateVersion = "26.05";

  programs.coolercontrol.enable = true;
}
