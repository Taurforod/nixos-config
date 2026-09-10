{pkgs, ...}: {
  # Provide thumbnail generation, virtual filesystem access, and disk management.
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  # Archive, video thumbnail, and removable-media helpers.
  environment.systemPackages = with pkgs; [
    file-roller
    ffmpegthumbnailer
    udiskie
  ];
}
