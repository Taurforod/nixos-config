{...}: {
  imports = [
    ../../modules/home/games
  ];

  # Niri screen configs
  myNiri = {
    enable = true;
    displayConfig = ''
      output "eDP-1" {
          mode "1920x1080@60.317"
          scale 1.25
          focus-at-startup
      }
    '';
  };

  home.stateVersion = "26.05";
}
