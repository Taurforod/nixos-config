{pkgs, ...}: {
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.flatpak-kcm
  ];

  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    after = ["network-online.target"];
    wants = ["network-online.target"];
    path = [pkgs.flatpak];

    # Говорим системе, что это разовый скрипт, а не фоновый демон
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

      flatpak install --or-update -y flathub \
        com.github.tchx84.Flatseal \
        org.onlyoffice.desktopeditors \
        com.calibre_ebook.calibre \
        com.spotify.Client
    '';
  };
}
