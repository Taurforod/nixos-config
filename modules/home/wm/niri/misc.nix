{pkgs, ...}: ''
  prefer-no-csd

  // Keep the cursor theme and size aligned with modules/system/graphical/theme.nix.
  cursor {
      xcursor-theme "catppuccin-mocha-mauve-cursors"
      xcursor-size 24
  }

  debug {
    // Allows notification actions and window activation from Noctalia.
    honor-xdg-activation-with-invalid-serial
    }
''
