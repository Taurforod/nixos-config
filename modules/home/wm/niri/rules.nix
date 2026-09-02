# modules/home/niri/rules.nix
{ ... }: ''
   window-rule {
       geometry-corner-radius 10 // Set every window radius to 10
       clip-to-geometry true
   }

    // if you use steam you will probably like these
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
     // This app-id regular expression will work for both:
     // - host Firefox (app-id is "firefox")
     // - Flatpak Firefox (app-id is "org.mozilla.firefox")
     match app-id=r#"firefox$"# title="^Picture-in-Picture$"
     open-floating true
  }

  hotkey-overlay {
     skip-at-startup
   }
''
