# Desktop-only applications; imported by hosts/desktop/home.nix.
{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages =
    (with pkgs; [
      # Disk and hardware maintenance.
      gsmartcontrol # GUI for drive S.M.A.R.T. diagnostics.
      liquidctl # Control supported liquid coolers, fans, and RGB lighting.

      # Media, graphics, and CAD.
      obs-studio
      strawberry
      gimp
      blender
      freecad
    ])
    ++ (with pkgs-unstable; [
      orca-slicer # Slicer for 3D printing.
    ]);
}
