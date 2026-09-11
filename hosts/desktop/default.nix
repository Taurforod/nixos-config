# Host-specific NixOS settings; flake.nix also loads modules/system/core.nix.
{pkgs-unstable, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/system/games.nix
    ../../modules/system/docker.nix
    ../../modules/system/ollama.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use the Zen kernel from the flake's pinned nixpkgs-unstable input.
  boot.kernelPackages = pkgs-unstable.linuxPackages_zen;

  # Additional drives are configured here; root and EFI mounts are in hardware-configuration.nix.
  # Update the UUIDs below when replacing or reformatting these drives.
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

  # Both NTFS mounts below allow booting without the drive (nofail).
  # uid/gid set ownership; verify these IDs when changing the local user.
  # dmask/fmask expose directories as 755 and files as 664.
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

  networking.hostName = "desktop";

  # Compatibility baseline for stateful NixOS defaults; do not bump on routine upgrades.
  system.stateVersion = "26.05";

  programs.coolercontrol.enable = true;

  services.pipewire.wireplumber.extraConfig."90-desktop-volume" = {
    "wireplumber.settings" = {
      "device.routes.default-sink-volume" = 1.0;
    };
  };

  # WAVE 75 must not be classified as a joystick.
  services.udev.extraRules = ''
    SUBSYSTEM=="input", ATTRS{idVendor}=="36b0", ATTRS{idProduct}=="3009", ENV{ID_INPUT_JOYSTICK}="0"
  '';
}
