{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      palette = "noctalia";
      add_newline = true;

      format = ''
        $username$hostname$directory$git_branch$git_status$nix_shell$nodejs$python
        $character
      '';

      # Пути к папкам
      directory = {
        style = "bold sky";
        truncation_length = 3;
        truncation_symbol = "…/";
        read_only = " 🔒";
      };

      # Ветка Git
      git_branch = {
        symbol = "🌱 ";
        style = "bold mauve";
      };

      # Статус Git репозитория
      git_status = {
        style = "bold red";
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
      };

      # --- Окружение NIX (Nix Shell / Flake Shell) ---
      nix_shell = {
        symbol = "❄️ ";
        style = "bold blue";
        format = "via [$symbol$state( \\($name\\))]($style) ";
      };

      # --- Окружение JavaScript / Node.js ---
      nodejs = {
        symbol = "⚡ ";
        style = "bold green";
        format = "via [$symbol($version )]($style) ";
      };

      # --- Окружение Python ---
      python = {
        symbol = "🐍 ";
        style = "bold yellow";
        pyenv_prefix = "venv ";
      };

      # Стрелочка ввода команды
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      # Все встроенные цветовые палитры
      palettes = {
        catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
        };

        noctalia = {
          blue = "#89b4fa";
          red = "#f38ba8";
          green = "#a6e3a1";
          yellow = "#f9e2af";
          cyan = "#94e2d5";
          magenta = "#f5c2e7";
          white = "#a6adc8";
          black = "#45475a";

          rosewater = "#ebd391";
          flamingo = "#f37799";
          pink = "#f2aede";
          mauve = "#f5c2e7";
          maroon = "#f37799";
          peach = "#ebd391";
          teal = "#94e2d5";
          sky = "#6bd7ca";
          sapphire = "#74a8fc";
          lavender = "#f2aede";

          text = "#cdd6f4";
          subtext1 = "#a6adc8";
          subtext0 = "#585b70";

          overlay2 = "#585b70";
          overlay1 = "#585b70";
          overlay0 = "#45475a";
          surface2 = "#45475a";
          surface1 = "#45475a";
          surface0 = "#1e1e2e";
          base = "#1e1e2e";
          mantle = "#1e1e2e";
          crust = "#1e1e2e";
        };
      };
    };
  };
}
