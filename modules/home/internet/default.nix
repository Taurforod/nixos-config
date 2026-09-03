{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./firefox.nix
  ];

  xdg.desktopEntries.firefoxpwa = {
    name = "firefoxpwa";
    noDisplay = true;
  };

  home.packages = with pkgs;
    [
      # Браузеры
      chromium
      brave

      # Торренты
      qbittorrent
    ]
    ++ (with pkgs-unstable; [
      element-desktop
      telegram-desktop

      # Безопасность и пароли
      bitwarden-desktop
    ]);
}
