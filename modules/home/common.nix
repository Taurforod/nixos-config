{
  config,
  lib,
  pkgs,
  ...
}: let
  # dark и light сейчас оба равны kora-pgrey.
  # Значение берётся из Stylix, поэтому его не нужно
  # отдельно дублировать в GTK и KDE.
  iconThemeName = config.stylix.icons.dark;
in {
  imports = [
    ./ai
    ./development
    ./terminal
    ./internet
    ./media
    ./office
    ./wm
  ];

  gtk = {
    # Это критически важно при stylix.autoEnable = false.
    # Stylix уже передаёт gtk.iconTheme из системного
    # stylix.icons, но без gtk.enable Home Manager
    # не создаёт GTK settings.ini и запись dconf.
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
      gtk-theme =
        lib.mkForce "catppuccin-mocha-lavender-standard";

      # icon-theme здесь не дублируется.
      # Home Manager автоматически получает его из
      # config.gtk.iconTheme, заполненного Stylix.
    };
  };

  # Dolphin и другие KDE-приложения читают тему иконок
  # из группы [Icons] файла ~/.config/kdeglobals.
  #
  # Использование kwriteconfig6 изменяет только один ключ.
  # Весь kdeglobals не передаётся под управление Home Manager,
  # поэтому Plasma сможет хранить в нём остальные настройки.
  home.activation.setKdeIconTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 \
      --file kdeglobals \
      --group Icons \
      --key Theme \
      ${lib.escapeShellArg iconThemeName}
  '';

  stylix.targets.firefox.enable = false;

  # Stylix не управляет стилем и палитрой Qt.
  # Dolphin продолжает использовать штатную KDE/Breeze-интеграцию.
  stylix.targets.qt.enable = false;
}
