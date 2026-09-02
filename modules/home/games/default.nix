{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.mangohud = {
    enable = true;
    package = pkgs-unstable.mangohud;
  };

  home.packages =
    (with pkgs; [
      gamescope
    ])
    ++ (with pkgs-unstable; [
      heroic
      lutris
      protonplus
    ]);
}
