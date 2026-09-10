{
  description = "My multihosts configuration NixOS.";

  # Input URLs select upstream sources; flake.lock pins their exact revisions.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    stylix.url = "github:danth/stylix";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # Reuse the root nixpkgs input.
    };

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs"; # Reuse the root nixpkgs input.
    };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    noctalia,
    noctalia-greeter,
    ...
  } @ inputs: let
    # Shared architecture and login name for all hosts.
    system = "x86_64-linux";
    username = "taurforod";

    # Separate package set for modules that explicitly select unstable packages.
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };

    # Combine host settings, shared NixOS modules, and Home Manager.
    mkHost = hostname:
      nixpkgs.lib.nixosSystem {
        inherit system;

        # Additional arguments available to NixOS modules.
        specialArgs = {inherit inputs pkgs-unstable username;};
        modules = [
          # Host-specific NixOS settings, including hardware configuration.
          ./hosts/${hostname}/default.nix

          # Shared NixOS settings for all hosts.
          ./modules/system/core.nix

          # Apply the user's Home Manager configuration with the NixOS configuration.
          home-manager.nixosModules.home-manager
          {
            # Use the NixOS package set and its package configuration in Home Manager.
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Back up existing files that would otherwise conflict with managed files.
            home-manager.backupFileExtension = "hm-backup";

            # Home Manager modules receive their additional arguments separately.
            home-manager.extraSpecialArgs = {inherit inputs pkgs-unstable username;};
            home-manager.users.${username} = {
              imports = [
                ./modules/home/common.nix # Shared user settings.
                ./hosts/${hostname}/home.nix # Host-specific user settings.
              ];
            };
          }
        ];
      };
  in {
    # To add a host, create hosts/<name>/{default,home}.nix and register it below.
    # The mkHost argument must match the host directory name.
    nixosConfigurations = {
      katana = mkHost "katana";
      thinkpadx13 = mkHost "thinkpadx13";
      desktop = mkHost "desktop";
    };
  };
}
