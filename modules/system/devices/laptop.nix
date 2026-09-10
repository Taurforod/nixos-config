{...}: {
  services.logind.settings.Login = {
    # Suspend on lid close when neither the external-power nor docked rule applies.
    HandleLidSwitch = "suspend";

    # Lock on lid close while connected to external power.
    HandleLidSwitchExternalPower = "lock";

    # Ignore lid close when docked or when multiple displays are connected.
    HandleLidSwitchDocked = "ignore";
  };
}
