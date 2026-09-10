{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  # Exclude these Stylix integrations entirely.
  disabledModules = [
    "${inputs.stylix}/modules/regreet/nixos.nix"
    "${inputs.stylix}/modules/kmscon/nixos.nix"
  ];

  environment.systemPackages = with pkgs; [
    kora-icon-theme
    hicolor-icon-theme
    librsvg
    shared-mime-info

    (catppuccin-gtk.override {
      accents = ["lavender"];
      variant = "mocha";
    })

    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    catppuccin-cursors.mochaMauve
  ];

  stylix = {
    enable = true;

    # Enable Stylix targets explicitly.
    autoEnable = false;

    # Suppress Stylix release compatibility checks.
    enableReleaseChecks = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # Generate a solid background matching the Catppuccin Mocha base color.
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

    # Use the same icon theme for both polarities; modules/home/common.nix also reads it.
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

      # Enable dconf support required by Home Manager's GTK configuration.
      gtk.enable = true;

      # Configure system Qt integration for Plasma.
      # Home Manager's Stylix Qt target is disabled in modules/home/common.nix.
      qt.enable = true;
    };
  };
}
