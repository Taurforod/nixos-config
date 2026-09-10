# Shared Home Manager settings; flake.nix also loads hosts/<name>/home.nix.
{
  config,
  lib,
  pkgs,
  ...
}: let
  # Reuse the system Stylix icon theme; both polarities currently select kora-pgrey.
  iconThemeName = config.stylix.icons.dark;
in {
  imports = [
    ./ai
    ./development
    ./terminal
    ./internet
    ./media
    ./office
    ./wm
  ];

  gtk = {
    # Enable GTK settings generation explicitly because Stylix autoEnable is disabled.
    # The icon theme is supplied by the system Stylix configuration.
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  # Keep the GTK appearance dark and select the Catppuccin theme installed system-wide.
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
      gtk-theme =
        lib.mkForce "catppuccin-mocha-lavender-standard";

      # Home Manager writes icon-theme from gtk.iconTheme.
    };
  };

  # Update only KDE's icon theme after Home Manager has installed its files.
  # Leave the rest of kdeglobals writable for Plasma and KDE applications.
  home.activation.setKdeIconTheme = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 \
      --file kdeglobals \
      --group Icons \
      --key Theme \
      ${lib.escapeShellArg iconThemeName}
  '';

  # Firefox appearance is configured in internet/firefox.nix.
  stylix.targets.firefox.enable = false;

  # Keep Plasma's native KDE/Breeze integration for Qt applications.
  stylix.targets.qt.enable = false;
}
