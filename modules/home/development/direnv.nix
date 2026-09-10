{...}: {
  # Project environments are selected by each project's .envrc.
  programs.direnv = {
    enable = true;

    # Cache Nix development environments between shell sessions.
    nix-direnv.enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };
}
