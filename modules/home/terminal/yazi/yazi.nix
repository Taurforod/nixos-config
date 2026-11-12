{...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true; # Use the `y` wrapper to change directory when exiting Yazi.

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "alphabetical";
        sort_dir_first = true;
      };

      opener.appimage = [
        {
          run = ''appimage-run "$@"'';
          orphan = true;
          desc = "Run AppImage";
          for = "linux";
        }
      ];

      open.prepend_rules = [
        {
          mime = "application/vnd.appimage";
          use = "appimage";
        }
      ];
    };
  };

  # Load the full theme from the adjacent TOML file.
  xdg.configFile."yazi/theme.toml".source = ./theme.toml;
}
