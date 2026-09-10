{...}: ''
   window-rule {
       geometry-corner-radius 10
       clip-to-geometry true
   }

   // Float Steam windows except the main window.
   window-rule {
       match app-id="steam"
       exclude title=r#"^[Ss]team$"#
       open-floating true
   }

   window-rule {
      match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
      default-floating-position x=10 y=10 relative-to="bottom-right"
      open-focused false
   }

   // Place Noctalia's wallpaper behind transparent workspaces.
   layer-rule {
       match namespace="^noctalia-wallpaper*"
       place-within-backdrop true
   }

  window-rule {
   	match app-id="kitty"
   	default-column-width { proportion 0.6; }
  }

  // Open the Firefox picture-in-picture player as floating by default.
  window-rule {
    // Match both native and Flatpak Firefox app IDs.
     match app-id=r#"firefox$"# title="^Picture-in-Picture$"
     open-floating true
  }

  hotkey-overlay {
     skip-at-startup
   }
''
