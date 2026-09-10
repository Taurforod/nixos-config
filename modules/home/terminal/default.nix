{pkgs, ...}: {
  imports = [
    ./fastfetch.nix
    ./fish/fish.nix
    ./kitty.nix
    ./micro.nix
    ./starship.nix
    ./yazi/yazi.nix
  ];

  home.packages = with pkgs; [
    duf
    eza
    fzf
  ];

  programs.btop = {
    enable = true;
    settings = {
      # Noctalia theme templates are selected per host in wm/noctalia/settings-*.toml.
      color_theme = "noctalia";
      theme_background = false;
      update_ms = 1000;
    };
  };
}
