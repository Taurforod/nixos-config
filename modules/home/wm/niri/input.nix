# modules/home/niri/input.nix
{ pkgs, ... }:
''
  input {
      keyboard {
        xkb {
          layout "us,ru,no"
          options "grp:caps_toggle"
      }
      numlock // Enable numlock on startup
    }

      // Настройки для тачпада Katana
      touchpad {
        tap
        natural-scroll
        dwt
        accel-speed 0.2
      }

      mouse {
        //accel-speed 0.2
      }

      focus-follows-mouse // Automatically focus windows under the mouse pointer
      workspace-auto-back-and-forth // Enable workspace back & forth switching
  }
''
