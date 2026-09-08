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

  # Описание учетной записи пользователя
  users.users.${username} = {
    isNormalUser = true;
    description = lib.toSentenceCase username;
    home = "/home/${username}";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  # Настройки Nix и Flakes
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

  # Отключено: ananicy-cpp тестировался для приоритетов процессов, временно не используется.
  services.ananicy = {
    enable = false;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  # Системные пакеты
  environment.systemPackages = with pkgs; [
    # Аварийный минимальный набор консоли (доступен в TTY и под root)
    micro
    git

    # Диагностика и базовые утилиты
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
