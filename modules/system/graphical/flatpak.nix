{
  lib,
  pkgs,
  ...
}: let
  # System-wide apps to install from Flathub.
  # Removing an entry does not uninstall the application.
  flatpakApps = [
    "com.calibre_ebook.calibre"
    "com.discordapp.Discord"
    "com.github.tchx84.Flatseal"
    "com.spotify.Client"
    "org.onlyoffice.desktopeditors"
  ];
in {
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.flatpak-kcm
  ];

  # At boot, add Flathub if needed and install missing apps from the list.
  systemd.services.flatpak-install = {
    description = "Install declared system Flatpak applications";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    wants = ["network-online.target"];
    path = [pkgs.flatpak];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      flatpak remote-add \
        --system \
        --if-not-exists \
        flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo

      for app in ${lib.escapeShellArgs flatpakApps}; do
        if ! flatpak info --system "$app" >/dev/null 2>&1; then
          flatpak install \
            --system \
            --noninteractive \
            --assumeyes \
            flathub \
            "$app"
        fi
      done
    '';
  };

  # Update all system-wide Flatpak apps and runtimes, including those installed manually.
  systemd.services.flatpak-update = {
    description = "Update system Flatpak applications";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    path = [pkgs.flatpak];

    serviceConfig.Type = "oneshot";

    script = ''
      flatpak update \
        --system \
        --noninteractive \
        --assumeyes
    '';
  };

  # Run weekly and catch up on missed runs, with up to one hour of randomized delay.
  systemd.timers.flatpak-update = {
    description = "Weekly system Flatpak update";
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
  };
}
