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
    xkb = {
      layout = "us, ru, no";
      variant = "";
      options = "grp:caps_toggle";
    };
  };

  programs.dconf.enable = true;

  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
    "/share/desktop-directories"
    "/share/menus"
    "/etc/xdg/menus"
  ];

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
