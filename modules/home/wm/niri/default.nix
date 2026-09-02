# modules/home/niri/default.nix
{ config, lib, pkgs, ... }:

let
  cfg = config.myNiri;

  autostart = import ./autostart.nix { inherit pkgs; };
  input     = import ./input.nix     { inherit pkgs; };
  keybinds  = import ./keybinds.nix  { inherit pkgs; };
  layout    = import ./layout.nix    { inherit pkgs; };
  misc      = import ./misc.nix      { inherit pkgs; };
  rules     = import ./rules.nix     { inherit pkgs; };
in
{
  options.myNiri = {
    enable = lib.mkEnableOption "Niri WM Configuration";

    displayConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Host-specific display/output configuration for Niri";
    };
  };

  config = lib.mkIf cfg.enable {
    # Переменные окружения применяются автоматически для любого хоста, где включен myNiri.enable = true;
    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      NIRI_CONFIG_BG_COLOR = "transparent";
    };

    # Настройка курсора через Home Manager
    # home.pointerCursor = {
    #   name = "catppuccin-mocha-mauve-cursors";
    #   package = pkgs.catppuccin-cursors.mochaMauve;
    #   size = 24;
    #   gtk.enable = true;
    #   x11.enable = true;
    # };

    xdg.configFile."niri/config.kdl" = {
      force = true;
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
