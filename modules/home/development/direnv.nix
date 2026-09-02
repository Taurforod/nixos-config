{ ... }:

{
  programs.direnv = {
    enable = true;

    # Включает быструю интеграцию с Nix shell / flake.nix
    nix-direnv.enable = true;

    # Интеграция с оболочками
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
