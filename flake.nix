{
  description = "My multihosts configuration NixOS.";

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
          inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
        };

    noctalia-greeter = {
          url = "github:noctalia-dev/noctalia-greeter";
          inputs.nixpkgs.follows = "nixpkgs"; # Чтобы он использовал те же системные пакеты, что и вся система
        };
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, noctalia, noctalia-greeter,... }@inputs:
    # Please replace nixosConfigurations.your-name with your hostname
    let
      system = "x86_64-linux";

      # Создаем экземпляр нестабильного nixpkgs
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      # Функция-помощник для сборки хоста (избавляет от дублирования кода!)
      mkHost = hostname:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs pkgs-unstable; };
          modules = [
            # 1. Специфика железа конкретного хоста
            ./hosts/${hostname}/default.nix

            # 2. Общая системная база
            ./modules/system/core.nix

            # 3. Подключение Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.extraSpecialArgs = { inherit inputs pkgs-unstable; };
              home-manager.users.taurforod = {
                imports = [
                  ./modules/home/common.nix # Общий конфиг для всех
                  ./hosts/${hostname}/home.nix # Специфика этого хоста
                ];
              };
            }
          ];
        };
    in
      {
        nixosConfigurations = {
          katana = mkHost "katana";
          thinkpadx13  = mkHost "thinkpadx13";
          desktop = mkHost "desktop";
        };
      };
}
