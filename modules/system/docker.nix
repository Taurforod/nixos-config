{username, ...}: {
  virtualisation.docker.enable = true;

  # Extend the account from core.nix with access to the Docker daemon.
  users.users.${username} = {
    extraGroups = ["docker"];
  };
}
