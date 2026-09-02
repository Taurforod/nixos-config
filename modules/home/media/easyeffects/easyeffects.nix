{pkgs, ...}: {
  services.easyeffects = {
    enable = true;
  };

  home.packages = with pkgs; [
    rnnoise-plugin

    # Удаляем ярлыки приложений, оставляя только LV2-плагины для EasyEffects
    (lsp-plugins.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          rm -rf $out/share/applications
        '';
    }))
  ];

  # Пресет микрофона
  xdg.configFile."easyeffects/input/mic-main.json".source = ./presets/mic-main.json;
}
