{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;

  # Login is handled by the Noctalia greeter configured in greeter.nix.
  services.displayManager.sddm.enable = false;

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  # Select Plasma's application menu definitions, including outside a Plasma session.
  environment.sessionVariables.XDG_MENU_PREFIX = "plasma-";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    okular
  ];

  environment.systemPackages = [
    pkgs.kdePackages.kservice
  ];

  # Start the KDE crash-reporting socket only in a KDE session.
  systemd.user.sockets."drkonqi-coredump-launcher" = {
    unitConfig.ConditionEnvironment = "XDG_CURRENT_DESKTOP=KDE";
  };
}
