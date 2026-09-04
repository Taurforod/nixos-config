{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  disabledModules = [
    "${inputs.stylix}/modules/regreet/nixos.nix"
    "${inputs.stylix}/modules/kmscon/nixos.nix"
  ];

  environment.systemPackages = with pkgs; [
    kora-icon-theme
    hicolor-icon-theme
    librsvg
    shared-mime-info
  ];

  stylix = {
    enable = true;

    # Все цели включаются только явно.
    autoEnable = false;
    enableReleaseChecks = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    image = pkgs.runCommand "bg.png" {} ''
      ${pkgs.imagemagick}/bin/convert \
        -size 1920x1080 \
        xc:"#1e1e2e" \
        "$out"
    '';

    cursor = {
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      sizes = {
        applications = 11;
        desktop = 11;
        terminal = 11;
        popups = 11;
      };
    };

    icons = {
      enable = true;
      package = pkgs.kora-icon-theme;
      dark = "kora-pgrey";
      light = "kora-pgrey";
    };

    targets = {
      chromium.enable = true;
      console.enable = true;
      gnome.enable = true;

      # На уровне NixOS включает инфраструктуру dconf,
      # необходимую пользовательской GTK-конфигурации.
      gtk.enable = true;

      # Системная интеграция Qt с установленной Plasma.
      # Пользовательская цветовая стилизация Qt отдельно
      # отключена в common.nix.
      qt.enable = true;
    };
  };
}
