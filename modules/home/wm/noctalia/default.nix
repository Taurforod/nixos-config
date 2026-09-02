{ osConfig, ... }:

{
  xdg.configFile."noctalia/config.toml".source = ./. + "/settings-${osConfig.networking.hostName}.toml";
}
