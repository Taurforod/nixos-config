{...}: {
  imports = [
    ./audio.nix
    ./printers.nix
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.fwupd.enable = true;
}
