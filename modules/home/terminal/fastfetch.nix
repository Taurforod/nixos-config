{...}: let
  boxTop = {
    type = "custom";
    format = "┌───────────────────────────────────────────────────────┐";
  };
  boxBottom = {
    type = "custom";
    format = "└───────────────────────────────────────────────────────┘";
  };
in {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "${../../../assets/fastfetch/On-an-Open-Bonfire.png}";
        # Display the logo through the Kitty graphics protocol.
        type = "kitty";
        width = 32;
        height = 16;
        padding = {
          top = 1;
          left = 2;
          right = 4;
        };
      };

      display.separator = " : ";

      modules = [
        # System and software.
        boxTop
        {
          type = "chassis";
          key = "  󰇺 Chassis";
          format = "{1} {2} {3}";
        }
        {
          type = "os";
          key = "  󰣇 OS";
          format = "{2}";
          keyColor = "red";
        }
        {
          type = "kernel";
          key = "   Kernel";
          format = "{2}";
          keyColor = "red";
        }
        {
          type = "packages";
          key = "  󰏗 Packages";
          keyColor = "green";
        }
        {
          type = "display";
          key = "  󰍹 Display";
          format = "{1}x{2} @ {3}Hz [{7}]";
          keyColor = "green";
        }
        {
          type = "terminal";
          key = "   Terminal";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "  󱗃 WM";
          format = "{2}";
          keyColor = "yellow";
        }
        boxBottom

        "break"

        # User and host.
        {
          type = "title";
          key = "  ";
          format = "{6} {7} {8}";
        }

        # Hardware and resources.
        boxTop
        {
          type = "cpu";
          key = "   CPU";
          format = "{1} @ {7}";
          keyColor = "blue";
        }
        {
          type = "gpu";
          key = "  󰊴 GPU";
          format = "{1} {2}";
          keyColor = "blue";
        }
        {
          type = "gpu";
          key = "   GPU Driver";
          format = "{3}";
          keyColor = "magenta";
        }
        {
          type = "sound";
          key = "  󰓃 Sound";
          format = "{name}";
          keyColor = "34";
        }
        {
          type = "memory";
          key = "   Memory ";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "  󱦟 OS Age ";
          folders = "/";
          format = "{days} days";
          keyColor = "red";
        }
        {
          type = "uptime";
          key = "  󱫐 Uptime ";
          keyColor = "red";
        }
        boxBottom

        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
        "break"
      ];
    };
  };
}
