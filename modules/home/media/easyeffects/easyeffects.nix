{pkgs, ...}: {
  services.easyeffects = {
    enable = true;
  };

  # Wait for the tray before starting EasyEffects.
  systemd.user.services.easyeffects.Service.ExecStartPre = "${pkgs.writeShellScript "easyeffects-wait-for-tray" ''
    for ((i = 0; i < 50; i++)); do
      state="$(${pkgs.systemd}/bin/busctl --user --timeout=1s \
        get-property org.kde.StatusNotifierWatcher \
        /StatusNotifierWatcher org.kde.StatusNotifierWatcher \
        IsStatusNotifierHostRegistered 2>/dev/null)" || state=""

      if [[ "$state" == "b true" ]]; then
        exit 0
      fi

      ${pkgs.coreutils}/bin/sleep 0.2
    done

    echo "Tray unavailable; starting EasyEffects anyway" >&2
    exit 0
  ''}";

  home.packages = with pkgs; [
    rnnoise-plugin

    # Hide LSP application launchers while keeping the plugins available to EasyEffects.
    (lsp-plugins.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          rm -rf $out/share/applications
        '';
    }))
  ];

  # Install the microphone preset; automatic preset loading is not configured here.
  xdg.configFile."easyeffects/input/mic-main.json".source = ./presets/mic-main.json;
}
