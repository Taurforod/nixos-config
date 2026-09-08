{
  config,
  username,
  ...
}: {
  services.syncthing = {
    enable = true;
    systemService = true;

    user = username;
    group = "users";

    configDir = "${config.users.users.${username}.home}/.config/syncthing";
    guiAddress = "127.0.0.1:8384";

    overrideDevices = false;
    overrideFolders = false;
  };
}
