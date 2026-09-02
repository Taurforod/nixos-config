{ pkgs, ... }: {

  services.fwupd.enable = true;       # Проверка и обновление прошивок оборудования


  # Включение ZeroTier One
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      # "xxxxxxxxxxxxxxxx" # Сюда можно сразу вписать ID вашей сети (опционально)
    ];
  };

  # Отключено: ananicy-cpp тестировался для приоритетов процессов, временно не используется
  services.ananicy = {
    enable = false;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
}
