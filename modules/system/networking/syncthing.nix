{
  config,
  username,
  ...
}: {
  services.syncthing = {
    enable = true;

    # Run as a system service under the configured user account.
    systemService = true;

    user = username;
    group = "users";

    configDir = "${config.users.users.${username}.home}/.config/syncthing";

    # Keep the web interface accessible only through the local loopback address.
    guiAddress = "127.0.0.1:8384";

    # Preserve devices and folders added through the web interface.
    overrideDevices = false;
    overrideFolders = false;
  };
}
