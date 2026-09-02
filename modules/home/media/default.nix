{
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ./easyeffects/easyeffects.nix
    ./mpv.nix
  ];

  home.packages =
    (with pkgs; [
      ])
    ++ (with pkgs-unstable; [
      ]);
}
