{ ... }: {
  services.ollama = {
    enable = true;
    acceleration = "cuda"; # Тяжелые зависимости CUDA пойдут только на ПК
  };
}
