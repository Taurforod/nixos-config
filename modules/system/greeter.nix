{ pkgs, config, ... }:

let
  # Берем итоговые настройки после слияния базового модуля и конфигурации конкретного хоста
  cfgSettings = config.programs.noctalia-greeter.settings;

  # Автоматически добавляем корректный путь к курсору в структуру TOML
  finalSettings = cfgSettings // {
    cursor = (cfgSettings.cursor or { }) // {
      path = "${pkgs.catppuccin-cursors.mochaMauve}/share/icons";
    };
  };

  greeterToml = (pkgs.formats.toml { }).generate "greeter.toml" finalSettings;
in
{
  # Базовые настройки ПО УМОЛЧАНИЮ для всех компьютеров
  programs.noctalia-greeter = {
    enable = true;
    greeter-args = "";
    settings = {
      keyboard = {
        layout = "us,ru,no";
        options = "grp:caps_toggle";
      };
      appearance = {
        scheme = "Synced";
        password_style = "random";
        hide_logo = true;
      };
      cursor = {
        theme = "catppuccin-mocha-mauve-cursors";
        size = 24;
      };
    };
  };

  # Универсальный скрипт подкладывания TOML-файла
  system.activationScripts.noctaliaGreeterFix = ''
    mkdir -p /var/lib/noctalia-greeter
    chown greeter:greeter /var/lib/noctalia-greeter 2>/dev/null || true
    chmod 0750 /var/lib/noctalia-greeter 2>/dev/null || true

    install -D -o greeter -g greeter -m 0644 ${greeterToml} /var/lib/noctalia-greeter/greeter.toml
  '';
}
