# Assemble the shared Niri configuration with display settings from hosts/<name>/home.nix.
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myNiri;

  # These files return KDL text rather than Home Manager modules.
  autostart = import ./autostart.nix {inherit pkgs;};
  input = import ./input.nix {inherit pkgs;};
  keybinds = import ./keybinds.nix {inherit pkgs;};
  layout = import ./layout.nix {inherit pkgs;};
  misc = import ./misc.nix {inherit pkgs;};
  rules = import ./rules.nix {inherit pkgs;};
in {
  options.myNiri = {
    enable = lib.mkEnableOption "Niri WM Configuration";

    displayConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Host-specific display/output configuration for Niri";
    };
  };

  config = lib.mkIf cfg.enable {
    # User-wide session variables enabled with myNiri; these are not scoped to Niri startup.
    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      NIRI_CONFIG_BG_COLOR = "transparent";
    };

    # Open directories in Thunar in the Niri session.
    xdg.configFile."niri-mimeapps.list".text = ''
      [Default Applications]
      inode/directory=thunar.desktop;
    '';

    xdg.configFile."niri/config.kdl" = {
      force = true; # Replace an existing config.kdl when activating Home Manager.
      text = ''
        // ==========================================
        // HOST DISPLAY CONFIG
        // ==========================================
        ${cfg.displayConfig}

        // ==========================================
        // COMMON MODULES
        // ==========================================
        ${autostart}
        ${input}
        ${layout}
        ${misc}
        ${rules}
        ${keybinds}
      '';
    };
  };
}
