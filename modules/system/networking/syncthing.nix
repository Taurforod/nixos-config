{...}: {
  services.syncthing = {
    enable = true;
    systemService = true;

    user = "taurforod";
    group = "users";

    configDir = "/home/taurforod/.config/syncthing";
    guiAddress = "127.0.0.1:8384";

    overrideDevices = false;
    overrideFolders = false;
  };
}
