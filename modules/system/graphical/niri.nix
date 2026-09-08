{
  pkgs,
  lib,
  ...
}: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = [
    pkgs.xwayland-satellite
  ];

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];

    config.niri = {
      default = lib.mkForce ["gnome" "gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
      "org.freedesktop.impl.portal.Screenshot" = ["gnome"];
    };
  };

  systemd.user.services.xdg-desktop-portal-gnome = {
    environment.GSK_RENDERER = "gl";
  };
}
