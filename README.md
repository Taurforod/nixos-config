# NixOS configuration

My personal NixOS and Home Manager configuration for three
`x86_64-linux` machines.

The configuration uses Nix flakes, Niri with Noctalia, and KDE Plasma 6.
Most packages come from NixOS 26.05, with selected applications and
kernels taken from a separately pinned unstable input.

## Hosts

| Host          | Hardware                                       | Configuration                                                                                                          |
| ------------- | ---------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| `desktop`     | AMD Ryzen 9 5900X, NVIDIA GeForce RTX 3080 Ti  | Zen kernel from unstable, NVIDIA open kernel modules, three-monitor layout, Docker, CUDA-enabled Ollama, CoolerControl |
| `katana`      | MSI Katana 15 B13VFK                           | Latest kernel from unstable, Intel/NVIDIA PRIME render offload, laptop lid handling                                    |
| `thinkpadx13` | Lenovo ThinkPad X13 Gen 2, 13-inch Intel model | Latest kernel from stable nixpkgs, Intel graphics, laptop lid handling                                                 |

All hosts use systemd-boot and include both Niri and Plasma.

Niri display layouts are configured separately for each host:

- **desktop:** three 2560×1440 monitors at 1.25 scaling.
- **katana:** 1920×1080 at approximately 60 Hz, with 1.25 scaling.
- **thinkpadx13:** 1920×1200 at approximately 60 Hz, with 1.35 scaling.

These are configured display modes, not a list of hardware limits.

## Desktop and applications

- **Wayland desktop:** Niri and Noctalia.
- **Alternative desktop:** KDE Plasma 6.
- **Login screen:** Noctalia Greeter with greetd.
- **Appearance:** Stylix, Catppuccin Mocha, Kora icons,
  and Catppuccin cursors.
- **Terminal:** Kitty, Fish, Starship, Yazi, and Fastfetch.
- **Development:** Zed, Godot, direnv, nix-direnv, nixd,
  Alejandra, and Codex.
- **Audio and media:** PipeWire, EasyEffects, and mpv.
- **Gaming:** Steam, GameMode, Gamescope, MangoHud,
  Heroic, Lutris, and ProtonPlus.
- **Connectivity:** NetworkManager, Bluetooth, Syncthing,
  and ZeroTier.

The desktop additionally includes applications for graphics,
recording, CAD, and 3D printing.

System-wide Flatpak applications include Calibre, Discord,
Flatseal, Spotify, and OnlyOffice.

## Repository layout

```text
.
├── flake.nix               # Inputs and host composition
├── flake.lock              # Pinned input revisions
├── hosts/
│   ├── desktop/
│   ├── katana/
│   └── thinkpadx13/
├── modules/
│   ├── hardware/           # NVIDIA and PRIME configuration
│   ├── system/             # Shared NixOS modules and services
│   └── home/               # Home Manager applications and settings
└── assets/
    ├── fastfetch/
    └── wallpapers/
```

Each host contains:

- `default.nix`: host-specific NixOS settings and imports;
- `hardware-configuration.nix`: filesystems and hardware settings;
- `home.nix`: host-specific Home Manager settings.

`mkHost` in `flake.nix` combines the selected host with the shared
system configuration and Home Manager.

Home Manager runs as a NixOS module and uses the system package set.
There are no standalone `homeConfigurations` outputs.

The custom Home Manager option `myNiri.displayConfig` supplies
host-specific display settings to the shared Niri configuration.
Noctalia settings are selected by hostname from
`modules/home/wm/noctalia/settings-<hostname>.toml`.

## Package sources

- `nixpkgs`: NixOS 26.05.
- `nixpkgs-unstable`: selected applications and kernels.
- `home-manager`: the matching 26.05 release branch.
- Stylix, Noctalia, and Noctalia Greeter: separate flake inputs.

`flake.lock` records the exact revisions used by the configuration.

Flatpak applications and Firefox extensions installed through
download policies are managed outside the Nix lock file.
Their versions are not pinned by `flake.lock`.

## Validation and builds

Run commands from the repository root.

Evaluate the flake without building systems or updating the lock file:

```sh
nix flake check --no-build --no-write-lock-file
```

Evaluate a specific host:

```sh
nix eval --raw --no-write-lock-file \
  .#nixosConfigurations.desktop.config.system.build.toplevel.drvPath
```

Build a host without activating it or creating a `result` link:

```sh
nix build --no-link --no-write-lock-file \
  .#nixosConfigurations.desktop.config.system.build.toplevel
```

Replace `desktop` with `katana` or `thinkpadx13` as needed.

Successful evaluation does not guarantee that every package builds
or that hardware works correctly after boot.

## Adapting this configuration

This repository contains settings for my own machines.

Before reusing it:

1. Review the username in `flake.nix`, the locale, and the timezone.
2. Supply hardware configuration for your own installation.
3. Review filesystem UUIDs, additional mounts, and mount ownership.
4. Check NVIDIA PRIME PCI bus IDs where applicable.
5. Adjust Niri output names, modes, and scaling.
6. Update Noctalia wallpaper paths and monitor assignments.
7. Set up account credentials separately; passwords are not
   provisioned by this repository.

The current username is `taurforod`, the locale is `ru_RU.UTF-8`,
and the timezone is `Europe/Oslo`.

Several settings expect the checkout at `~/nixos-config`.
The desktop's Noctalia settings also reference wallpapers under
`~/Загрузки/wallpapir`.

The Fish `rebuild` helper uses `~/nixos-config` and switches the
local machine to the selected host configuration. Its host argument
selects a configuration; it does not deploy to a remote machine.

To add a host, create its host files, register it in
`nixosConfigurations`, and provide the matching Noctalia settings file.

Keep `system.stateVersion` and `home.stateVersion` tied to the
installation's compatibility baseline. They are not package-version
selectors and should not be changed during routine updates.

## State outside Nix

Some application state remains outside this repository:

- Syncthing devices and folders are managed through its local web UI.
- ZeroTier has no networks declared by default.
- Flatpak apps are installed by a boot service and updated weekly.
  Removing an app from the list does not uninstall it.
- Noctalia can store UI overrides and runtime state separately.
- EasyEffects preset files are included, but automatic preset loading
  is not configured.
- Application accounts, credentials, and personal data require
  separate setup or restoration.

Wallpapers and other artwork retain their respective authors' rights.
