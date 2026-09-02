{...}: {
  imports = [
    ../../modules/home/games
  ];

  # Niri screen configs
  myNiri = {
    enable = true;
    displayConfig = ''
      output "eDP-1" {
        mode "1920x1200@60.003"
        scale 1.35
        focus-at-startup
        }
    '';
  };

  home.stateVersion = "26.05";
}
