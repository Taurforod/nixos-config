{pkgs, ...}: {
  imports = [
    ./networking
  ];

  services.fwupd.enable = true; # Проверка и обновление прошивок оборудования

  # Отключено: ananicy-cpp тестировался для приоритетов процессов, временно не используется
  services.ananicy = {
    enable = false;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };
}
