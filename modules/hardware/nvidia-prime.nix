{ config, ... }:

{
  # Настройки, специфичные ТОЛЬКО для гибридных ноутбуков
  hardware.nvidia = {
    # Динамическое полное отключение питания дискретной карты при простое
    powerManagement.finegrained = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # Bus ID конкретно для Katana (проверить через lspci)
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
