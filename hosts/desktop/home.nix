# Host-specific Home Manager settings; flake.nix also loads modules/home/common.nix.
{...}: {
  imports = [
    ../../modules/home/desktop-apps.nix
    ../../modules/home/games
  ];

  # myNiri is defined in modules/home/wm/niri; displayConfig becomes part of config.kdl.
  myNiri = {
    enable = true;
    displayConfig = ''
      // Run `niri msg outputs` to check output names and available modes.
      // Positions use logical pixels: 2560 / 1.25 = 2048 per monitor.

      // Left monitor.
      output "ASUSTek COMPUTER INC VG27AQ3A R8LMAS000307" {
          mode "2560x1440@144.000"
          scale 1.25
          position x=0 y=0
      }

      // Center monitor; receives focus at startup.
      output "GIGA-BYTE TECHNOLOGY CO., LTD. MO27Q28G 25472F001424" {
          mode "2560x1440@279.961"
          scale 1.25
          position x=2048 y=0
          focus-at-startup
          backdrop-color "#000000"
      }

      // Right monitor.
      output "ASUSTek COMPUTER INC PG279QE #ASOdSStCYeXd" {
          mode "2560x1440@143.998"
          scale 1.25
          position x=4096 y=0
      }
    '';
  };

  # Install the desktop output preset; this does not configure automatic preset loading.
  xdg.configFile."easyeffects/output/desktop-sound.json".source = ../../modules/home/media/easyeffects/presets/desktop-sound.json;

  # Compatibility baseline for Home Manager defaults; do not bump on routine upgrades.
  home.stateVersion = "26.05";
}
