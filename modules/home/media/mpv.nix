{pkgs, ...}: {
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      uosc
      mpris
    ];

    config = {
      # Оптимизация Vulkan и нативный HDR
      vo = "gpu-next";
      gpu-api = "vulkan";
      hwdec = "auto-safe";
      target-colorspace-hint = "yes";

      # Кастомный интерфейс uosc
      osd-bar = "no";
      border = "no";

      profile = "high-quality";
    };
  };
}
