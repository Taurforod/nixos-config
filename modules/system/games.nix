{...}: {
  programs.steam = {
    enable = true;
  };

  # Allow games to request temporary performance tuning through GameMode.
  programs.gamemode.enable = true;

  hardware.steam-hardware.enable = true;

  hardware.xone.enable = true; # Xbox accessories over USB, including the wireless adapter.
  hardware.xpadneo.enable = true; # Xbox controllers over Bluetooth.
}
