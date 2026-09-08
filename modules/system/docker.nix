{username, ...}: {
  # 1. Включаем демона Docker
  virtualisation.docker.enable = true;

  # 2. Добавляем пользователя в группу docker
  users.users.${username} = {
    extraGroups = ["docker"]; # просто добавьте "docker" к вашим группам
  };
}
