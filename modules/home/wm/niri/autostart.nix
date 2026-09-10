{pkgs, ...}: ''
  // Share the Wayland session environment with D-Bus and systemd user services.
  spawn-at-startup "dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" "DISPLAY"

  spawn-at-startup "xwayland-satellite"

  spawn-at-startup "noctalia"

  // Start the KDE authentication agent for privilege prompts.
  spawn-at-startup "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"

  spawn-at-startup "easyeffects"

  spawn-at-startup "Telegram"

  // Discord is installed by modules/system/graphical/flatpak.nix.
  spawn-at-startup "flatpak" "run" "com.discordapp.Discord"

''
