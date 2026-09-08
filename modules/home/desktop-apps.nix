{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages =
    (with pkgs; [
      # Обслуживание дисков и ПК
      gsmartcontrol # Графический интерфейс для проверки S.M.A.R.T. дисков
      liquidctl # Управление СЖО (водянками), помпой и RGB на ПК

      #Media and Grafick
      obs-studio
      strawberry
      gimp
      blender
      freecad
    ])
    ++ (with pkgs-unstable; [
      # Творчество и софт ПК
      orca-slicer # Слайсер для 3D-принтера
    ]);
}
