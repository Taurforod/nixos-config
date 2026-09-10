{pkgs, ...}: ''
  input {
      keyboard {
      // Niri keyboard layout and switching; the greeter has separate settings.
        xkb {
          layout "us,ru,no"
          options "grp:caps_toggle"
      }
      numlock
    }

    // Shared touchpad settings for all hosts using this configuration.
      touchpad {
        tap
        natural-scroll
        dwt   // Disable touchpad input while typing.
        accel-speed 0.2
      }

      mouse {
      }

      focus-follows-mouse
      workspace-auto-back-and-forth // Selecting the current workspace returns to the previous one.
  }
''
