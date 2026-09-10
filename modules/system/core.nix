# Shared NixOS configuration loaded for every host by flake.nix.
{
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./devices
    ./fonts.nix
    ./graphical
    ./networking
  ];

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "ru_RU.UTF-8";

  # The login name comes from flake.nix and is also used by Home Manager.
  users.users.${username} = {
    isNormalUser = true;
    description = lib.toSentenceCase username;
    home = "/home/${username}";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  environment.variables.EDITOR = "micro";
  programs.fish.enable = true;

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 10 --keep-since 14d";
    };
  };

  # Disabled after testing process priority management; retained for future use.
  services.ananicy = {
    enable = false;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  environment.systemPackages = with pkgs; [
    # Basic recovery tools available in a TTY and to root.
    micro
    git

    # System diagnostics and archive utilities.
    psmisc
    pciutils
    usbutils
    lm_sensors
    ripgrep
    tree
    zip
    unzip
    p7zip
  ];
}
