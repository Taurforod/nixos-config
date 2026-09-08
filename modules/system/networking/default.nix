{...}: {
  imports = [
    ./syncthing.nix
    ./zerotierone.nix
  ];

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  programs.mtr.enable = true;
}
