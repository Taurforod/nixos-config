# modules/home/niri/keybinds.nix
{ pkgs, ... }:
''
  binds {

      // ────────────── Keybindings ──────────────
      // https://github.com/YaLTeR/niri/wiki/Configuration:-Key-Bindings

      // ─── noctalia-shell keybinds ───
      // https://docs.noctalia.dev/v5/ipc/

      Mod+Shift+Escape              { show-hotkey-overlay; }

      // ─── Applications ───
      Mod+Return                    hotkey-overlay-title="Open Terminal: Kitty" { spawn "kitty"; }
      Mod+B                         hotkey-overlay-title="Open Browser: Firefox" { spawn "firefox"; }
      Mod+Shift+E                   hotkey-overlay-title="Open IDE: Zed" { spawn "zeditor"; }
      Mod+Ctrl+Return               hotkey-overlay-title="Open App Launcher: Noctalia launcher" { spawn-sh "noctalia msg panel-toggle launcher"; }
      Mod+Alt+L                     hotkey-overlay-title="Lock Screen: Noctalia lock" { spawn-sh "noctalia msg session lock"; }
      Mod+Shift+Q                   hotkey-overlay-title="Session Menu: Noctalia sessionMenu" { spawn-sh "noctalia msg panel-toggle session"; }

      // Please choose your own file manager.
      Mod+E                         hotkey-overlay-title="File Manager: Thunar" { spawn "thunar"; }

      // ─── Media Controls ───
      XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; }
      XF86AudioLowerVolume allow-when-locked=true { spawn-sh "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
      XF86AudioMute        allow-when-locked=true { spawn-sh "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
      XF86AudioMicMute     allow-when-locked=true { spawn-sh "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }

      XF86AudioPlay        allow-when-locked=true { spawn-sh "${pkgs.playerctl}/bin/playerctl play-pause"; }
      XF86AudioStop        allow-when-locked=true { spawn-sh "${pkgs.playerctl}/bin/playerctl stop"; }
      XF86AudioPrev        allow-when-locked=true { spawn-sh "${pkgs.playerctl}/bin/playerctl previous"; }
      XF86AudioNext        allow-when-locked=true { spawn-sh "${pkgs.playerctl}/bin/playerctl next"; }

      // ─── Brightness Controls ───
      XF86MonBrightnessUp                 allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "+5%"; }
      XF86MonBrightnessDown               allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-"; }

      // ─── Window Movement and Focus ───
      Mod+Q                               repeat=false { close-window; }

      Mod+Left                            { focus-column-left; }
      Mod+H                               { focus-column-left; }
      Mod+Right                           { focus-column-right; }
      Mod+L                               { focus-column-right; }
      Mod+Up                              { focus-window-up; }
      Mod+K                               { focus-window-up; }
      Mod+Down                            { focus-window-down; }
      Mod+J                               { focus-window-down; }

      Mod+CTRL+Left                       { move-column-left; }
      Mod+CTRL+H                          { move-column-left; }
      Mod+CTRL+Right                      { move-column-right; }
      Mod+CTRL+L                          { move-column-right; }
      Mod+CTRL+Up                         { move-window-up; }
      Mod+CTRL+K                          { move-window-up; }
      Mod+CTRL+Down                       { move-window-down; }
      Mod+CTRL+J                          { move-window-down; }

      Mod+Home                            { focus-column-first; }
      Mod+End                             { focus-column-last; }
      Mod+Ctrl+Home                       { move-column-to-first; }
      Mod+Ctrl+End                        { move-column-to-last; }

      Mod+Shift+Left                      { focus-monitor-left; }
      Mod+Shift+Right                     { focus-monitor-right; }
      Mod+Shift+Up                        { focus-monitor-up; }
      Mod+Shift+Down                      { focus-monitor-down; }

      Mod+Shift+Ctrl+Left                 { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+Right                { move-column-to-monitor-right; }
      Mod+Shift+Ctrl+Up                   { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+Down                 { move-column-to-monitor-down; }

      // ─── Workspace Switching ───
      Mod+WheelScrollDown                 cooldown-ms=150 { focus-workspace-down; }
      Mod+WheelScrollUp                   cooldown-ms=150 { focus-workspace-up; }
      Mod+Ctrl+WheelScrollDown            cooldown-ms=150 { move-column-to-workspace-down; }
      Mod+Ctrl+WheelScrollUp              cooldown-ms=150 { move-column-to-workspace-up; }

      Mod+Shift+Page_Down                 { move-workspace-down; }
      Mod+Shift+Page_Up                   { move-workspace-up; }
      Mod+Shift+U                         { move-workspace-down; }
      Mod+Shift+I                         { move-workspace-up; }

      Mod+WheelScrollRight                { focus-column-right; }
      Mod+WheelScrollLeft                 { focus-column-left; }
      Mod+Ctrl+WheelScrollRight           { move-column-right; }
      Mod+Ctrl+WheelScrollLeft            { move-column-left; }

      Mod+Shift+WheelScrollDown           { focus-column-right; }
      Mod+Shift+WheelScrollUp             { focus-column-left; }
      Mod+Ctrl+Shift+WheelScrollDown      { move-column-right; }
      Mod+Ctrl+Shift+WheelScrollUp        { move-column-left; }

      Mod+1                               { focus-workspace 1; }
      Mod+2                               { focus-workspace 2; }
      Mod+3                               { focus-workspace 3; }
      Mod+4                               { focus-workspace 4; }
      Mod+5                               { focus-workspace 5; }
      Mod+6                               { focus-workspace 6; }
      Mod+7                               { focus-workspace 7; }
      Mod+8                               { focus-workspace 8; }
      Mod+9                               { focus-workspace 9; }

      Mod+CTRL+1                          { move-column-to-workspace 1; }
      Mod+CTRL+2                          { move-column-to-workspace 2; }
      Mod+CTRL+3                          { move-column-to-workspace 3; }
      Mod+CTRL+4                          { move-column-to-workspace 4; }
      Mod+CTRL+5                          { move-column-to-workspace 5; }
      Mod+CTRL+6                          { move-column-to-workspace 6; }
      Mod+CTRL+7                          { move-column-to-workspace 7; }
      Mod+CTRL+8                          { move-column-to-workspace 8; }
      Mod+CTRL+9                          { move-column-to-workspace 9; }

      Mod+Tab                             { focus-workspace-previous; }

      // ─── Layout Controls ───
      Mod+CTRL+F                          { expand-column-to-available-width; }
      Mod+C                               { center-column; }
      Mod+CTRL+C                          { center-visible-columns; }
      Mod+Minus                           { set-column-width "-10%"; }
      Mod+Equal                           { set-column-width "+10%"; }
      Mod+Shift+Minus                     { set-window-height "-10%"; }
      Mod+Shift+Equal                     { set-window-height "+10%"; }

      // ─── Modes ───
      Mod+T                               { toggle-window-floating; }
      Mod+Shift+T                         { switch-focus-between-floating-and-tiling; }
      Mod+F                               { fullscreen-window; }
      Mod+W                               { toggle-column-tabbed-display; }

      // ─── Screenshots ───
      CTRL+Shift+1                        { screenshot; }
      CTRL+Shift+2                        { screenshot-screen; }
      CTRL+Shift+3                        { screenshot-window; }

      // ─── Exit / Power ───
      CTRL+ALT+Delete                     { quit; } // Also quits Niri
      Mod+Shift+P                         { power-off-monitors; } // Turn off screens (useful for OLED or privacy)
      Mod+O                               repeat=false { toggle-overview; }
      Mod+Shift+R                         hotkey-overlay-title="Restart Noctalia" { spawn-sh "pkill noctalia; noctalia &"; }
  }
''
