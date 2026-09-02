{pkgs, ...}: {
  imports = [
    ./fastfetch.nix
    ./fish/fish.nix
    ./kitty.nix
    ./micro.nix
    ./starship.nix
    ./yazi/yazi.nix
  ];

  # 1. Дополнительные консольные утилиты пользователя
  home.packages = with pkgs; [
    duf
    eza
    fzf
  ];

  # 4. Btop (Монитор ресурсов)
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "noctalia";
      theme_background = false;
      update_ms = 1000;
    };
  };
}
