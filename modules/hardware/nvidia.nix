{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # 4. Базовые настройки NVIDIA (без гибридной специфики)
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; # Нормальный сон/пробуждение ПК
    open = true; # Подходит и для 4060, и для 3080 Ti (серии RTX)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Переменные окружения для поддержки NVIDIA в Wayland, Niri и Electron
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NIXOS_OZONE_WL = "1";
  };
}
