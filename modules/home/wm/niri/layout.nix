# modules/home/niri/layout.nix
{ pkgs, ... }:
''
  layout {
      gaps 10 // Gap between windows
      center-focused-column "never" // Don’t auto-center focused column

      background-color "transparent" // <- needed for noctalia-shell to set wallpaper



      preset-column-widths {
          proportion 0.33333
          proportion 0.5
          proportion 0.66667
      }

      struts {}

		// Рамки фокуса (это законное свойство макета)
		focus-ring {
			width 2
			active-color "#b4befe"
			inactive-color "#313244"
		        }

      shadow {
      on
      softness 20          // Размытие тени
      spread 2             // Размер тени
      offset x=0 y=8       // Смещение тени по X и Y
      color "#00000077"    // Цвет и прозрачность
  }

  }

  animations {
      workspace-switch {
          spring damping-ratio=0.88 stiffness=1400 epsilon=0.0001
      }
      window-open {
          duration-ms 200
          curve "ease-out-quad"
      }
      window-close {
          duration-ms 200
          curve "ease-out-cubic"
      }
      horizontal-view-movement {
          spring damping-ratio=0.85 stiffness=1300 epsilon=0.0001
      }
      window-movement {
          spring damping-ratio=0.88 stiffness=1200 epsilon=0.0001
      }
      window-resize {
          spring damping-ratio=0.90 stiffness=1500 epsilon=0.0001
      }
      config-notification-open-close {
          spring damping-ratio=0.6 stiffness=1200 epsilon=0.001
      }
      screenshot-ui-open {
          duration-ms 300
          curve "ease-out-quad"
      }
      overview-open-close {
          spring damping-ratio=0.85 stiffness=1200 epsilon=0.0001
      }
  }
''
