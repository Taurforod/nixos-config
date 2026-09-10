{...}: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11.0;
    };

    settings = {
      background_opacity = "0.85";

      cursor_shape = "beam";
      cursor_trail = 0; # Disable cursor trail animation.

      # Use native Wayland with short repaint and input delays.
      linux_display_server = "wayland";
      sync_to_monitor = "yes";
      repaint_delay = 2;
      input_delay = 1;

      allow_remote_control = "no";
      listen_on = "unix:$XDG_RUNTIME_DIR/mykitty.sock";

      enable_audio_bell = "no";
      scrollback_lines = 10000;
      mouse_hide_wait = "3.0";

      url_style = "curly";
      detect_urls = "yes";
      open_url_with = "default";
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";

      # Cyrillic-layout bindings for the physical C and V keys.
      "ctrl+с" = "copy_to_clipboard";
      "ctrl+shift+с" = "copy_to_clipboard";

      "ctrl+м" = "paste_from_clipboard";
      "ctrl+shift+м" = "paste_from_clipboard";
    };
  };
}
