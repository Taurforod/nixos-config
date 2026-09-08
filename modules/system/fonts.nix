{pkgs, ...}: {
  fonts = {
    fontconfig.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      inter
      nerd-fonts.jetbrains-mono
    ];
  };
}
