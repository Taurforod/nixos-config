{...}: {
  services.logind.settings.Login = {
    # От батареи: переход в сон.
    HandleLidSwitch = "suspend";

    # От сети: блокировка экрана без перехода в сон.
    HandleLidSwitchExternalPower = "lock";

    # С внешним монитором или в док-станции: продолжать работу.
    HandleLidSwitchDocked = "ignore";
  };
}
