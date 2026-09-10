{...}: {
  programs.fish = {
    enable = true;

    # Hide the greeting and show system information in interactive Fish shells.
    interactiveShellInit = ''
      set -g fish_greeting ""
      fastfetch
    '';

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      tree = "eza --tree --icons";
    };

    functions = {
      # Usage: rebuild [host]; defaults to the current hostname.
      # Builds and switches this machine using the checkout at ~/nixos-config.
      rebuild = ''
        set -l host $argv[1]
        test -z "$host"; and set host (hostname)

        nh os switch $HOME/nixos-config -H $host
      '';
    };
  };
}
