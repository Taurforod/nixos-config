{
  pkgs,
  inputs,
  lib,
  username,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
    ./devices
    ./flatpak.nix
    ./greeter.nix
    ./networking
    ./theme.nix
    ./thunar.nix
  ];

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "ru_RU.UTF-8";

  # X11 / Wayland базовые настройки
  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us, ru, no";
    variant = "";
    options = "grp:caps_toggle";
  };

  # Окружения (Plasma 6 & Niri)
  services.displayManager.sddm.enable = false;
  services.desktopManager.plasma6.enable = true;

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  environment.sessionVariables = {
    XDG_MENU_PREFIX = "plasma-";
  };

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
    "/share/desktop-directories"
    "/share/menus"
    "/etc/xdg/menus"
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.niri = {
      default = lib.mkForce ["gnome" "gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
      "org.freedesktop.impl.portal.Screenshot" = ["gnome"];
    };
  };

  systemd.user.services.xdg-desktop-portal-gnome = {
    environment = {
      GSK_RENDERER = "gl";
    };
  };

  systemd.user.sockets."drkonqi-coredump-launcher" = {
    unitConfig = {
      ConditionEnvironment = "XDG_CURRENT_DESKTOP=KDE";
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.dconf.enable = true;

  # Описание учетной записи пользователя
  users.users.${username} = {
    isNormalUser = true;
    description = lib.toSentenceCase username;
    home = "/home/${username}";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  services.gvfs.enable = true; # Сети, корзина, MTP
  services.udisks2.enable = true; # Отображение неотмонтированных дисков

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

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    okular
  ];

  # Системные пакеты
  environment.systemPackages =
    (with pkgs; [
      (catppuccin-gtk.override {
        accents = ["lavender"]; # Можно указать: "blue", "lavender", "teal" и т.д.
        variant = "mocha";
      })
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qt6ct
      libsForQt5.qtstyleplugin-kvantum
      kdePackages.kservice

      xwayland-satellite

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
      udiskie

      catppuccin-cursors.mochaMauve
    ])
    ++ [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      inter
      nerd-fonts.jetbrains-mono
    ];
  };
}
