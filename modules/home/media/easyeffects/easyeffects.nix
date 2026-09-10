{pkgs, ...}: {
  services.easyeffects = {
    enable = true;
  };

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
