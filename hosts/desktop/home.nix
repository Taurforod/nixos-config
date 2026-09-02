{...}: {
  imports = [
    ../../modules/home/desktop-apps.nix
    ../../modules/home/games
  ];

  # Niri screen configs
  myNiri = {
    enable = true;
    displayConfig = ''
      // 1. Left: ASUS VG27AQ3A (HDMI-A-1)
      output "ASUSTek COMPUTER INC VG27AQ3A R8LMAS000307" {
          mode "2560x1440@144.000"
          scale 1.25
          position x=0 y=0
      }

      // 2. Center (MAIN): Gigabyte MO27Q28G QD-OLED (DP-3)
      output "GIGA-BYTE TECHNOLOGY CO., LTD. MO27Q28G 25472F001424" {
          mode "2560x1440@279.961"
          scale 1.25
          position x=2048 y=0
          focus-at-startup
          backdrop-color "#000000"
      }

      // 3. Right: ASUS PG279QE (DP-1)
      output "ASUSTek COMPUTER INC PG279QE #ASOdSStCYeXd" {
          mode "2560x1440@143.998"
          scale 1.25
          position x=4096 y=0
      }
    '';
  };

  xdg.configFile."easyeffects/output/desktop-sound.json".source = ../../modules/home/media/easyeffects/presets/desktop-sound.json;

  home.stateVersion = "26.05";
}
