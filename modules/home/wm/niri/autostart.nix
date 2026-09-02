# modules/home/niri/autostart.nix
{pkgs, ...}: ''
  // Окружение Wayland (импорт переменных в dbus)
  spawn-at-startup "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" "DISPLAY"

  spawn-at-startup "xwayland-satellite"

  // Графическая оболочка Noctalia v5
  spawn-at-startup "noctalia"

  // KDE Polkit агент для аутентификации (запросы пароля)
  spawn-at-startup "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"

  spawn-at-startup "easyeffects"

  spawn-at-startup "Telegram"
  spawn-at-startup "flatpak" "run" "com.discordapp.Discord"

''
