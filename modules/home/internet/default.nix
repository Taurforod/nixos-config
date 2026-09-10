{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./firefox.nix
  ];

  # Hide the FirefoxPWA launcher from application menus.
  xdg.desktopEntries.firefoxpwa = {
    name = "firefoxpwa";
    noDisplay = true;
  };

  home.packages = with pkgs;
    [
      # Browsers.
      chromium
      brave

      # Torrents.
      qbittorrent
    ]
    ++ (with pkgs-unstable; [
      element-desktop
      telegram-desktop

      # Password management.
      bitwarden-desktop
    ]);
}
