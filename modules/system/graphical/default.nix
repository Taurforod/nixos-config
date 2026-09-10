{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./plasma.nix
    ./niri.nix
    ./greeter.nix
    ./theme.nix
    ./thunar.nix
    ./flatpak.nix
  ];

  services.xserver = {
    enable = true;

    # X11 keyboard settings; Niri and the greeter configure their layouts separately.
    xkb = {
      layout = "us, ru, no";
      variant = "";
      options = "grp:caps_toggle";
    };
  };

  programs.dconf.enable = true;

  # Expose portal definitions, application launchers, and menus in the system profile.
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
    "/share/desktop-directories"
    "/share/menus"
    "/etc/xdg/menus"
  ];

  # Install Noctalia; its configuration and Niri startup are managed in modules/home/wm.
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
