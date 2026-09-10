{pkgs, ...}: {
  services.ollama = {
    enable = true;

    # Use the CUDA build for NVIDIA GPU acceleration.
    package = pkgs.ollama-cuda;
  };
}
