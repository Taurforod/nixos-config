{ pkgs, ... }:

{
  programs.micro = {
    enable = true;

    settings = {
      colorscheme = "catppuccin-mocha";
      tabsize = 4;
      autoindent = true;
      basename = true;
      diff = true;
      ruler = true;
      scrollbar = false;
      mouse = true;
      savecursor = true;
      softwrap = true;
    };
  };

  # Вшиваем тему Catppuccin Mocha прямо в конфиг (без сети и без хэшей)
  xdg.configFile."micro/colorschemes/catppuccin-mocha.micro".text = ''
    color-link default "#cdd6f4,#1e1e2e"
    color-link comment "#6c7086"
    color-link identifier "#89b4fa"
    color-link identifier.class "#89b4fa"
    color-link identifier.var "#89b4fa"
    color-link constant "#fab387"
    color-link constant.number "#fab387"
    color-link constant.string "#a6e3a1"
    color-link constant.string.char "#f5e0dc"
    color-link statement "#cba6f7"
    color-link symbol "#94e2d5"
    color-link preproc "#f5e0dc"
    color-link type "#89b4fa"
    color-link special "#f5e0dc"
    color-link underline "#f5e0dc"
    color-link error "bold #f38ba8"
    color-link todo "bold #f9e2af"
    color-link statusline "#cdd6f4,#181825"
    color-link tabbar "#cdd6f4,#181825"
    color-link indent-char "#45475a"
    color-link line-number "#45475a"
    color-link current-line-number "#b4befe"
    color-link cursor-line "#313244"
    color-link color-column "#313244"
    color-link type.keyword "#f38ba8"
    color-link symbol.operator "#89dceb"
    color-link diff-added "#a6e3a1"
    color-link diff-modified "#f9e2af"
    color-link diff-deleted "#f38ba8"
    color-link gutter-error "#f38ba8"
    color-link gutter-warning "#f9e2af"
    color-link divider "#313244"
  '';
}
