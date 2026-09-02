{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
    ./greeter.nix
    ./flatpak.nix
    ./printers.nix
    ./services.nix
    ./theme.nix
    ./thunar.nix
  ];

  # Сеть, часовой пояс и локализация
  networking = {
    networkmanager.enable = true;

    # Настройка фаервола
    firewall = {
      enable = true;
    };
  };

  programs.mtr.enable = true;

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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Включать адаптер при загрузке
  };

  # Звук
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # Нужно для приложений, завязанных на JACK/низкий задержки
    wireplumber.enable = true; # Управляет виртуальными источниками (EasyEffects) и маршрутизацией
  };

  # Описание учетной записи пользователя
  users.users."taurforod" = {
    isNormalUser = true;
    description = "Taurforod";
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
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: {
        NIX_ENFORCE_NO_NATIVE = 0;
        NIX_CFLAGS_COMPILE = oldAttrs.NIX_CFLAGS_COMPILE or "" + " -march=native -O3";
      }))
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
