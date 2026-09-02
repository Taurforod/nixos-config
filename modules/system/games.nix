{...}: {
  # Включение Steam
  programs.steam = {
    enable = true;
  };

  # Оптимизатор ресурсов в играх
  programs.gamemode.enable = true;

  hardware.steam-hardware.enable = true;

  # Драйверы для геймпадов Xbox (замена xone-dkms и xpadneo-dkms из Arch)
  hardware.xone.enable = true; # Для фирменного USB-адаптера Xbox
  hardware.xpadneo.enable = true; # Для подключения геймпада Xbox по Bluetooth
}
