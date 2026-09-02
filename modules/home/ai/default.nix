{pkgs-unstable, ...}: {
  programs.codex = {
    enable = true;
    package = pkgs-unstable.codex;
  };
}
