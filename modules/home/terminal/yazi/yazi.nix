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
    };
  };

  # Load the full theme from the adjacent TOML file.
  xdg.configFile."yazi/theme.toml".source = ./theme.toml;
}
