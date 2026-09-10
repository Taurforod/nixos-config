{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      palette = "noctalia";
      add_newline = true;

      # Two-line prompt: context and environments above, command entry below.
      format = ''
        $username$hostname$directory$git_branch$git_status$nix_shell$nodejs$python
        $character
      '';

      directory = {
        style = "bold sky";
        truncation_length = 3;
        truncation_symbol = "…/";
        read_only = " 🔒";
      };

      git_branch = {
        symbol = "🌱 ";
        style = "bold mauve";
      };

      git_status = {
        style = "bold red";
        format = "([\\[$all_status$ahead_behind\\]]($style) )";
      };

      nix_shell = {
        symbol = "❄️ ";
        style = "bold blue";
        format = "via [$symbol$state( \\($name\\))]($style) ";
      };

      nodejs = {
        symbol = "⚡ ";
        style = "bold green";
        format = "via [$symbol($version )]($style) ";
      };

      python = {
        symbol = "🐍 ";
        style = "bold yellow";
        pyenv_prefix = "venv ";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };

      # Local palette definitions; the palette setting above selects the active one.
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
