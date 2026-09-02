{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./firefox.nix
  ];

  programs.discord = {
    enable = true;
    package = pkgs-unstable.discord;
    settings = {
      SKIP_HOST_UPDATE = true;
    };
  };

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
