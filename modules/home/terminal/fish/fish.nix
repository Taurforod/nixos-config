{...}: {
  programs.fish = {
    enable = true;

    # Срабатывает ТОЛЬКО при открытии интерактивного терминала
    interactiveShellInit = ''
      set -g fish_greeting ""
      fastfetch               # Выводим инфо о системе при старте
    '';

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      tree = "eza --tree --icons";
    };

    functions = {
      rebuild = ''
        set -l host $argv[1]
        test -z "$host"; and set host (hostname)

        nh os switch $HOME/nixos-config -H $host
      '';
    };
  };
}
