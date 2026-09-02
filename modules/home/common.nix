{
  config,
  lib,
  ...
}: {
  imports = [
    ./ai
    ./development
    ./terminal
    ./internet
    ./media
    ./office
    ./wm
  ];

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
      gtk-theme = lib.mkForce "catppuccin-mocha-lavender-standard";
    };
  };

  stylix.targets.firefox.enable = false;
  stylix.targets.qt.enable = false;
  # ВАЖНО: home.username и home.homeDirectory УДАЛЕНЫ.
  # Home Manager подтянет их автоматически из системного конфига NixOS.
}
