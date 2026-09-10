# Katana-specific hybrid graphics settings; import alongside ./nvidia.nix.
{config, ...}: {
  hardware.nvidia = {
    # Enable runtime power management so the NVIDIA GPU can suspend when idle.
    powerManagement.finegrained = true;

    prime = {
      offload = {
        enable = true;

        # Provide `nvidia-offload <command>` to run an application on the NVIDIA GPU.
        enableOffloadCmd = true;
      };

      # Katana GPU addresses; verify with `lspci -D` before reusing on another host.
      # These PCI bus IDs use decimal numbers; lspci displays hexadecimal numbers.
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
