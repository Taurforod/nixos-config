{pkgs, ...}: {
  programs.mpv = {
    enable = true;

    scripts = with pkgs.mpvScripts; [
      uosc
      mpris
    ];

    config = {
      # Use the gpu-next renderer with Vulkan.
      vo = "gpu-next";
      gpu-api = "vulkan";
      hwdec = "auto-safe";

      # Request output colorspace signaling where supported.
      target-colorspace-hint = "yes";

      # Use uosc for playback controls and hide the window border.
      osd-bar = "no";
      border = "no";

      profile = "high-quality";
    };
  };
}
