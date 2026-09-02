{...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true; # Включает удобную функцию cd при выходе из yazi

    settings = {
      manager = {
        show_hidden = true; # Показывать скрытые файлы (.)
        sort_by = "alphabetical";
        sort_dir_first = true; # Папки всегда вверху списка
      };
    };
  };

  # xdg находится на верхнем уровне Home Manager
  xdg.configFile."yazi/theme.toml".source = ./theme.toml;
}
