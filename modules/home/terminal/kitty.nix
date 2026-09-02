{...}: {
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11.0;
    };

    settings = {
      # Окно и прозрачность
      background_opacity = "0.85";

      # Курсор (0 отключает анимацию шлейфа, убирая задержку Fastfetch)
      cursor_shape = "beam";
      cursor_trail = 0;

      # Рендеринг (уменьшаем задержку вывода кадров)
      linux_display_server = "wayland";
      sync_to_monitor = "yes";
      repaint_delay = 2;
      input_delay = 1;

      # Протокол управления
      allow_remote_control = "yes";
      listen_on = "unix:$XDG_RUNTIME_DIR/mykitty.sock";

      # Звук и мышь
      enable_audio_bell = "no";
      scrollback_lines = 10000;
      mouse_hide_wait = "3.0";

      # Ссылки
      url_style = "curly";
      detect_urls = "yes";
      open_url_with = "default";
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";

      "ctrl+с" = "copy_to_clipboard";
      "ctrl+shift+с" = "copy_to_clipboard";

      "ctrl+м" = "paste_from_clipboard";
      "ctrl+shift+м" = "paste_from_clipboard";
    };
  };
}
