{...}: {
  # PipeWire provides audio, including the PulseAudio-compatible server below.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Support 32-bit ALSA applications, including games.
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true; # Manage audio devices and routing.
  };
}
