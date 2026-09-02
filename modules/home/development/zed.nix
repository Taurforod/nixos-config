{pkgs-unstable, ...}: {
  # Инструменты разработчика для Zed
  home.packages = with pkgs-unstable; [
    nixd # Языковой сервер (LSP) для Nix
    alejandra # Форматировщик Nix, указанный в настройках
  ];

  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;

    extensions = [
      "catppuccin"
      "catppuccin-icons"
      "nix"
    ];

    # Актуальная конфигурация из CachyOS
    userSettings = {
      cli_default_open_behavior = "existing_window";
      agent = {
        sidebar_side = "right";
        favorite_models = [];
        model_parameters = [];
      };
      disable_ai = false; # Отключение AI-функционала
      theme = "Catppuccin Mocha";
      icon_theme = "Catppuccin Mocha";
      base_keymap = "VSCode";
      ui_font_size = 16;
      buffer_font_size = 15;
      buffer_font_features = {calt = true;};

      autosave = "on_focus_change";
      vertical_scroll_margin = 4;
      soft_wrap = "editor_width";

      telemetry = {metrics = false;};

      git = {
        inline_blame = {enabled = true;};
      };

      tab_bar = {
        show = true;
      };

      project_panel = {
        dock = "left";
        default_width = 240;
      };

      outline_panel = {
        dock = "right";
      };

      languages = {
        Python = {
          language_servers = ["pyright" "ruff"];
          formatter = {
            language_server = {name = "ruff";};
          };
        };
        Nix = {
          language_servers = ["nixd" "!nil"];
          formatter = {
            external = {
              command = "alejandra";
              arguments = ["-"];
            };
          };
        };
      };

      format_on_save = "on";
    };
  };
}
