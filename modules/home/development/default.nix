{ pkgs, ... }:

{
  imports = [
    ./direnv.nix
    ./godot.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    nvd
  ];
}
