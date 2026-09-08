{...}: {
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      # "xxxxxxxxxxxxxxxx" # Сюда можно сразу вписать ID вашей сети (опционально)
    ];
  };
}
