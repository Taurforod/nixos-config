{osConfig, ...}: {
  # Select settings using the NixOS hostname.
  # Add a matching settings-<hostname>.toml when introducing a new host.
  xdg.configFile."noctalia/config.toml".source = ./. + "/settings-${osConfig.networking.hostName}.toml";
}
