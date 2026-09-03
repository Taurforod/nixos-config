{
  lib,
  pkgs,
  ...
}: let
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
