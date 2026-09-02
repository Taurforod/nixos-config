{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages =
    (with pkgs; [
      kdePackages.kcalc
      kdePackages.skanpage
      marktext
    ])
    ++ (with pkgs-unstable; [
      evince # PDF Reader
      obsidian
    ]);
}
