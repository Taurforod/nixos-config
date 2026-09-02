{pkgs, ...}: {
  services.tumbler.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  environment.systemPackages = with pkgs; [
    file-roller
    ffmpegthumbnailer
  ];
}
