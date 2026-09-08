{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = false;

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  environment.sessionVariables.XDG_MENU_PREFIX = "plasma-";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    okular
  ];

  environment.systemPackages = [
    pkgs.kdePackages.kservice
  ];

  systemd.user.sockets."drkonqi-coredump-launcher" = {
    unitConfig.ConditionEnvironment = "XDG_CURRENT_DESKTOP=KDE";
  };
}
