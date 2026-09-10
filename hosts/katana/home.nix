# Host-specific Home Manager settings; flake.nix also loads modules/home/common.nix.
{...}: {
  imports = [
    ../../modules/home/games
  ];

  # myNiri is defined in modules/home/wm/niri; displayConfig becomes part of config.kdl.
  myNiri = {
    enable = true;
    displayConfig = ''
      // Built-in display; check `niri msg outputs` before changing the output name or mode.
      output "eDP-1" {
          mode "1920x1080@60.317"
          scale 1.25
          focus-at-startup
      }
    '';
  };

  # Compatibility baseline for Home Manager defaults; do not bump on routine upgrades.
  home.stateVersion = "26.05";
}
