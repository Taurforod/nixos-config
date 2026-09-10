{
  pkgs,
  config,
  inputs,
  ...
}: let
  # Read the final settings after NixOS module definitions have been merged.
  cfgSettings = config.programs.noctalia-greeter.settings;

  # Preserve the configured cursor settings while replacing its path with a Nix store path.
  finalSettings =
    cfgSettings
    // {
      cursor =
        (cfgSettings.cursor or {})
        // {
          path = "${pkgs.catppuccin-cursors.mochaMauve}/share/icons";
        };
    };

  greeterToml = (pkgs.formats.toml {}).generate "greeter.toml" finalSettings;
in {
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];

  # Shared greeter settings for all hosts.
  programs.noctalia-greeter = {
    enable = true;
    greeter-args = "";
    settings = {
      keyboard = {
        layout = "us,ru,no";
        options = "grp:caps_toggle";
      };
      appearance = {
        scheme = "Synced";
        password_style = "random";
        hide_logo = true;
      };
      cursor = {
        theme = "catppuccin-mocha-mauve-cursors";
        size = 24;
      };
    };
  };

  # Install the generated TOML with greeter ownership on each system activation.
  # Manual edits to this file are overwritten on the next activation.
  system.activationScripts.noctaliaGreeterFix = ''
    mkdir -p /var/lib/noctalia-greeter
    chown greeter:greeter /var/lib/noctalia-greeter 2>/dev/null || true
    chmod 0750 /var/lib/noctalia-greeter 2>/dev/null || true

    install -D -o greeter -g greeter -m 0644 ${greeterToml} /var/lib/noctalia-greeter/greeter.toml
  '';
}
