# System integration for Niri; user configuration is in modules/home/wm/niri.
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
    # X11 application support; started by modules/home/wm/niri/autostart.nix.
    pkgs.xwayland-satellite
  ];

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];

    # Select portal backends for Niri independently of the Plasma session.
    config.niri = {
      default = lib.mkForce ["gnome" "gtk"];
      "org.freedesktop.impl.portal.ScreenCast" = ["gnome"];
      "org.freedesktop.impl.portal.Screenshot" = ["gnome"];
    };
  };

  systemd.user.services.xdg-desktop-portal-gnome = {
    # Force the OpenGL renderer for the GNOME portal service.
    environment.GSK_RENDERER = "gl";
  };
}
